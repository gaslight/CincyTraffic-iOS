//
//  CTCamerasViewController.m
//  CincyTraffic
//
//  Created by Chris Moore on 5/1/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "TDBadgedCell.h"
#import "CTCamerasViewController.h"
#import "CTCameraViewController.h"
#import "CTCameraSite.h"

@implementation CTCamerasViewController

@synthesize searchBar = _searchBar;
@synthesize cameras = _cameras;
@synthesize tableData = _tableData;

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
        [[segue destinationViewController] setCamera:[self.tableData objectAtIndex:indexPath.row]];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CameraCell";
    TDBadgedCell *cell = (TDBadgedCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell) {
        cell = [[TDBadgedCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    CTCameraSite *camera = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.text = camera.description;
    cell.badgeString = [NSString stringWithFormat:@"%d", camera.cameraFeeds.count];
    
    return cell;
}

#pragma mark - Cameras

- (IBAction)loadCameras:(id)sender {
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/Cameras.aspx" delegate:self];
}

#pragma mark - RestKit

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    self.cameras = [NSMutableArray arrayWithArray:objects];
    self.tableData = [NSMutableArray arrayWithArray:objects];
    NSLog(@"table data: %d", self.tableData.count);
    NSLog(@"cameras: %d", self.cameras.count);
    [self.tableView reloadData];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    [[[UIAlertView alloc] initWithTitle:@"Network Error"
                                message:@"There was an issue connecting to the server."
                               delegate:self
                      cancelButtonTitle:@"Cancel"
                      otherButtonTitles:nil] show];
}

- (void)request:(RKRequest *)request didReceiveData:(NSInteger)bytesReceived
                                 totalBytesReceived:(NSInteger)totalBytesReceived 
                        totalBytesExpectedToReceive:(NSInteger)totalBytesExpectedToReceive {
    NSLog(@"bytes recieved: %d of %d", totalBytesReceived, totalBytesExpectedToReceive);
}

#pragma mark - Search bar

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.tableData = [[NSMutableArray alloc] initWithArray:self.cameras];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K like[cd] %@", @"description", [NSString stringWithFormat:@"*%@*", searchText]];
    [self.tableData filterUsingPredicate:predicate];
    [self.tableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.tableData = self.cameras;
    
    searchBar.text = nil;
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
    NSLog(@"table data: %d", self.tableData.count);
    NSLog(@"cameras: %d", self.cameras.count);
    
    [self.tableView reloadData];
}

@end
