//
//  MTLUser.h
//  FIT
//
//  Created by Hamid Mehmood on 02/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseResponse.h"

@interface MTLUser : BaseResponse

@property (readonly, copy, nonatomic) NSNumber *userId;
@property (readonly, copy, nonatomic) NSString *email;
@property (readonly, copy, nonatomic) NSString *username;
@property (readonly, copy, nonatomic) NSString *password;
@property (readonly, copy, nonatomic) NSString *image;
@property (readonly, copy, nonatomic) NSString *imageType;
@property (readonly, copy, nonatomic) NSNumber *age;
@property (readonly, copy, nonatomic) NSNumber *height;
@property (readonly, copy, nonatomic) NSNumber *weight;
@property (readonly, copy, nonatomic) NSString *gender;
@property (readonly, copy, nonatomic) NSString *token;
@property (readonly, copy, nonatomic) NSString *idFLP360;
@property (readonly, copy, nonatomic) NSString *idFacebook;
@property (readonly, getter=isProfileCompleted, nonatomic) BOOL profileCompleted;

@end
