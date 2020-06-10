//
//  MTLProgram.h
//  FIT
//
//  Created by Karim Sallam on 12/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseResponse.H"
#import "FITProgram.h"

@class MTLDays;

@interface MTLProgram : BaseResponse <MTLJSONSerializing>

@property (nonatomic, readonly) FITProgram program;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSArray<MTLDays *> *days;

+ (NSValueTransformer *)programValueTransformer;

@end
