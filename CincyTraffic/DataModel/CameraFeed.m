#import "CameraFeed.h"

@implementation CameraFeed

- (void)updateAttributes:(NSDictionary *)dictionary
{
    self.direction = [dictionary objectForKey:@"Direction"];
    self.type = [dictionary objectForKey:@"Type"];
    self.desc = [dictionary objectForKey:@"Description"];

    if ([[dictionary objectForKey:@"SmallImage"] isKindOfClass:[NSString class]]) {
        self.smallImageURL = [dictionary objectForKey:@"SmallImage"];
    } else {
        NSLog(@"something up small with %@", dictionary);
    }

    if ([[dictionary objectForKey:@"LargeImage"] isKindOfClass:[NSString class]]) {
        self.largeImageURL = [dictionary objectForKey:@"LargeImage"];
    } else {
        NSLog(@"something up large with %@", dictionary);
    }

    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *interval = [f numberFromString:[dictionary objectForKey:@"ImageUpdateInterval"]];
    self.updateInterval = interval;
}
@end
