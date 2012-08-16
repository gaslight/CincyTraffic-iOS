// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CameraFeed.h instead.

#import <CoreData/CoreData.h>


extern const struct CameraFeedAttributes {
	__unsafe_unretained NSString *location;
} CameraFeedAttributes;

extern const struct CameraFeedRelationships {
	__unsafe_unretained NSString *cameraSite;
} CameraFeedRelationships;

extern const struct CameraFeedFetchedProperties {
} CameraFeedFetchedProperties;

@class CameraSite;



@interface CameraFeedID : NSManagedObjectID {}
@end

@interface _CameraFeed : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CameraFeedID*)objectID;




@property (nonatomic, strong) NSString* location;


//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) CameraSite* cameraSite;

//- (BOOL)validateCameraSite:(id*)value_ error:(NSError**)error_;





@end

@interface _CameraFeed (CoreDataGeneratedAccessors)

@end

@interface _CameraFeed (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveLocation;
- (void)setPrimitiveLocation:(NSString*)value;





- (CameraSite*)primitiveCameraSite;
- (void)setPrimitiveCameraSite:(CameraSite*)value;


@end
