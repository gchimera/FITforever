//
//  MTSessionManager.h
//  FIT
//
//  Created by Hamid Mehmood on 08/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface MTSessionManager : AFHTTPSessionManager

+ (id)sharedManager;

@end
