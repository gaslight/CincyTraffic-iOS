//
//  CTCamerasViewController.m
//  CincyTraffic
//
//  Created by Chris Moore on 5/1/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "TDBadgedCell.h"
#import "XMLDictionary.h"
#import "CTApiClient.h"
#import "CTCamerasViewController.h"
#import "CTCameraViewController.h"
#import "CTCameraSite.h"

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
    [self loadCameras:nil];
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
    if ([[segue identifier] isEqualToString:@"ShowCameraDetail"]) {
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
    static NSString *CellIdentifier = @"CameraCell";
    TDBadgedCell *cell = (TDBadgedCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell) {
        cell = [[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    CTCameraSite *camera = [self.cameras objectAtIndex:indexPath.row];
    cell.textLabel.text = camera.description;
    cell.badgeString = [NSString stringWithFormat:@"%d", camera.cameraFeeds.count];
    
    return cell;
}

#pragma mark - Cameras

- (IBAction)loadCameras:(id)sender {
    self.cameras = [NSMutableArray array];
    [[CTApiClient sharedInstance] getPath:@"Cameras.aspx" parameters:nil
                                  success:^(AFHTTPRequestOperation *operation, id response) {
                                      NSDictionary *cameraXML = [NSDictionary dictionaryWithXMLString:operation.responseString];
                                      [self loadCamerasFromXML:cameraXML];
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"Error fetching cameras!");
                                      NSLog(@"%@", error);
                                  }];
}

- (void)loadCamerasFromXML:(NSDictionary *)cameraXML
{
    for (NSDictionary *cameraDictionary in [cameraXML valueForKeyPath:@"CameraSite"]) {
        CTCameraSite *cameraSite = [[CTCameraSite alloc] initWithDictionary:cameraDictionary];
        [self.cameras addObject:cameraSite];
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
