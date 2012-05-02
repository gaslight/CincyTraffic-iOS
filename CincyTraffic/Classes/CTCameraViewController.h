//
//  CTCameraViewController.h
//  CincyTraffic
//
//  Created by Chris Moore on 5/2/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CTCameraViewController : UIViewController <MKMapViewDelegate>
@property (nonatomic, strong) NSDictionary *camera;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLGeocoder *geocoder;
@end
