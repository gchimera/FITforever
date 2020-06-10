//
//  MTLWorkout.h
//  FIT
//
//  Created by Karim Sallam on 13/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <Mantle/Mantle.h>

@class MTLExerciseDetails, MTLWorkoutDetails;

@interface MTLWorkout : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *idWorkout;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, readonly) NSArray<MTLExerciseDetails *> *exercises;
@property (nonatomic, readonly) NSArray<MTLWorkoutDetails *> *workouts;

@end
