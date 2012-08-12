//
//  CTMapViewController.h
//  CincyTraffic
//
//  Created by Chris Moore on 8/10/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CTMapViewController : UIViewController <MKMapViewDelegate>
@property (nonatomic, retain) CLLocation *initialLocation;
@property (copy, nonatomic) NSArray *cameras;
@property (strong, nonatomic) NSMutableArray *annotations;
@property (strong, nonatomic) NSMutableArray *mappedCameras;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end
