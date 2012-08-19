//
//  CTLocationManager.m
//  CincyTraffic
//
//  Created by Chris Moore on 8/17/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTLocationManager.h"

@implementation CTLocationManager
@synthesize locationManager;

+ (CTLocationManager *)sharedSingleton {
    static CTLocationManager *sharedSingleton;
    if(!sharedSingleton) {
        @synchronized(sharedSingleton) {
            sharedSingleton = [CTLocationManager new];
        }
    }

    return sharedSingleton;
}

- (id)init {
    self = [super init];

    if(self) {
        self.locationManager = [CLLocationManager new];
        [self.locationManager setDelegate:self];
        [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
        [self.locationManager setHeadingFilter:kCLHeadingFilterNone];
        [self.locationManager startUpdatingLocation];
    }

    return self;
}

//- (void)locationManager:(CLLocationManager *)manager
//    didUpdateToLocation:(CLLocation *)newLocation
//           fromLocation:(CLLocation *)oldLocation {
//}
//
//- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
//}

@end

