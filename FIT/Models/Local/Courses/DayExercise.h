//
//  DayExercise.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"

@interface DayExercise : BaseRealmData

@property NSNumber<RLMInt> * _Nullable exerciseId;

@property NSNumber<RLMInt> * _Nullable dayId;
@property NSNumber<RLMInt> * _Nullable exerciseType;

@end
