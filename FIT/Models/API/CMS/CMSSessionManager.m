//
//  CMSSessionManager.m
//  FIT
//
//  Created by Karim Sallam on 08/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "CMSSessionManager.h"
#import "FITAPIConstant.h"

@implementation CMSSessionManager

- (id)init {
    self = [super initWithBaseURL:[NSURL URLWithString:CMS_BASE_URL]];
    if (!self) return nil;
    
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [self.requestSerializer setValue:CMS_TOKEN forHTTPHeaderField:@"X-FIT-Auth"];

    return self;
}

+ (id)sharedManager {
    static CMSSessionManager *_sessionManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sessionManager = [[self alloc] init];
    });
    
    return _sessionManager;
}

- (NSDictionary *)JSONFromResponseObject:(NSData *)responseObject error:(NSError **)error context:(NSString *)context {
    NSString *JSONString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    DLog(@"[%@] JSONString: %@", context, JSONString);
    
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:JSONData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:error];
    
    if (JSONDictionary != nil) {
        DLog(@"[%@] JSON: %@", context, JSONDictionary);
    } else {
        DLog(@"[Error] %@ JSON parsing error: %@", context, *error);
    }
    
    return JSONDictionary;
}

@end
