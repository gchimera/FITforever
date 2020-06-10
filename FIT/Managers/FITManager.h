//
//  FITManager.h
//  FIT
//
//  Created by Hamid Mehmood on 02/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface FITManager : NSObject

+ (FITManager *)sharedManager;

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSString *userType;

- (void)saveUser;
- (void)saveUserType;

@end
