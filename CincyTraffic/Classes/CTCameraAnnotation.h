//
//  CTCameraAnnotation.h
//  CincyTraffic
//
//  Created by Chris Moore on 5/2/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CTCameraAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D _coordinate;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;
@end
