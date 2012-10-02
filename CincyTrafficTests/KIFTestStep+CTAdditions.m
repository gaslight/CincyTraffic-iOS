//
//  KIFTestStep+CTAdditions.m
//  CincyTraffic
//
//  Created by Chris Moore on 8/25/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "KIFTestStep+CTAdditions.h"
#import "CTCamerasDataModel.h"
#import "CameraSite.h"

@implementation KIFTestStep (CTAdditions)

+ (id)stepToReset;
{
    return [KIFTestStep stepWithDescription:@"Reset the application state." executionBlock:^(KIFTestStep *step, NSError **error) {
        BOOL successfulReset = YES;
        NSManagedObjectContext *context = [[CTCamerasDataModel sharedDataModel] mainContext];
        [CameraSite removeAllCamerasUsingContext:context];
        KIFTestCondition(successfulReset, error, @"Failed to reset the application.");
        return KIFTestStepResultSuccess;
    }];
}

@end
