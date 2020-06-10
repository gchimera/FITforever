//
//  Days.h
//  FIT
//
//  Created by Karim Sallam on 12/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"
#import "FITDays.h"
#import "Supplement.h"

@class MTLDays, Supplement;

@interface Days : BaseRealmData

- (id)initWithMantleModel:(MTLDays *)model;

@property NSString *idDays;
@property (readonly) FITDays days;
@property NSString *name;
@property RLMArray<Supplement *><Supplement> *breakfastSupplements;
@property RLMArray<Supplement *><Supplement> *snackSupplements;
@property RLMArray<Supplement *><Supplement> *lunchSupplements;
@property RLMArray<Supplement *><Supplement> *dinnerSupplements;
@property RLMArray<Supplement *><Supplement> *eveningSupplements;

@end

RLM_ARRAY_TYPE(Days)
