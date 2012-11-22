// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CameraFeed.h instead.

#import <CoreData/CoreData.h>


extern const struct CameraFeedAttributes {
	__unsafe_unretained NSString *desc;
	__unsafe_unretained NSString *direction;
	__unsafe_unretained NSString *largeImageURL;
	__unsafe_unretained NSString *smallImageURL;
	__unsafe_unretained NSString *type;
	__unsafe_unretained NSString *updateInterval;
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





@property (nonatomic, strong) NSString* desc;



//- (BOOL)validateDesc:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* direction;



//- (BOOL)validateDirection:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* largeImageURL;



//- (BOOL)validateLargeImageURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* smallImageURL;



//- (BOOL)validateSmallImageURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* type;



//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* updateInterval;



@property int16_t updateIntervalValue;
- (int16_t)updateIntervalValue;
- (void)setUpdateIntervalValue:(int16_t)value_;

//- (BOOL)validateUpdateInterval:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) CameraSite *cameraSite;

//- (BOOL)validateCameraSite:(id*)value_ error:(NSError**)error_;





@end

@interface _CameraFeed (CoreDataGeneratedAccessors)

@end

@interface _CameraFeed (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveDesc;
- (void)setPrimitiveDesc:(NSString*)value;




- (NSString*)primitiveDirection;
- (void)setPrimitiveDirection:(NSString*)value;




- (NSString*)primitiveLargeImageURL;
- (void)setPrimitiveLargeImageURL:(NSString*)value;




- (NSString*)primitiveSmallImageURL;
- (void)setPrimitiveSmallImageURL:(NSString*)value;




- (NSString*)primitiveType;
- (void)setPrimitiveType:(NSString*)value;




- (NSNumber*)primitiveUpdateInterval;
- (void)setPrimitiveUpdateInterval:(NSNumber*)value;

- (int16_t)primitiveUpdateIntervalValue;
- (void)setPrimitiveUpdateIntervalValue:(int16_t)value_;





- (CameraSite*)primitiveCameraSite;
- (void)setPrimitiveCameraSite:(CameraSite*)value;


@end
