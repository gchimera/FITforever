//
//  ProgramFIT.h
//  FIT
//
//  Created by Karim Sallam on 12/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"
#import "FITProgram.h"
#import "Days.h"

@class MTLProgram;

@interface ProgramFIT : BaseRealmData

- (id)initWithMantleModel:(MTLProgram *)model;

@property NSString *idProgram;
@property (readonly) FITProgram program;
@property NSString *name;
@property RLMArray<Days *><Days> *days;

@end
