//
//  Meal.m
//  fitapp
//
//  Created by Hadi Roohian on 22/02/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import "Meal.h"
#import "Utils.h"

@implementation Meal

+ (NSString*)primaryKey {
    return  @"uid";
}

+ (NSDictionary *)defaultPropertyValues {
    return @{@"uid":[[Utils sharedUtils] UUIDString]};
}

@end
