//
//  CTCameraAnnotation.h
//  CincyTraffic
//
//  Created by Chris Moore on 5/2/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "CameraSite.h"

@interface CTCameraAnnotation : NSObject <MKAnnotation>
@property (weak, nonatomic) CameraSite *cameraSite;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;

- (id)initWithCameraSite:(CameraSite *)site;
- (CLLocationCoordinate2D)coordinate;
@end
