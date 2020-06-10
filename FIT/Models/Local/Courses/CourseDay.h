//
//  CourseDay.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"

@interface CourseDay : BaseRealmData

@property NSString * _Nullable dayId;

@property NSString * _Nullable serverDayId;
@property NSString * _Nullable programID;
@property NSString * _Nullable day;
@property NSDate * _Nullable date;
@end
