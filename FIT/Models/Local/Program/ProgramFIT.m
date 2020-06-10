//
//  ProgramFIT.m
//  FIT
//
//  Created by Karim Sallam on 12/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramFIT.h"
#import "MTLProgram.h"
#import "Days.h"

@implementation ProgramFIT

+ (NSString *)primaryKey {
    return @"idProgram";
}

- (id)initWithMantleModel:(MTLProgram *)model {
    self = [super init];
    if(!self) return nil;

    self.idProgram = [[MTLProgram programValueTransformer] reverseTransformedValue:@(model.program)];
    self.name = model.name;
    
    for (MTLDays *mtlDays in model.days) {
        [self.days addObject:[[Days alloc] initWithMantleModel:mtlDays]];
    }

    return self;
}

- (FITProgram)program {
    return [[[MTLProgram programValueTransformer] transformedValue:self.idProgram] integerValue];
}

@end
