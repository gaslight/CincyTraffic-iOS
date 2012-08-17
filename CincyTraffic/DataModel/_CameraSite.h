// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CameraSite.h instead.

#import <CoreData/CoreData.h>


extern const struct CameraSiteAttributes {
	__unsafe_unretained NSString *city;
	__unsafe_unretained NSString *createdAt;
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *location;
	__unsafe_unretained NSString *longitude;
	__unsafe_unretained NSString *state;
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




@property (nonatomic, strong) NSString* city;


//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* createdAt;


//- (BOOL)validateCreatedAt:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* latitude;


@property float latitudeValue;
- (float)latitudeValue;
- (void)setLatitudeValue:(float)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* location;


//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* longitude;


@property float longitudeValue;
- (float)longitudeValue;
- (void)setLongitudeValue:(float)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* state;


@property float stateValue;
- (float)stateValue;
- (void)setStateValue:(float)value_;

//- (BOOL)validateState:(id*)value_ error:(NSError**)error_;





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


- (NSString*)primitiveCity;
- (void)setPrimitiveCity:(NSString*)value;




- (NSDate*)primitiveCreatedAt;
- (void)setPrimitiveCreatedAt:(NSDate*)value;




- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (float)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(float)value_;




- (NSString*)primitiveLocation;
- (void)setPrimitiveLocation:(NSString*)value;




- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (float)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(float)value_;




- (NSNumber*)primitiveState;
- (void)setPrimitiveState:(NSNumber*)value;

- (float)primitiveStateValue;
- (void)setPrimitiveStateValue:(float)value_;





- (NSMutableSet*)primitiveCameraFeeds;
- (void)setPrimitiveCameraFeeds:(NSMutableSet*)value;


@end
