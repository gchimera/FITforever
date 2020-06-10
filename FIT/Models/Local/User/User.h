//
//  User.h
//  FIT
//
//  Created by Hamid Mehmood on 02/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//
#import "BaseRealmData.h"

@class MTLUser;

@interface User : BaseRealmData

- (User * _Nullable)initWithMantleModel:(MTLUser  * _Nonnull)model;

@property NSNumber<RLMInt> * _Nullable userdId;
@property NSString * _Nullable email;
@property NSString * _Nullable username;
@property NSString * _Nullable password;
@property NSString * _Nullable image;
@property NSString * _Nullable imageType;
@property NSNumber<RLMInt> * _Nullable age;
@property NSNumber<RLMInt> * _Nullable height;
@property NSNumber<RLMInt> * _Nullable weight;
@property NSString *_Nullable gender;
@property NSString *_Nullable token;
@property NSString *_Nullable idFLP360;
@property NSString *_Nullable idFacebook;
@property (getter=isProfileCompleted) BOOL profileCompleted;

@property NSString * _Nullable language;
@property NSString * _Nullable country;

+ (User * _Nullable)userInDB;

+ (RLMResults* _Nullable) getUser;



@end
