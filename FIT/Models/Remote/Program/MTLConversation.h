//
//  MTLConversation.h
//  FIT
//
//  Created by Hamid Mehmood on 27/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseResponse.h"
#import <Mantle/Mantle.h>

@interface MTLConversation : MTLModel <MTLJSONSerializing>

@property (readonly, copy, nonatomic) NSNumber *covensation_id;
@property (readonly, copy, nonatomic) NSString *program_code;
@property (readonly, copy, nonatomic) NSString *image;
@property (readonly, copy, nonatomic) NSString *image_type;
@property (readonly, copy, nonatomic) NSString *create_at;
@property (readonly, copy, nonatomic) NSString *title;
@property (readonly, copy, nonatomic) NSArray *users;

@end
