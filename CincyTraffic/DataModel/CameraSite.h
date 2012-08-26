#import <CoreLocation/CoreLocation.h>
#import "_CameraSite.h"

@interface CameraSite : _CameraSite {}
+ (void)loadCamerasFromLocalXML;
+ (void)loadCamerasFromDictionary:(NSDictionary *)xmlDictionary;
+ (void)removeAllCameras;
+ (NSArray *)allCameras;

- (void)updateAttributes:(NSDictionary *)dictionary;
- (CLLocation *)location;
- (CLLocationCoordinate2D)coordinate;
@end
