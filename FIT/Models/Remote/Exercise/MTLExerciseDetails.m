//
//  MTLExerciseDetails.m
//  FIT
//
//  Created by Karim Sallam on 19/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MTLExerciseDetails.h"
#import "MTLExerciseComponents.h"

@implementation MTLExerciseDetails

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"idExerciseDetails":@"id",
             @"name":@"name",
             @"title":@"title",
             @"language":@"language",
             @"country":@"country",
             @"type":@"type",
             @"language":@"language",
             @"components":@"components"
             };
}

+ (NSValueTransformer *)componentsJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:MTLExerciseComponents.class];
}

@end
