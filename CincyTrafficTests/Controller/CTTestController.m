//
//  CTTestController.m
//  CincyTraffic
//
//  Created by Chris Moore on 8/25/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTTestController.h"
#import "KIFTestScenario+CTAdditions.h"

@implementation CTTestController

- (void)initializeScenarios;
{
    [self addScenario:[KIFTestScenario loadCamerasWithSettingsScreen]];
    [self addScenario:[KIFTestScenario viewCameraMap]];
}

@end
