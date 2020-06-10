//
//  MTLWorkoutComponent.m
//  FIT
//
//  Created by Karim Sallam on 19/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MTLWorkoutComponent.h"

@implementation MTLWorkoutComponent

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"thumbnailImage":@"thumbnail-image",
             @"workoutVideo":@"workout-video",
             @"workoutDescription":@"description",
             @"workoutName":@"workout-name"
             };
}

@end
