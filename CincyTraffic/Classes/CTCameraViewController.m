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
#import "CameraFeed.h"

@interface CTCameraViewController ()
- (void)timerFireMethod:(NSTimer*)theTimer;
@end

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

    [self.navigationController setNavigationBarHidden:NO animated:YES];

    self.title = self.camera.desc;
    self.mapView.delegate = self;

    self.webView.hidden = YES;
    self.webView.delegate = self;

    for (CameraFeed *feed in self.camera.cameraFeeds) {
        NSLog(@"%@", feed.largeImageURL);
        NSLog(@"%@", feed.smallImageURL);

        NSString *badURL = feed.smallImageURL;
        NSString *url = [badURL stringByReplacingOccurrencesOfString:@"cmhimg01/" withString:@"cmhimg01.dot.state.oh.us/"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
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
    [mapView setCenterCoordinate:self.camera.coordinate animated:YES];

    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self
                                                    action:@selector(oneFingerSwipeRight:)];

    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:swipeRight];
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

- (void)oneFingerSwipeRight:(UISwipeGestureRecognizer *)recognizer
{
    [self.navigationController popViewControllerAnimated:YES];
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
    self.webView.hidden = NO;
}
@end
