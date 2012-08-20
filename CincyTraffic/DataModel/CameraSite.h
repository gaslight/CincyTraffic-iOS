#import <CoreLocation/CoreLocation.h>
#import "_CameraSite.h"

@interface CameraSite : _CameraSite {}
- (void)updateAttributes:(NSDictionary *)dictionary;
- (CLLocation *)location;
- (CLLocationCoordinate2D)coordinate;
@end
