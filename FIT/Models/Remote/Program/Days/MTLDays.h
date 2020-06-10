//
//  MTLDays.h
//  FIT
//
//  Created by Karim Sallam on 12/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "FITDays.h"

@class MTLSupplement;

@interface MTLDays : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly) FITDays days;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSArray<MTLSupplement *> *breakfastSupplements;
@property (nonatomic, strong, readonly) NSArray<MTLSupplement *> *snackSupplements;
@property (nonatomic, strong, readonly) NSArray<MTLSupplement *> *lunchSupplements;
@property (nonatomic, strong, readonly) NSArray<MTLSupplement *> *dinnerSupplements;
@property (nonatomic, strong, readonly) NSArray<MTLSupplement *>  *eveningSupplements;

+ (NSValueTransformer *)daysValueTransformer;

@end
