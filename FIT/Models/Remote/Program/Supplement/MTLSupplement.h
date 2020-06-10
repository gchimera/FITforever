//
//  MTLSupplement.h
//  FIT
//
//  Created by Karim Sallam on 12/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "FITSupplementType.h"

@class MTLSupplementComponents;

@interface MTLSupplement : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *idSupplement;
@property (nonatomic, readonly) FITSupplementType supplementType;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSNumber *sequence;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *language;
@property (nonatomic, copy, readonly) NSString *country;
@property (nonatomic, readonly) MTLSupplementComponents *components;

+ (NSValueTransformer *)supplementTypeValueTransformer;

@end

@interface MTLSupplementComponents : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, getter=isInterval, readonly) BOOL interval;
@property (nonatomic, copy, readonly) NSString *intervalTime;

@end
