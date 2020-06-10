//
//  MTLCourse.m
//  FIT
//
//  Created by Hamid Mehmood on 26/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MTLCourse.h"

@implementation MTLCourse

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSMutableDictionary *base = [NSMutableDictionary dictionaryWithDictionary:@{
                                     
                                     @"program_id":@"data.program_id",
                                     @"conversation_title":@"data.conversation_title",
                                     @"program_name":@"data.program_name",
                                     @"start_date":@"data.start_date",
                                     @"program_code":@"data.program_code",
                                     @"number_of_days":@"data.number_of_days",
                                     @"is_completed":@"data.is_completed",
                                     @"is_deleted":@"data.is_deleted",
                                     @"notification":@"data.notification",
                                     @"conversation_id":@"data.conversation_id"
                        
                                     }];
    return base;
}

@end
