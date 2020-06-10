//
//  MTLDays.m
//  FIT
//
//  Created by Karim Sallam on 12/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MTLDays.h"
#import "MTLSupplement.h"

@implementation MTLDays

+ (NSValueTransformer *)daysValueTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{@"fit-supplements-c9-days-1-2":@(C9Days1to2),
                                                                           @"fit-supplements-c9-days-3-8":@(C9Days3to8),
                                                                           @"fit-supplements-c9-days-9":@(C9Day9),
                                                                           @"fit-supplements-f15-beginner-1":@(F15Beginner1Days),
                                                                           @"fit-supplements-f15-beginner-2":@(F15Beginner2Days),
                                                                           @"fit-supplements-f15-intermediate-1":@(F15Intermediate1Days),
                                                                           @"fit-supplements-f15-intermediate-2":@(F15Intermediate2Days),
                                                                           @"fit-supplements-f15-advanced-1":@(F15Advance1Days),
                                                                           @"fit-supplements-f15-advanced-2":@(F15Advance2Days),
                                                                           @"fit-supplements-f15":@(F15GenericDays)
                                                                           }];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"days":@"systemName",
             @"name":@"name",
             @"breakfastSupplements":@"items.fitapp-supplements-breakfast",
             @"snackSupplements":@"items.fitapp-supplements-snack",
             @"lunchSupplements":@"items.fitapp-supplements-lunch",
             @"dinnerSupplements":@"items.fitapp-supplements-dinner",
             @"eveningSupplements":@"items.fitapp-supplements-evening"
             };
}

+ (NSValueTransformer *)daysJSONTransformer {
    return [self daysValueTransformer];
}

+ (NSValueTransformer *)breakfastSupplementsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:MTLSupplement.class];
}

+ (NSValueTransformer *)snackSupplementsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:MTLSupplement.class];
}

+ (NSValueTransformer *)lunchSupplementsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:MTLSupplement.class];
}

+ (NSValueTransformer *)dinnerSupplementsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:MTLSupplement.class];
}

+ (NSValueTransformer *)eveningSupplementsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:MTLSupplement.class];
}

@end
