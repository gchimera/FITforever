//
//  MTLExercise.h
//  FIT
//
//  Created by Karim Sallam on 13/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseResponse.h"

@class MTLWorkout;

@interface MTLExercise : BaseResponse

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSArray<MTLWorkout *> *workouts;

@end
