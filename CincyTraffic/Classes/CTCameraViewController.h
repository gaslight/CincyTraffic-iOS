//
//  CTCameraViewController.h
//  CincyTraffic
//
//  Created by Chris Moore on 5/2/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <SSToolkit/SSLoadingView.h>
#import "CameraSite.h"

@interface CTCameraViewController : UIViewController <MKMapViewDelegate, UIWebViewDelegate> {
    NSTimer *timer;
}
@property (nonatomic, strong) CameraSite *camera;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (assign) NSTimer *repeatingTimer;
@end
