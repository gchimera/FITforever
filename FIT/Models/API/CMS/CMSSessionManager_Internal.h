//
//  CMSSessionManager_Internal.h
//  FIT
//
//  Created by Karim Sallam on 08/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#ifndef CMSSessionManager_Internal_h
#define CMSSessionManager_Internal_h

@interface CMSSessionManager (Internal)

- (NSDictionary *)JSONFromResponseObject:(NSData *)responseObject
                                   error:(NSError **)error
                                 context:(NSString *)context;

@end

#endif /* CMSSessionManager_Internal_h */

