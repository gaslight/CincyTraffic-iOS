//
//  CTCameraSite.m
//  CincyTraffic
//
//  Created by Chris Moore on 5/5/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTCameraSite.h"
#import "CTCameraFeed.h"

@implementation CTCameraSite
@synthesize description, latitude, longitude, cameraFeeds;

- (CLLocation *)location
{
    return [[CLLocation alloc] initWithLatitude:[self.latitude floatValue]
                                      longitude:[self.longitude floatValue]];
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([self.latitude floatValue],
                                                              [self.longitude floatValue]);
    return coord;
}
@end
