//
//  CTCameraFeed.h
//  CincyTraffic
//
//  Created by Chris Moore on 5/5/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKObjectMapping.h"

@interface CTCameraFeed : NSObject
@property (nonatomic, copy) NSString *direction;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *smallImageURL;
@property (nonatomic, copy) NSString *largeImageURL;
@property (nonatomic) NSInteger *updateInterval;

+ (RKObjectMapping *)mapping;
@end
