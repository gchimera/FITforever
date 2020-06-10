//
//  MTLWorkoutDetails.m
//  FIT
//
//  Created by Karim Sallam on 19/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MTLWorkoutDetails.h"
#import "MTLWorkoutComponent.h"

@implementation MTLWorkoutDetails

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"idWorkoutDetails":@"id",
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
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:MTLWorkoutComponent.class];
}

@end
