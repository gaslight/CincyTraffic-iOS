//
//  CTCameraViewController.m
//  CincyTraffic
//
//  Created by Chris Moore on 5/2/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import "CTCameraViewController.h"
#import "CTCameraAnnotation.h"
#import "CTCameraFeed.h"

@implementation CTCameraViewController
@synthesize webView, camera, mapView, geocoder, repeatingTimer;

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

    self.title = self.camera.description;
    
    for (CTCameraFeed *feed in self.camera.cameraFeeds) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:feed.smallImageURL]];
        if (feed) { [self.webView loadRequest:request]; }
        self.repeatingTimer = [NSTimer scheduledTimerWithTimeInterval:[feed.updateInterval floatValue]
                                                 target:self
                                               selector:@selector(timerFireMethod:)
                                               userInfo:nil
                                                repeats:YES];
    }
    
    // Set up MapView
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    self.mapView.region = MKCoordinateRegionMakeWithDistance(self.camera.coordinate, 2000, 2000);
    
    CTCameraAnnotation* annotation = [[CTCameraAnnotation alloc] initWithCameraSite:self.camera];
    [mapView addAnnotation:annotation];
    
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//    
//    if (!self.geocoder) { self.geocoder = [[CLGeocoder alloc] init]; }
//    
//    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
//        CLPlacemark *placemark = [placemarks objectAtIndex:0];
//    }];
}

- (void)viewDidUnload
{
    [self.repeatingTimer invalidate];
    [self setRepeatingTimer:nil];
    [self setMapView:nil];
    [self setWebView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)timerFireMethod:(NSTimer*)theTimer {
    [self.webView reload];
}
@end
