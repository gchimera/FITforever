//
//  Exercise.m
//  fitapp
//
//  Created by Hadi Roohian on 20/02/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import "Exercise.h"
#import "Utils.h"

@implementation Exercise

+ (NSString*)primaryKey {
    return  @"uid";
}

+ (NSDictionary *)defaultPropertyValues {
    return @{@"uid":[[Utils sharedUtils] UUIDString],@"exerciseType":@0};
}


@end
