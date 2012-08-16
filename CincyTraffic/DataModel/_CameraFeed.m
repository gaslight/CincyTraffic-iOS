// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CameraFeed.m instead.

#import "_CameraFeed.h"

const struct CameraFeedAttributes CameraFeedAttributes = {
	.location = @"location",
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
	

	return keyPaths;
}




@dynamic location;






@dynamic cameraSite;

	






@end
