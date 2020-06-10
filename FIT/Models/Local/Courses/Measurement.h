//
//  Measurement.h
//  fitapp
//
//  Created by Hadi Roohian on 01/03/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import <Realm/Realm.h>

@interface Measurement : RLMObject

@property (nonatomic, assign) NSString * _Nullable measurementId;
@property NSString * _Nullable day;
@property NSString * _Nullable programID;
@property NSNumber<RLMInt> * _Nullable serverMeasurementId;
@property NSNumber<RLMInt> * _Nullable weight;
@property NSNumber<RLMInt> * _Nullable chest;
@property NSNumber<RLMInt> * _Nullable waist;
@property NSNumber<RLMInt> * _Nullable arm;
@property NSNumber<RLMInt> * _Nullable hip;
@property NSNumber<RLMInt> * _Nullable thigh;
@property NSNumber<RLMInt> * _Nullable calf;
@property NSNumber<RLMInt> * _Nullable totalMeasurements;


//@property   NSDate *createdAt;


@end

// This protocol enables typed collections. i.e.:
RLM_ARRAY_TYPE(Measurement)
