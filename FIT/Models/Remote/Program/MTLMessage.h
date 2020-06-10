//
//  MTLMessage.h
//  FIT
//
//  Created by Hamid Mehmood on 27/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <Mantle/Mantle.h>


@interface MTLMessage : MTLModel <MTLJSONSerializing>

@property (readonly, copy, nonatomic) NSNumber *message_id;
@property (readonly, copy, nonatomic) NSString *sender_name;
@property (readonly, copy, nonatomic) NSString *sender_image;
@property (readonly, copy, nonatomic) NSString *sender_image_type;
@property (readonly, copy, nonatomic) NSString *message_body;
@property (readonly, copy, nonatomic) NSString *message_image_type;
@property (readonly, copy, nonatomic) NSString *message_sent_time;
@property (readonly, copy, nonatomic) NSString *message_image;
@property (readonly, copy, nonatomic) NSString *message_type;
@property (readonly, copy, nonatomic) NSString *award_cms_id;
@property (readonly, copy, nonatomic) NSString *notification_cms_id;


@end
