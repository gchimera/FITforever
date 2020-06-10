//
//  Exercise.h
//  fitapp
//
//  Created by Hadi Roohian on 20/02/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import "BaseRealmData.h"

@interface Exercise : BaseRealmData
@property   (nonatomic, assign) NSString * _Nullable uid;
@property   NSString * _Nullable day;
@property NSString * _Nullable exerciseName;
@property NSNumber<RLMInt> * _Nullable exerciseType;
@property NSString * _Nullable programID;
@property NSNumber<RLMInt> * _Nullable serverExerciseId;

@end
RLM_ARRAY_TYPE(Exercise)
