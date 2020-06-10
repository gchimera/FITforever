//
//  Water.m
//  fitapp
//
//  Created by Hadi Roohian on 05/01/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import "Water.h"
#import "Utils.h"

@implementation Water
+ (NSString*)primaryKey {
    return  @"uid";
}

+ (NSDictionary *)defaultPropertyValues {
    return @{@"uid":[[Utils sharedUtils] UUIDString]};
}

@end
