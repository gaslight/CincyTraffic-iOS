//
//  CTApiClientTest.m
//  CincyTraffic
//
//  Created by Chris Moore on 8/19/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTApiClientTest.h"
#import "CTApiClient.h"

@implementation CTApiClientTest

- (void)testApiBaseURL
{
    STAssertEqualObjects(@"cdmwebs.dev", [[CTApiClient apiBaseURL] host], @"");
}

- (void)testSharedInstance
{
    STAssertNotNil([CTApiClient sharedInstance], @"");
}

- (void)testInitWithBaseURL
{
    NSURL *base = [NSURL URLWithString:@"http://cdmwebs.dev"];
    CTApiClient *client = [[CTApiClient alloc] initWithBaseURL:base];
    STAssertEquals([client class], [CTApiClient class], @"");
}
@end
