//
//  CTCameraSite.m
//  CincyTraffic
//
//  Created by Chris Moore on 5/5/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTCameraSite.h"
#import "CTCameraFeed.h"
#import "XMLDictionary.h"

@implementation CTCameraSite
@synthesize description, latitude, longitude, cameraFeeds;

- (CTCameraSite *)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.cameraFeeds = [[NSMutableArray alloc] init];
        self.description = [dictionary objectForKey:@"Location"];
        self.latitude = [dictionary objectForKey:@"Latitude"];
        self.longitude = [dictionary objectForKey:@"Longitude"];
        
        NSDictionary *feeds = [dictionary valueForKeyPath:@"CameraFeeds.CameraFeed"];
        if ([feeds isKindOfClass:[NSArray class]]) {
            for (NSDictionary *feed in feeds) {
                CTCameraFeed *cameraFeed = [[CTCameraFeed alloc] initWithDictionary:feed];
                [self.cameraFeeds addObject:cameraFeed];
            }
        } else {
            CTCameraFeed *feed = [[CTCameraFeed alloc] initWithDictionary:feeds];
            [self.cameraFeeds addObject:feed];
        }
    }

    return self;
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
