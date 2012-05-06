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

@synthesize cameras = _cameras;

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
    [self loadCameras];
}

- (void)viewDidUnload
{
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
    cell.textLabel.text = camera.location;
    cell.badgeString = [NSString stringWithFormat:@"%d", camera.cameraFeeds.count];
    
    return cell;
}

#pragma mark - Cameras

- (void)loadCameras {
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/Cameras.aspx" delegate:self];
}

#pragma mark - RestKit

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    self.cameras = [NSMutableArray arrayWithArray:objects];
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
@end
