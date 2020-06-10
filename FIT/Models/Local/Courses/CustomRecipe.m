//
//  CustomRecipe.m
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "CustomRecipe.h"
#import "Utils.h"

@implementation CustomRecipe

+ (NSString *)primaryKey {
    return @"recipeID";
}

+ (NSDictionary *)defaultPropertyValues {
    return @{@"recipeID":[[Utils sharedUtils] UUIDString]};
}

@end
