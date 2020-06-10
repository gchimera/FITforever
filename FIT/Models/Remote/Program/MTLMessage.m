//
//  MTLMessage.m
//  FIT
//
//  Created by Hamid Mehmood on 27/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MTLMessage.h"

@implementation MTLMessage

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    //    NSMutableDictionary *base = [NSMutableDictionary dictionaryWithDictionary:[BaseResponse JSONKeyPathsByPropertyKey]];
    //    [base addEntriesFromDictionary:@{
    NSMutableDictionary *base = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                @"message_id": @"message_id",
                                                                                @"sender_name": @"sender_name",
                                                                                @"sender_image": @"sender_image",
                                                                                @"sender_image_type": @"sender_image_type",
                                                                                @"message_body": @"message_body",
                                                                                @"message_image_type": @"message_image_type",
                                                                                @"message_sent_time": @"message_sent_time",
                                                                                @"message_image": @"message_image",
                                                                                @"message_type": @"message_type",
                                                                                @"award_cms_id": @"award_cms_id",
                                                                                @"notification_cms_id" : @"notification_cms_id"
                                                                                }];
    return base;
}

@end
