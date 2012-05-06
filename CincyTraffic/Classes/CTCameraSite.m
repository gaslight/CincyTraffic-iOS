//
//  CTCameraSite.m
//  CincyTraffic
//
//  Created by Chris Moore on 5/5/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTCameraSite.h"
#import "RKObjectManager.h"

@implementation CTCameraSite
@synthesize location, latitude, longitude, cameraFeeds;

+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[CTCameraSite class]];
    //[mapping mapAttributes:@"location", @"latitude", @"longitude", @"cameraFeeds", nil];
    [mapping mapKeyPath:@"Location" toAttribute:@"location"];
    [mapping mapKeyPath:@"Latitude" toAttribute:@"latitude"];
    [mapping mapKeyPath:@"Longitude" toAttribute:@"longitude"];
    return mapping;
}

@end
