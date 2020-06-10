//
//  Days.m
//  FIT
//
//  Created by Karim Sallam on 12/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "Days.h"
#import "MTLDays.h"
#import "Supplement.h"

@implementation Days

+ (NSString *)primaryKey {
    return @"idDays";
}

- (id)initWithMantleModel:(MTLDays *)model {
    self = [super init];
    if(!self) return nil;
    
    self.idDays = [[MTLDays daysValueTransformer] reverseTransformedValue:@(model.days)];
    self.name = model.name;
    
    [self addSupplementsFromModel:model.breakfastSupplements toArray:self.breakfastSupplements];
    [self addSupplementsFromModel:model.snackSupplements toArray:self.snackSupplements];
    [self addSupplementsFromModel:model.lunchSupplements toArray:self.lunchSupplements];
    [self addSupplementsFromModel:model.dinnerSupplements toArray:self.dinnerSupplements];
    [self addSupplementsFromModel:model.eveningSupplements toArray:self.eveningSupplements];
    
    return self;
}

- (void)addSupplementsFromModel:(NSArray<MTLSupplement *> *)model toArray:(RLMArray<Supplement *><Supplement> *)supplements {
    for (MTLSupplement *supplement in model) {
        [supplements addObject:[[Supplement alloc] initWithMantleModel:supplement]];
    }
}

- (FITDays)days {
    return [[[MTLDays daysValueTransformer] transformedValue:self.idDays] integerValue];
}

@end
