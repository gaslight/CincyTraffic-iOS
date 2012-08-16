//
//  CTApiClient.h
//  CincyTraffic
//
//  Created by Chris Moore on 8/15/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface CTApiClient : AFHTTPClient
+(id)sharedInstance;
-(CTApiClient *)initWithBaseURL:(NSURL *)url;
@end
