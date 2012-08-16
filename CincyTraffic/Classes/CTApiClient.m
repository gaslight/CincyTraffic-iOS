//
//  CTApiClient.m
//  CincyTraffic
//
//  Created by Chris Moore on 8/15/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTApiClient.h"

#define BuckeyeTrafficBaseURLString @"http://www.buckeyetraffic.org/services/"

@implementation CTApiClient

+ (id)sharedInstance
{
    static CTApiClient *__sharedInstance;
    static dispatch_once_t p = 0;

    dispatch_once(&p, ^{
        __sharedInstance = [[CTApiClient alloc] initWithBaseURL:[NSURL URLWithString:BuckeyeTrafficBaseURLString]];
    });

    return __sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFXMLRequestOperation class]];
        
    }

    return self;
}
@end
