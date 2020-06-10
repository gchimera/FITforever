//
//  MTLProgram.m
//  FIT
//
//  Created by Karim Sallam on 12/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MTLProgram.h"
#import "FITDays.h"
#import "MTLDays.h"

@implementation MTLProgram

+ (NSValueTransformer *)programValueTransformer {
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{@"fit-supplements-c9":@(Clean9),
                                                                           @"fit-supplements-f15":@(Forever15),
                                                                           @"fit-supplements-v5":@(Vital5)
                                                                           }];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *base = [NSMutableDictionary dictionaryWithDictionary:[BaseResponse JSONKeyPathsByPropertyKey]];
    [base addEntriesFromDictionary:@{@"program":@"data",
                                     @"name":@"data",
                                     @"days":@"data"
                                     }];
    return base;
}

+ (NSValueTransformer *)programJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *data, BOOL *success, NSError *__autoreleasing *error) {
        if (data.count == 1) {
            return [[self programValueTransformer] transformedValue:data[0][@"systemName"]];
        }
        
        *success = NO;
        return nil;
    }];
}

+ (NSValueTransformer *)daysJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *data, BOOL *success, NSError *__autoreleasing *error) {
        if (data.count == 1) {
            NSValueTransformer *transformer = [MTLJSONAdapter arrayTransformerWithModelClass:MTLDays.class];
            return [transformer transformedValue:data[0][@"children"]];
        }
        
        *success = NO;
        return nil;
    }];
}

+ (NSValueTransformer *)nameJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *data, BOOL *success, NSError *__autoreleasing *error) {
        if (data.count == 1) {
            return data[0][@"name"];
        }
        
        *success = NO;
        return nil;
    }];
}

@end
