//
//  KIFTestScenario+CTAdditions.m
//  CincyTraffic
//
//  Created by Chris Moore on 8/25/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "KIFTestScenario+CTAdditions.h"
#import "KIFTestStep.h"
#import "KIFTestStep+CTAdditions.h"

@implementation KIFTestScenario (CTAdditions)
+ (id)scenarioToLogIn
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test that a user can successfully log in."];
    [scenario addStep:[KIFTestStep stepToReset]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Log In"]];

    // Verify that the login succeeded
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:@"Welcome"]];

    return scenario;
}

+ (id)viewCameraList
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"View the list of cameras"];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"I-275W"]];
    return scenario;
}

+ (id)viewCameraMap
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"View the list of cameras"];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Map"]];
    return scenario;
}

+ (id)loadCamerasWithSettingsScreen
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"View settings and manage cameras"];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Settings"]];
    [scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"Camera Sites"]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Update Cameras"]];

    [scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:@"222"]];
    return scenario;
}
@end
