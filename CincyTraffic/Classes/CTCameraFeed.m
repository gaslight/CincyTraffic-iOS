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

- (CTCameraFeed *)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.direction = [dictionary objectForKey:@"Direction"];
        self.type = [dictionary objectForKey:@"Type"];
        self.description = [dictionary objectForKey:@"Description"];
        self.smallImageURL = [dictionary objectForKey:@"SmallImage"];
        self.largeImageURL = [dictionary objectForKey:@"LargeImage"];
        self.updateInterval = [dictionary objectForKey:@"ImageUpdateInterval"];
    }
    return self;
}
@end
