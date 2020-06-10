//
//  DayWaterIntake.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"

@interface DayWaterIntake : BaseRealmData

@property NSNumber<RLMInt> * _Nullable waterId;


@property NSNumber<RLMInt> * _Nullable dayId;
@property BOOL isComplete;
@property NSNumber<RLMInt> * _Nullable expectedIntake;
@property NSNumber<RLMInt> * _Nullable actualIntake;

@end
