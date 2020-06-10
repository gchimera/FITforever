//
//  F15UserExerciseAction.h
//  FIT
//
//  Created by Hamid Mehmood on 17/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"

@interface F15UserExerciseAction : BaseRealmData

typedef enum : NSUInteger {
    TYPE_WARM_UP = 0,
    TYPE_MEAL = 1,
    TYPE_COOLDOWN = 2
} F15UserExerciseActionType;


@property NSNumber<RLMInt> * _Nullable userExerciseId;

@property NSNumber<RLMInt> * _Nullable type;

@end
