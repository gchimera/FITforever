//
//  ScheduledMealShake.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"

@interface ScheduledMealShake : BaseRealmData

@property NSNumber<RLMInt> * _Nullable id;
@property BOOL isCustom;
@property NSString * _Nullable cmsId;
@property NSNumber<RLMInt> * _Nullable customId;
@property NSString * _Nullable dayTime;
@property NSNumber<RLMInt> * _Nullable dayId;

@end
