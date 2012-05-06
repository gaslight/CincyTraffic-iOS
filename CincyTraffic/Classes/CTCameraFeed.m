//
//  CTCameraFeed.m
//  CincyTraffic
//
//  Created by Chris Moore on 5/5/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTCameraFeed.h"

@implementation CTCameraFeed
@synthesize direction = _direction,
            type = _type,
            description = _description,
            smallImageURL = _smallImageURL,
            largeImageURL = _largeImageURL,
            updateInterval = _updateInterval;

+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    [mapping mapKeyPathsToAttributes:@"direction", @"Direction",
                                     @"type", @"Type",
                                     @"description", @"Description",
                                     @"smallImageURL", @"SmallImage",
                                     @"largeImageURL", @"LargeImage",
                                     @"updateInterval", @"UpdateInterval", nil ];
    return mapping;
}
@end
