// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CameraSite.h instead.

#import <CoreData/CoreData.h>


extern const struct CameraSiteAttributes {
	__unsafe_unretained NSString *location;
} CameraSiteAttributes;

extern const struct CameraSiteRelationships {
	__unsafe_unretained NSString *cameraFeeds;
} CameraSiteRelationships;

extern const struct CameraSiteFetchedProperties {
} CameraSiteFetchedProperties;

@class CameraFeed;



@interface CameraSiteID : NSManagedObjectID {}
@end

@interface _CameraSite : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CameraSiteID*)objectID;




@property (nonatomic, strong) NSString* location;


//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* cameraFeeds;

- (NSMutableSet*)cameraFeedsSet;





@end

@interface _CameraSite (CoreDataGeneratedAccessors)

- (void)addCameraFeeds:(NSSet*)value_;
- (void)removeCameraFeeds:(NSSet*)value_;
- (void)addCameraFeedsObject:(CameraFeed*)value_;
- (void)removeCameraFeedsObject:(CameraFeed*)value_;

@end

@interface _CameraSite (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveLocation;
- (void)setPrimitiveLocation:(NSString*)value;





- (NSMutableSet*)primitiveCameraFeeds;
- (void)setPrimitiveCameraFeeds:(NSMutableSet*)value;


@end
