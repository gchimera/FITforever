//
//  MTLWorkout.m
//  FIT
//
//  Created by Karim Sallam on 13/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MTLWorkout.h"
#import "MTLExerciseDetails.h"
#import "MTLWorkoutDetails.h"

@implementation MTLWorkout

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"idWorkout":@"id",
             @"name":@"name",
             @"exercises":@"items.fitapp-exercise-details",
             @"workouts":@"items.fitapp-workout-details"
             };
}

+ (NSValueTransformer *)exercisesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:MTLExerciseDetails.class];
}

+ (NSValueTransformer *)workoutsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:MTLWorkoutDetails.class];
}

@end
