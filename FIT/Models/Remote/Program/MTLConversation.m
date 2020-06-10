//
//  MTLConversation.m
//  FIT
//
//  Created by Hamid Mehmood on 27/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MTLConversation.h"

@implementation MTLConversation

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    //    NSMutableDictionary *base = [NSMutableDictionary dictionaryWithDictionary:[BaseResponse JSONKeyPathsByPropertyKey]];
    //    [base addEntriesFromDictionary:@{
    NSMutableDictionary *base = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                @"covensation_id":@"covensation_id",
                                                                                @"program_code":@"program_code",
                                                                                @"image":@"image",
                                                                                @"image_type":@"image_type",
                                                                                @"create_at":@"create_at",
                                                                                @"title":@"title",
                                                                                @"users":@"users"
                                                                                }];
    return base;
}

@end
