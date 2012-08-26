//
//  CTSettingsViewController.m
//  CincyTraffic
//
//  Created by Chris Moore on 8/25/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTSettingsViewController.h"

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
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"infoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text = NSLocalizedString(@"CameraSites", @"Camera site");
    cell.detailTextLabel.text = @"222";
    
    return cell;
}

@end
