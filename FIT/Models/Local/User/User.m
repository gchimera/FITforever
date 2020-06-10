//
//  User.m
//  FIT
//
//  Created by Hamid Mehmood on 02/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "User.h"
#import "MTLUser.h"

@implementation User

+ (NSString *)primaryKey {
    return @"token";
}

- (id)initWithMantleModel:(MTLUser *)model {
    self = [super init];
    if(!self) return nil;
    
    self.userdId = model.userId;
    self.email = model.email;
    self.username = model.username;
    self.password = model.password;
    self.image = model.image;
    self.imageType = model.imageType;
    self.age = model.age;
    self.height = model.height;
    self.weight = model.weight;
    self.gender = model.gender;
    self.token = model.token;
    self.idFLP360 = model.idFLP360;
    self.idFacebook = model.idFacebook;
    self.profileCompleted = model.profileCompleted;
    
#pragma mark TODO: Hamid implement this!
    self.language = nil;
    self.country = nil;

    return self;
}

+ (User * _Nullable)userInDB {
    RLMResults<User *> *user = [User allObjects];
    return user.count > 0 ? user[0] : nil;
}

+ (RLMResults* _Nullable) getUser
{
    RLMResults *user = [User allObjects];
    
    return user;
}
@end
