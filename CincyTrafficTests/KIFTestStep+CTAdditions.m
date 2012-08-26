//
//  KIFTestStep+CTAdditions.m
//  CincyTraffic
//
//  Created by Chris Moore on 8/25/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "KIFTestStep+CTAdditions.h"

@implementation KIFTestStep (CTAdditions)

+ (id)stepToReset;
{
    return [KIFTestStep stepWithDescription:@"Reset the application state." executionBlock:^(KIFTestStep *step, NSError **error) {
        BOOL successfulReset = YES;

        // Do the actual reset for your app. Set successfulReset = NO if it fails.

        KIFTestCondition(successfulReset, error, @"Failed to reset the application.");

        return KIFTestStepResultSuccess;
    }];
}

@end
