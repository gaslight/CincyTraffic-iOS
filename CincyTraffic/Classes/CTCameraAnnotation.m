//
//  CTCameraAnnotation.m
//  CincyTraffic
//
//  Created by Chris Moore on 5/2/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTCameraAnnotation.h"

@implementation CTCameraAnnotation
@synthesize coordinate = _coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self != nil) {
        _coordinate = coordinate;
    }
    return self;
}

@end
