//
//  CTCameraViewController.h
//  CincyTraffic
//
//  Created by Chris Moore on 5/2/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTCameraViewController : UIViewController
@property (nonatomic, strong) NSDictionary *camera;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@end
