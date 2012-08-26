//
//  CTSettingsViewController.m
//  CincyTraffic
//
//  Created by Chris Moore on 8/25/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTSettingsViewController.h"
#import "CTCamerasDataModel.h"
#import "CameraSite.h"

@interface CTSettingsViewController ()

@end

@implementation CTSettingsViewController
@synthesize reloadCamerasButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setReloadCamerasButton:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)reloadCamerasButtonClicked:(id)sender {
    [CameraSite loadCamerasFromLocalXML];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];

    if (indexPath.row == 0) {
        static NSString *CellIdentifier = @"sitesCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:CellIdentifier];
        }

        NSManagedObjectContext *context = [[CTCamerasDataModel sharedDataModel] mainContext];
        NSFetchRequest *allCameraSites = [[NSFetchRequest alloc] init];
        [allCameraSites setEntity:[NSEntityDescription entityForName:@"CameraSite" inManagedObjectContext:context]];
        [allCameraSites setIncludesPropertyValues:NO];
        NSError *error = nil;
        NSUInteger count = [context countForFetchRequest:allCameraSites error:&error];

        cell.textLabel.text = NSLocalizedString(@"CameraSites", @"Camera site");

        NSString *countString = NSLocalizedString(@"countString", nil);
        cell.detailTextLabel.text = [NSString stringWithFormat:countString, count];
    } else {
        static NSString *CellIdentifier = @"feedsCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:CellIdentifier];
        }

        NSManagedObjectContext *context = [[CTCamerasDataModel sharedDataModel] mainContext];
        NSFetchRequest *allFeeds = [[NSFetchRequest alloc] init];
        [allFeeds setEntity:[NSEntityDescription entityForName:@"CameraFeed" inManagedObjectContext:context]];
        [allFeeds setIncludesPropertyValues:NO];
        NSError *error = nil;
        NSUInteger count = [context countForFetchRequest:allFeeds error:&error];
        cell.textLabel.text = NSLocalizedString(@"CameraFeeds", @"Camera site");
        NSString *countString = NSLocalizedString(@"countString", nil);
        cell.detailTextLabel.text = [NSString stringWithFormat:countString, count];
    }

    return cell;
}

@end
