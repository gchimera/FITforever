//
//  ScheduledSupplement.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"

@interface ScheduledSupplement : BaseRealmData

@property NSNumber<RLMInt> * _Nullable id;
@property NSString * _Nullable cmsId;
@property NSDate * dateTaken;
@property NSNumber<RLMInt> * _Nullable dayId;
@property NSNumber<RLMInt> * _Nullable dayTime;

@end
