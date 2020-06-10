//
//  DayMeasurement.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"

@interface DayMeasurement : BaseRealmData

@property NSNumber<RLMInt> * _Nullable measurementId;

@property NSNumber<RLMInt> * _Nullable dayId;
@property NSNumber<RLMInt> * _Nullable weight;
@property NSNumber<RLMInt> * _Nullable waist;
@property NSNumber<RLMInt> * _Nullable chest;
@property NSNumber<RLMInt> * _Nullable arm;
@property NSNumber<RLMInt> * _Nullable hip;
@property NSNumber<RLMInt> * _Nullable thighs;
@property NSNumber<RLMInt> * _Nullable knee;
@property NSDate * dateRecorded;

@end
