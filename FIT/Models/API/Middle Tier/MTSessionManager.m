//
//  MTSessionManager.m
//  FIT
//
//  Created by Hamid Mehmood on 08/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MTSessionManager.h"
#import "FITAPIConstant.h"

@implementation MTSessionManager

- (id)init {
    self = [super initWithBaseURL:[NSURL URLWithString:MT_BASE_URL]];
    if (!self) return nil;
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [self.requestSerializer setValue:MT_TOKEN forHTTPHeaderField:@"MT-FIT-Auth"];
    
    return self;
}

+ (id)sharedManager {
    static MTSessionManager *_sessionManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sessionManager = [[self alloc] init];
    });
    
    return _sessionManager;
}

@end
