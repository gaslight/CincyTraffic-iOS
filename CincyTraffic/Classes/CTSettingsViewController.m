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
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
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
    [self setProgressBar:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doDoneButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)reloadCamerasButtonClicked:(id)sender {
    [self.progressBar setHidden:NO];
    [self.progressBar setProgress:0 animated:NO];

    void (^progressBlock)(float) = ^(float progress) {
        [self.progressBar setProgress:progress animated:YES];
        if (progress >= 1) {
            [self.progressBar setHidden:YES];
            [self.tableView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"camerasReloaded"
                                                                object:self];
           [TestFlight passCheckpoint:@"Cameras_Reloaded"];
        }
    };
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [CameraSite loadCamerasFromLocalXMLWithProgressBlock:progressBlock];
    });
    
    
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
    NSManagedObjectContext *context = [[CTCamerasDataModel sharedDataModel] mainContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setIncludesPropertyValues:NO];

    NSError *error = nil;

    if (indexPath.row == 0) {
        static NSString *CellIdentifier = @"sitesCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:CellIdentifier];
        }

        [fetchRequest setEntity:[NSEntityDescription entityForName:@"CameraSite" inManagedObjectContext:context]];

        NSUInteger count = [context countForFetchRequest:fetchRequest error:&error];
        NSString *countString = NSLocalizedString(@"countString", nil);

        cell.textLabel.text = NSLocalizedString(@"CameraSites", @"Camera site");
        cell.detailTextLabel.text = [NSString stringWithFormat:countString, count];
    } else {
        static NSString *CellIdentifier = @"feedsCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:CellIdentifier];
        }

        [fetchRequest setEntity:[NSEntityDescription entityForName:@"CameraFeed" inManagedObjectContext:context]];

        NSUInteger count = [context countForFetchRequest:fetchRequest error:&error];
        NSString *countString = NSLocalizedString(@"countString", nil);

        cell.textLabel.text = NSLocalizedString(@"CameraFeeds", @"Camera site");
        cell.detailTextLabel.text = [NSString stringWithFormat:countString, count];
    }

    return cell;
}

@end
