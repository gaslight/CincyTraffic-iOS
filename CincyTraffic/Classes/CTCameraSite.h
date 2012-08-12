//
//  CTCameraSite.h
//  CincyTraffic
//
//  Created by Chris Moore on 5/5/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>
#import "RKObjectMapping.h"

@interface CTCameraSite : NSObject

@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSNumber *latitude, *longitude;
@property (nonatomic, copy) NSMutableArray *cameraFeeds;

+ (RKObjectMapping *)mapping;
- (CLLocation *)location;
- (CLLocationCoordinate2D)coordinate;
@end
