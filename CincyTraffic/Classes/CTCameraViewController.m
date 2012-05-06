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
@synthesize webView, camera, locationLabel, mapView, geocoder, repeatingTimer;

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

    self.locationLabel.text = self.camera.location;

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
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [self.camera.latitude floatValue];
    coordinate.longitude = [self.camera.longitude floatValue];
    self.mapView.region = MKCoordinateRegionMakeWithDistance(coordinate, 2000, 2000);
    
    CTCameraAnnotation* annotation = [[CTCameraAnnotation alloc] initWithCoordinate:coordinate];
    [mapView addAnnotation:annotation];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    if (!self.geocoder) { self.geocoder = [[CLGeocoder alloc] init]; }
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        NSLog(@"Camera location: %@", placemark.administrativeArea);
    }];
}

- (void)viewDidUnload
{
    [self.repeatingTimer invalidate];
    [self setRepeatingTimer:nil];
    [self setLocationLabel:nil];
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

#pragma mark - MapView delegate methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    MKPinAnnotationView *pinView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    
    if (pinView == nil) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        pinView.pinColor = MKPinAnnotationColorPurple;
        pinView.animatesDrop = YES;
    } else {
        pinView.annotation = annotation;
    }
    
    return pinView;
}

#pragma mark - MapView delegate methods

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"something finished");
}
@end
