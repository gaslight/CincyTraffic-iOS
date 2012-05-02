//
//  CTCamerasViewController.m
//  CincyTraffic
//
//  Created by Chris Moore on 5/1/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTCamerasViewController.h"
#import "CTCameraViewController.h"

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSDictionary *camera = [self.cameras objectAtIndex:indexPath.row];
    cell.textLabel.text = [camera objectForKey:@"Location"];
    cell.detailTextLabel.text = [camera objectForKey:@"State"];
    
    return cell;
}

#pragma mark - Cameras

- (void)loadCameras {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"Cameras" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSDictionary *jsonCameras = [NSJSONSerialization JSONObjectWithData:jsonData 
                                                            options:kNilOptions 
                                                              error:nil];
    
    self.cameras = [[jsonCameras objectForKey:@"poi"] objectForKey:@"cameras"];
    [self.tableView reloadData];
}

@end
