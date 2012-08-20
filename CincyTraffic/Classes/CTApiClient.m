//
//  CTApiClient.m
//  CincyTraffic
//
//  Created by Chris Moore on 8/15/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTApiClient.h"

@implementation CTApiClient

+ (NSURL *)apiBaseURL
{
    NSDictionary* env = [[NSProcessInfo processInfo] environment];
    NSString *url = [env valueForKey:@"BUCKEYE_TRAFFIC_API_URL"];
    if (!url) url = @"http://www.buckeyetraffic.org/services/";
    return [NSURL URLWithString:url];
}

+ (id)sharedInstance
{
    static CTApiClient *__sharedInstance;
    static dispatch_once_t p = 0;

    dispatch_once(&p, ^{
        __sharedInstance = [[CTApiClient alloc] initWithBaseURL:[self apiBaseURL]];
    });

    return __sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [AFXMLRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/plain", nil]];
        [self registerHTTPOperationClass:[AFXMLRequestOperation class]];
    }

    return self;
}

@end
