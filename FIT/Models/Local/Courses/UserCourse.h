//
//  UserCourse.h
//  FIT
//
//  Created by Hamid Mehmood on 13/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"

@interface UserCourse : BaseRealmData

@property NSString * _Nullable userProgramId;
@property NSNumber<RLMInt> * _Nullable serverProgramId;
@property NSString * _Nullable programName;
@property NSString * _Nullable shareCode;
@property NSDate * _Nullable startDate;
@property NSNumber<RLMInt> * _Nullable userId;
@property NSNumber<RLMInt> * _Nullable conversationId;
@property NSNumber<RLMInt> * _Nullable programDays;
@property NSNumber<RLMInt> * _Nullable status;
@property NSNumber<RLMInt> * _Nullable courseType; //int from 0 to 9
@property BOOL isCurrentCourse;
@property NSNumber<RLMInt> * _Nullable thirdDayChoose;

+ (UserCourse * _Nullable)currentProgram;
- (UserCourse * _Nullable)createNewCourse:(UserCourse  * _Nonnull)course;

@end
