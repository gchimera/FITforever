//
//  Supplements.m
//  fitapp
//
//  Created by Hadi Roohian on 04/01/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import "Supplements.h"
#import "Utils.h"

@implementation Supplements

+ (NSString*)primaryKey {
    return  @"uid";
}


+ (NSDictionary *)defaultPropertyValues {
    return @{@"uid":[[Utils sharedUtils] UUIDString]};
}

@end
