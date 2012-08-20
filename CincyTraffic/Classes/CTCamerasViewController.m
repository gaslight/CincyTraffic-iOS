//
//  CTCamerasViewController.m
//  CincyTraffic
//
//  Created by Chris Moore on 5/1/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTCamerasDataModel.h"
#import "XMLDictionary.h"
#import "CTApiClient.h"
#import "CTCamerasViewController.h"
#import "CTCameraViewController.h"
#import "CameraSite.h"
#import "CameraFeed.h"

@interface CTCamerasViewController()
@property (nonatomic, retain) NSArray *allCameras;
@end

@implementation CTCamerasViewController

@synthesize searchBar = _searchBar;
@synthesize cameras = _cameras;
@synthesize allCameras;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cameras = [NSMutableArray array];
    
    NSString *documentsDirectory = nil;
    documentsDirectory = [[NSBundle mainBundle] resourcePath];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"cameras.xml"];
    [self loadCamerasFromXML:[NSDictionary dictionaryWithXMLFile:path]];
}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showCameraDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        [[segue destinationViewController] setCamera:[self.cameras objectAtIndex:indexPath.row]];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cameras count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cameraCell";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:CellIdentifier];
    }

    CameraSite *camera = [self.cameras objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = camera.desc;
    
    return cell;
}

#pragma mark - Cameras

- (IBAction)loadCameras:(id)sender {
    [[CTApiClient sharedInstance] getPath:@"Cameras.aspx" parameters:nil
                                  success:^(AFHTTPRequestOperation *operation, id response) {
                                      NSDictionary *cameraXML = [NSDictionary dictionaryWithXMLString:operation.responseString];
                                      [self loadCamerasFromXML:cameraXML];
                                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                      NSLog(@"Error fetching cameras!");
                                      NSLog(@"%@", error);
                                  }];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)loadCamerasFromXML:(NSDictionary *)cameraXML
{
    NSManagedObjectContext *context = [[CTCamerasDataModel sharedDataModel] mainContext];
    if (context) {
        NSLog(@"Context is ready!");

        NSFetchRequest *allCameraSites = [[NSFetchRequest alloc] init];
        [allCameraSites setEntity:[NSEntityDescription entityForName:@"CameraSite" inManagedObjectContext:context]];
        [allCameraSites setIncludesPropertyValues:NO]; //only fetch the managedObjectID

        NSError *error = nil;
        NSArray *cameras = [context executeFetchRequest:allCameraSites error:&error];

        for (NSManagedObject *camera in cameras) {
            [context deleteObject:camera];
        }
        NSError *saveError = nil;
        [context save:&saveError];
        saveError = nil;
        cameras = nil;
        allCameraSites = nil;

        for (NSDictionary *cameraDictionary in [cameraXML valueForKeyPath:@"CameraSite"]) {
            CameraSite *cameraSite = [CameraSite insertInManagedObjectContext:context];
            [cameraSite updateAttributes:cameraDictionary];
            NSDictionary *foundFeeds = [cameraDictionary valueForKeyPath:@"CameraFeeds.CameraFeed"];

            if ([foundFeeds isKindOfClass:[NSArray class]]) {
                for (NSDictionary *feed in foundFeeds) {
                    CameraFeed *cameraFeed = [CameraFeed insertInManagedObjectContext:context];
                    [cameraFeed updateAttributes:feed];
                    [cameraSite addCameraFeedsObject:cameraFeed];
                }
            } else {
                CameraFeed *cameraFeed = [CameraFeed insertInManagedObjectContext:context];
                [cameraFeed updateAttributes:foundFeeds];
                [cameraSite addCameraFeedsObject:cameraFeed];
            }

            [context save:&error];
            if (error) {
                NSLog(@"uh oh.");
            }
            [self.cameras addObject:cameraSite];
        }
    } else {
        NSLog(@"Context is nil ;(");
    }

    self.allCameras = [NSArray arrayWithArray:self.cameras];
    [self.tableView reloadData];
}

#pragma mark - Search bar

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K like[cd] %@", @"description", [NSString stringWithFormat:@"*%@*", searchText]];
    [self.cameras filterUsingPredicate:predicate];
    [self.tableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.cameras removeAllObjects];
    [self.cameras addObjectsFromArray:self.allCameras];
    
    searchBar.text = nil;
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
        
    [self.tableView reloadData];
}

@end
