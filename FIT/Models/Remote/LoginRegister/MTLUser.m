//
//  MTLUser.m
//  FIT
//
//  Created by Hamid Mehmood on 02/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MTLUser.h"

@implementation MTLUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSMutableDictionary *base = [NSMutableDictionary dictionaryWithDictionary:[BaseResponse JSONKeyPathsByPropertyKey]];
    [base addEntriesFromDictionary:@{
                                     @"email":@"data.email",
                                     @"username":@"data.username",
                                     @"image":@"data.image",
                                     @"imageType":@"data.imagetype",
                                     @"age":@"data.age",
                                     @"height":@"data.height",
                                     @"weight":@"data.weight",
                                     @"gender":@"data.gender",
                                     @"token":@"data.user_token",
                                     @"idFLP360":@"data.fl360_id",
                                     @"idFacebook":@"data.facebook_id",
                                     @"profileCompleted":@"data.profile_completed"
                                     }];
    return base;
}

@end
