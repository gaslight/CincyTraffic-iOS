// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CameraSite.m instead.

#import "_CameraSite.h"

const struct CameraSiteAttributes CameraSiteAttributes = {
	.location = @"location",
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
	

	return keyPaths;
}




@dynamic location;






@dynamic cameraFeeds;

	
- (NSMutableSet*)cameraFeedsSet {
	[self willAccessValueForKey:@"cameraFeeds"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"cameraFeeds"];
  
	[self didAccessValueForKey:@"cameraFeeds"];
	return result;
}
	






@end
