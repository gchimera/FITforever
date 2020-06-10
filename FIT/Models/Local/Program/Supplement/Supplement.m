//
//  Supplement.m
//  FIT
//
//  Created by Karim Sallam on 12/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "Supplement.h"
#import "MTLSupplement.h"

@implementation Supplement

+ (NSString *)primaryKey {
    return @"idSupplement";
}

- (id)initWithMantleModel:(MTLSupplement *)model {
    self = [super init];
    if(!self) return nil;
    
    self.idSupplement = model.idSupplement;
    self.supplementType = model.supplementType;
    self.title = model.title;
    self.sequence = model.sequence;
    self.name = model.name;
    self.language = model.language;
    self.country = model.country;
    self.components = [[SupplementComponents alloc] initWithMantleModel:model.components];
    
    return self;
}

+ (NSArray *)ignoredProperties {
    return @[@"supplementType"];
}

@end

@implementation SupplementComponents

- (id)initWithMantleModel:(MTLSupplementComponents *)model {
    self = [super init];
    if(!self) return nil;
    
    self.name = model.name;
    self.interval = model.interval;
    self.intervalTime = model.intervalTime;
    
    return self;
}

@end
