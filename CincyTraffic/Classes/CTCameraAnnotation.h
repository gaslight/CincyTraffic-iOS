//
//  CTCameraAnnotation.h
//  CincyTraffic
//
//  Created by Chris Moore on 5/2/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "CTCameraSite.h"

@interface CTCameraAnnotation : NSObject <MKAnnotation>
@property (weak, nonatomic) CTCameraSite *cameraSite;

- (id)initWithCameraSite:(CTCameraSite *)site;
- (CLLocationCoordinate2D)coordinate;
@end
