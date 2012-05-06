//
//  CTCamerasViewController.h
//  CincyTraffic
//
//  Created by Chris Moore on 5/1/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKObjectManager.h"

@interface CTCamerasViewController : UITableViewController <RKObjectLoaderDelegate> {
    NSMutableArray* _cameras;
}

@property (strong, nonatomic) NSMutableArray *cameras;
@end
