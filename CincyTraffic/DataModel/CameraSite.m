//
//  CTCameraSite.m
//  CincyTraffic
//
//  Created by Chris Moore on 5/5/12.
//  Copyright (c) 2012 26Webs LLC. All rights reserved.
//

#import "CTCamerasDataModel.h"
#import "CameraSite.h"
#import "CameraFeed.h"
#import "XMLDictionary.h"

@implementation CameraSite

#pragma mark - Class Methods

+ (void)loadCamerasFromLocalXMLWithProgressBlock:(void(^)(float progress))block
{
    NSString *documentsDirectory = nil;
    documentsDirectory = [[NSBundle mainBundle] resourcePath];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"cameras.xml"];
    [self loadCamerasFromDictionary:[NSDictionary dictionaryWithXMLFile:path] usingProgressBlock:block];
}

//+ (void)reloadCamerasFromApi
//{
//    [[CTApiClient sharedInstance] getPath:@"Cameras.aspx" parameters:nil
//                                  success:^(AFHTTPRequestOperation *operation, id response) {
//                                      NSDictionary *cameraXML = [NSDictionary dictionaryWithXMLString:operation.responseString];
//                                      //[self loadCamerasFromXML:cameraXML];
//                                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//                                  }
//                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//                                      NSLog(@"Error fetching cameras!");
//                                      NSLog(@"%@", error);
//                                  }];
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//}

+ (void)loadCamerasFromDictionary:(NSDictionary *)xmlDictionary usingProgressBlock:(void(^)(float progress))block
{
    NSManagedObjectContext *context = [[CTCamerasDataModel sharedDataModel] mainContext];
    NSError *error = nil;

    if (context) {
        NSLog(@"Context is ready!");
        [self removeAllCamerasUsingContext:context];
        //float totalCameras = [[xmlDictionary valueForKeyPath:@"CameraSite"] count];
        //float cameraCount = 0.0;

        for (NSDictionary *cameraDictionary in [xmlDictionary valueForKeyPath:@"CameraSite"]) {
            CameraSite *cameraSite = [CameraSite insertInManagedObjectContext:context];
            [cameraSite updateAttributes:cameraDictionary];
            NSDictionary *foundFeeds = [cameraDictionary valueForKeyPath:@"CameraFeeds.CameraFeed"];

            if ([foundFeeds isKindOfClass:[NSArray class]]) {
                for (NSDictionary *feed in foundFeeds) {
                    CameraFeed *cameraFeed = [CameraFeed insertInManagedObjectContext:context];
                    [cameraFeed updateAttributes:feed];
                    [cameraSite addCameraFeedsObject:cameraFeed];
                }
            } else {
                CameraFeed *cameraFeed = [CameraFeed insertInManagedObjectContext:context];
                [cameraFeed updateAttributes:foundFeeds];
                [cameraSite addCameraFeedsObject:cameraFeed];
            }
            
            [context save:&error];

            if (error) {
                NSLog(@"uh oh.");
            }
            
            //cameraCount++;
            dispatch_async(dispatch_get_main_queue(), ^{
                //block(cameraCount/totalCameras);
            });
        }
    }
}

+ (void)removeAllCamerasUsingContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *allCameraSites = [[NSFetchRequest alloc] init];
    [allCameraSites setEntity:[NSEntityDescription entityForName:@"CameraSite" inManagedObjectContext:context]];
    [allCameraSites setIncludesPropertyValues:NO]; //only fetch the managedObjectID

    NSError *error = nil;
    NSArray *cameras = [context executeFetchRequest:allCameraSites error:&error];

    for (NSManagedObject *camera in cameras) {
        [context deleteObject:camera];
    }
    NSError *saveError = nil;
    [context save:&saveError];
}

+ (NSArray *)allCameras
{
    NSManagedObjectContext *context = [[CTCamerasDataModel sharedDataModel] mainContext];
    NSMutableArray *cameras = [NSMutableArray array];
    
    if (context) {
        NSLog(@"Context is ready!");

        NSFetchRequest *allCameraSites = [[NSFetchRequest alloc] init];
        [allCameraSites setEntity:[NSEntityDescription entityForName:@"CameraSite" inManagedObjectContext:context]];
        [allCameraSites setIncludesPropertyValues:YES]; //only fetch the managedObjectID

        NSError *error = nil;
        [cameras addObjectsFromArray:[context executeFetchRequest:allCameraSites error:&error]];
    }
    
    return cameras;
}

- (void)updateAttributes:(NSDictionary *)dictionary
{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];

    self.desc = [dictionary objectForKey:@"Location"];

    NSNumber *myNumber = [f numberFromString:[dictionary objectForKey:@"Latitude"]];
    self.latitude = myNumber;

    myNumber = [f numberFromString:[dictionary objectForKey:@"Longitude"]];
    self.longitude = myNumber;
}

- (CLLocation *)location
{
    return [[CLLocation alloc] initWithLatitude:[self.latitude floatValue]
                                      longitude:[self.longitude floatValue]];
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([self.latitude floatValue],
                                                              [self.longitude floatValue]);
    return coord;
}
@end
