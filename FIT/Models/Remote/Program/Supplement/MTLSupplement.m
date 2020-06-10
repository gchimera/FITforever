//
//  MTLSupplement.m
//  FIT
//
//  Created by Karim Sallam on 12/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MTLSupplement.h"

@implementation MTLSupplement

+ (NSValueTransformer *)supplementTypeValueTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{@"fitapp-supplements-breakfast":@(Breakfast),
                                                                           @"fitapp-supplements-snack":@(Snack),
                                                                           @"fitapp-supplements-lunch":@(Lunch),
                                                                           @"fitapp-supplements-dinner":@(Dinner),
                                                                           @"fitapp-supplements-evening":@(Evening)
                                                                           }];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"supplementType":@"type",
             @"title":@"title",
             @"sequence":@"sequence",
             @"name":@"name",
             @"language":@"language",
             @"idSupplement":@"id",
             @"country":@"country",
             @"components":@"components"
             };
}

+ (NSValueTransformer *)supplementTypeJSONTransformer {
    return [self supplementTypeValueTransformer];
}

+ (NSValueTransformer *)componentsJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:MTLSupplementComponents.class];
}

@end

@implementation MTLSupplementComponents

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"intervalTime":@"interval-time",
             @"interval":@"interval",
             @"name":@"name"
             };
}

@end
