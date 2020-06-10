//
//  MTLCourse.h
//  FIT
//
//  Created by Hamid Mehmood on 26/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MTLCourse : MTLModel <MTLJSONSerializing>
//@interface MTLCourse : BaseResponse
//@interface MTLCourse : BaseResponse <MTLJSONSerializing>

@property (readonly, copy, nonatomic) NSNumber *program_id;
@property (readonly, copy, nonatomic) NSNumber *conversation_id;
@property (readonly, copy, nonatomic) NSString *conversation_title;
@property (readonly, copy, nonatomic) NSString *program_name;
@property (readonly, copy, nonatomic) NSString *start_date;
@property (readonly, copy, nonatomic) NSString *program_code;
@property (readonly, copy, nonatomic) NSNumber *number_of_days;
@property (readonly, copy, nonatomic) NSNumber *is_completed;
@property (readonly, copy, nonatomic) NSNumber *is_deleted;
@property (readonly, copy, nonatomic) NSNumber *notification;
@end
