//
//  CourseMealMap.h
//  FIT
//
//  Created by Hamid Mehmood on 27/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"

@interface CourseMealMap : BaseRealmData

@property NSNumber<RLMInt> * _Nullable id;

@property NSNumber<RLMInt> * _Nullable program;
@property NSNumber<RLMInt> * _Nullable day;
@property NSNumber<RLMInt> * _Nullable breakfast;
@property NSNumber<RLMInt> * _Nullable morningSnack;
@property NSNumber<RLMInt> * _Nullable lunch;
@property NSNumber<RLMInt> * _Nullable dinner;
@property NSNumber<RLMInt> * _Nullable eveningShake;

@end
