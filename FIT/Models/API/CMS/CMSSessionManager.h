//
//  CMSSessionManager.h
//  FIT
//
//  Created by Karim Sallam on 08/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface CMSSessionManager : AFHTTPSessionManager

+ (id)sharedManager;

@end
