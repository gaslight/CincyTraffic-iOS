//
//  CTCameraSite.m
//  CincyTraffic
//
//  Created by Chris Moore on 5/5/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CameraSite.h"
#import "CameraFeed.h"
#import "XMLDictionary.h"

@implementation CameraSite

- (void)updateAttributes:(NSDictionary *)dictionary
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];

    self.desc = [dictionary objectForKey:@"Location"];

    NSNumber *myNumber = [f numberFromString:[dictionary objectForKey:@"Latitude"]];
    self.latitude = myNumber;

    myNumber = [f numberFromString:[dictionary objectForKey:@"Longitude"]];
    self.longitude = myNumber;
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
