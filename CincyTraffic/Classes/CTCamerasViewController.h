//
//  CTCamerasViewController.h
//  CincyTraffic
//
//  Created by Chris Moore on 5/1/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTCamerasViewController : UITableViewController <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *cameras;
@property (strong, nonatomic) NSMutableArray *tableData;

- (IBAction)refreshCamerasButtonClicked:(id)sender;
@end
