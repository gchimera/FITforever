//
//  BaseResponse.h
//  FIT
//
//  Created by Hamid Mehmood on 02/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "FITAPIConstant.h"

typedef enum : NSUInteger {
    Success = MT_CODE_SUCCESS,
    AuthFail = MT_CODE_AUTHFAIL,
    UnknownError = MT_CODE_UNKNOWNERROR,
    NewDevice = MT_CODE_NEWDEVICE,
    MissingField = MT_CODE_MISSINGFIELD,
    Unauthorized = MT_CODE_UNAUTHACCESS,
    NotFound = MT_CODE_NOTFOUND
} ResponseStatus;

@interface BaseResponse : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly) ResponseStatus status;
@property (nonatomic, copy, readonly) NSString *message;

@end
