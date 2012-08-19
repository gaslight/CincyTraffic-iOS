//
//  CTLocationManager.h
//  CincyTraffic
//
//  Created by Chris Moore on 8/17/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CTLocationManager : NSObject <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager* locationManager;

+ (CTLocationManager *)sharedSingleton;
@end
