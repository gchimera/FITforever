//
//  Supplement.h
//  FIT
//
//  Created by Karim Sallam on 12/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"
#import "FITSupplementType.h"

@class MTLSupplement, MTLSupplementComponents, SupplementComponents;

@interface Supplement : BaseRealmData

- (id)initWithMantleModel:(MTLSupplement *)model;

@property NSString *idSupplement;
@property FITSupplementType supplementType;
@property NSString *title;
@property NSNumber<RLMInt> *sequence;
@property NSString *name;
@property NSString *language;
@property NSString *country;
@property SupplementComponents *components;

@end

RLM_ARRAY_TYPE(Supplement)

@interface SupplementComponents : BaseRealmData

- (id)initWithMantleModel:(MTLSupplementComponents *)model;

@property NSString *name;
@property (getter=isInterval) BOOL interval;
@property NSString *intervalTime;

@end
