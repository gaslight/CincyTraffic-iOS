//
//  CTCameraAnnotation.m
//  CincyTraffic
//
//  Created by Chris Moore on 5/2/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTCameraAnnotation.h"

@implementation CTCameraAnnotation
@synthesize cameraSite, title, subtitle;

- (id)initWithCameraSite:(CTCameraSite *)site
{
    self = [super init];
    if (self != nil) {
        self.cameraSite = site;
        self.title = self.cameraSite.description;
        self.subtitle = @"";
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate
{
    return self.cameraSite.coordinate;
}

@end
