// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CameraSite.m instead.

#import "_CameraSite.h"

const struct CameraSiteAttributes CameraSiteAttributes = {
	.city = @"city",
	.createdAt = @"createdAt",
	.latitude = @"latitude",
	.location = @"location",
	.longitude = @"longitude",
	.state = @"state",
};

const struct CameraSiteRelationships CameraSiteRelationships = {
	.cameraFeeds = @"cameraFeeds",
};

const struct CameraSiteFetchedProperties CameraSiteFetchedProperties = {
};

@implementation CameraSiteID
@end

@implementation _CameraSite

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CameraSite" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CameraSite";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CameraSite" inManagedObjectContext:moc_];
}

- (CameraSiteID*)objectID {
	return (CameraSiteID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"latitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"longitudeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"longitude"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"stateValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"state"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic city;






@dynamic createdAt;






@dynamic latitude;



- (float)latitudeValue {
	NSNumber *result = [self latitude];
	return [result floatValue];
}

- (void)setLatitudeValue:(float)value_ {
	[self setLatitude:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLatitudeValue {
	NSNumber *result = [self primitiveLatitude];
	return [result floatValue];
}

- (void)setPrimitiveLatitudeValue:(float)value_ {
	[self setPrimitiveLatitude:[NSNumber numberWithFloat:value_]];
}





@dynamic location;






@dynamic longitude;



- (float)longitudeValue {
	NSNumber *result = [self longitude];
	return [result floatValue];
}

- (void)setLongitudeValue:(float)value_ {
	[self setLongitude:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveLongitudeValue {
	NSNumber *result = [self primitiveLongitude];
	return [result floatValue];
}

- (void)setPrimitiveLongitudeValue:(float)value_ {
	[self setPrimitiveLongitude:[NSNumber numberWithFloat:value_]];
}





@dynamic state;



- (float)stateValue {
	NSNumber *result = [self state];
	return [result floatValue];
}

- (void)setStateValue:(float)value_ {
	[self setState:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveStateValue {
	NSNumber *result = [self primitiveState];
	return [result floatValue];
}

- (void)setPrimitiveStateValue:(float)value_ {
	[self setPrimitiveState:[NSNumber numberWithFloat:value_]];
}





@dynamic cameraFeeds;

	
- (NSMutableSet*)cameraFeedsSet {
	[self willAccessValueForKey:@"cameraFeeds"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"cameraFeeds"];
  
	[self didAccessValueForKey:@"cameraFeeds"];
	return result;
}
	






@end
