//
//  BaseResponse.m
//  FIT
//
//  Created by Hamid Mehmood on 02/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseResponse.h"

@implementation BaseResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"status":@"status",
             @"message":@"message"
             };
}

+ (NSValueTransformer *)statusJSONTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{@(MT_CODE_SUCCESS): @(Success),
                                                                           @(MT_CODE_AUTHFAIL): @(AuthFail),
                                                                           @(MT_CODE_UNKNOWNERROR): @(UnknownError),
                                                                           @(MT_CODE_NEWDEVICE): @(NewDevice),
                                                                           @(MT_CODE_MISSINGFIELD): @(MissingField),
                                                                           @(MT_CODE_UNAUTHACCESS): @(Unauthorized),
                                                                           @(MT_CODE_NOTFOUND): @(NotFound)
                                                                           }];
}

@end
