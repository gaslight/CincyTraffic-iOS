//
//  CTMapViewController.m
//  CincyTraffic
//
//  Created by Chris Moore on 8/10/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTCamerasViewController.h"
#import "CTMapViewController.h"
#import "CTCameraAnnotation.h"

@interface CTMapViewController ()

@end

@implementation CTMapViewController
@synthesize mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    CLLocationCoordinate2D location;
	location.latitude = (double) 51.501468;
	location.longitude = (double) -0.141596;
    
    CTCameraAnnotation *newAnnotation = [[CTCameraAnnotation alloc] initWithCoordinate:location];
	[self.mapView addAnnotation:newAnnotation];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
