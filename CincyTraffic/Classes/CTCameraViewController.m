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
#import "CTLocationManager.h"
#import "CTCameraAnnotation.h"
#import "CameraFeed.h"

@interface CTCameraViewController ()
- (void)timerFireMethod:(NSTimer*)theTimer;
@end

@implementation CTCameraViewController
@synthesize webView, camera, mapView, geocoder, repeatingTimer;

NSInteger const kLoadView = 1;

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

    [CTLocationManager sharedSingleton];
    
    self.title = self.camera.desc;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;

    CGSize size = self.webView.frame.size;
    self.webView.hidden = YES;
    self.webView.delegate = self;

    // Loading View
    SSLoadingView *loadView = [[SSLoadingView alloc] initWithFrame:CGRectMake(self.webView.frame.origin.x,
                                                                              self.webView.frame.origin.y,
                                                                              size.width,
                                                                              size.height + 80)];
    loadView.tag = kLoadView;
	[self.view addSubview:loadView];

    for (CameraFeed *feed in self.camera.cameraFeeds) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:feed.smallImageURL]];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [self.webView loadRequest:request];
        self.repeatingTimer = [NSTimer scheduledTimerWithTimeInterval:[feed.updateInterval floatValue]
                                                               target:self
                                                             selector:@selector(timerFireMethod:)
                                                             userInfo:nil
                                                              repeats:YES];
    }
    
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
    [self setRepeatingTimer:nil];
    [self setMapView:nil];
    [self setWebView:nil];
    [super viewDidUnload];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.repeatingTimer invalidate];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Timer methods

- (void)timerFireMethod:(NSTimer*)theTimer {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.webView reload];
}

#pragma mark - WebView delegate methods

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [[self.view viewWithTag:kLoadView] removeFromSuperview];
    self.webView.hidden = NO;
}
@end
