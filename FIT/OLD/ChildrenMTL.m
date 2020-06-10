//
//  ChildrenMTL.m
//  fitapp
//
//  Created by Guglielmo Chimera on 23/12/16.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import "ChildrenMTL.h"
#import "itemsMTL.h"

@implementation ChildrenMTL

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name" : @"name",
             @"one" : @"items.fitapp-one-serving-foods",
             @"two" : @"items.fitapp-two-serving-foods",
             @"free" : @"items.fitapp-free-foods",

             };
}


+ (NSValueTransformer *)childrenJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:itemsMTL.class];
}


@end
