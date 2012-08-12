//
//  CTCameraSite.m
//  CincyTraffic
//
//  Created by Chris Moore on 5/5/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "RKObjectManager.h"
#import "CTCameraSite.h"
#import "CTCameraFeed.h"

@implementation CTCameraSite
@synthesize description, latitude, longitude, cameraFeeds;

+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[CTCameraSite class]];
    [mapping mapKeyPath:@"Location" toAttribute:@"description"];
    [mapping mapKeyPath:@"Latitude" toAttribute:@"latitude"];
    [mapping mapKeyPath:@"Longitude" toAttribute:@"longitude"];
    [mapping mapKeyPath:@"CameraFeeds.CameraFeed" toRelationship:@"cameraFeeds" 
            withMapping:[CTCameraFeed mapping]];
    return mapping;
}

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
