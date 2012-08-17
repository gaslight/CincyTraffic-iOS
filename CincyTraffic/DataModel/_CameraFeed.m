// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CameraFeed.m instead.

#import "_CameraFeed.h"

const struct CameraFeedAttributes CameraFeedAttributes = {
	.desc = @"desc",
	.direction = @"direction",
	.largeImageURL = @"largeImageURL",
	.smallImageURL = @"smallImageURL",
	.type = @"type",
	.updateInterval = @"updateInterval",
};

const struct CameraFeedRelationships CameraFeedRelationships = {
	.cameraSite = @"cameraSite",
};

const struct CameraFeedFetchedProperties CameraFeedFetchedProperties = {
};

@implementation CameraFeedID
@end

@implementation _CameraFeed

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CameraFeed" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CameraFeed";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CameraFeed" inManagedObjectContext:moc_];
}

- (CameraFeedID*)objectID {
	return (CameraFeedID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"updateIntervalValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"updateInterval"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic desc;






@dynamic direction;






@dynamic largeImageURL;






@dynamic smallImageURL;






@dynamic type;






@dynamic updateInterval;



- (int16_t)updateIntervalValue {
	NSNumber *result = [self updateInterval];
	return [result shortValue];
}

- (void)setUpdateIntervalValue:(int16_t)value_ {
	[self setUpdateInterval:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveUpdateIntervalValue {
	NSNumber *result = [self primitiveUpdateInterval];
	return [result shortValue];
}

- (void)setPrimitiveUpdateIntervalValue:(int16_t)value_ {
	[self setPrimitiveUpdateInterval:[NSNumber numberWithShort:value_]];
}





@dynamic cameraSite;

	






@end
