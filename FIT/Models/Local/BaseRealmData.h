//
//  BaseRealmData.h
//  FIT
//
//  Created by Hamid Mehmood on 02/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <Realm/Realm.h>

@interface BaseRealmData : RLMObject

typedef enum : NSUInteger {
    STATUS_IN_PROGRESS = 1,
    STATUS_WAITING = 2,
    STATUS_COMPLETED = 3
} UserCourseStatus;

typedef enum : NSUInteger {
    C9 = 0,
    F15Begginner = 1,
    F15Begginner1 = 2,
    F15Begginner2 = 3,
    F15Intermidiate = 4,
    F15Intermidiate1 = 5,
    F15Intermidiate2 = 6,
    F15Advance = 7,
    F15Advance1 = 8,
    F15Advance2 = 9,
    V5 = 10
} UserCourseType;

@property BOOL isSynced;

@end
