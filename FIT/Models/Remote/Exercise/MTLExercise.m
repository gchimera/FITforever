//
//  MTLExercise.m
//  FIT
//
//  Created by Karim Sallam on 13/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MTLExercise.h"
#import "MTLWorkout.h"

@implementation MTLExercise

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *base = [NSMutableDictionary dictionaryWithDictionary:[BaseResponse JSONKeyPathsByPropertyKey]];
    [base addEntriesFromDictionary:@{@"name":@"data.name",
                                     @"workouts":@"data.children"
                                     }];
    return base;
}

+ (NSValueTransformer *)workoutsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:MTLWorkout.class];
}

@end
