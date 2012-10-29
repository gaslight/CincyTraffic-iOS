#import <CoreLocation/CoreLocation.h>
#import "_CameraSite.h"

@interface CameraSite : _CameraSite {}

+ (void)loadCamerasFromLocalXMLWithProgressBlock:(void(^)(float progress))block;
+ (void)loadCamerasFromDictionary:(NSDictionary *)xmlDictionary usingProgressBlock:(void(^)(float progress))block;
+ (void)removeAllCamerasUsingContext:(NSManagedObjectContext *)context;
+ (NSArray *)allCameras;

- (void)updateAttributes:(NSDictionary *)dictionary;
- (CLLocation *)location;
- (CLLocationCoordinate2D)coordinate;
@end
