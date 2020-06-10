//
//  CourseSettings.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"

@interface CourseSettings : BaseRealmData

@property NSNumber<RLMInt> * _Nullable programId;

@property NSNumber<RLMInt> * _Nullable courseType;
@property NSDate * _Nullable startDate;
@property BOOL notificationsEnabled;

@end
