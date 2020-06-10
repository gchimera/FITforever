//
//  ChildrenMTL.h
//  fitapp
//
//  Created by Guglielmo Chimera on 23/12/16.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface ChildrenMTL : MTLModel <MTLJSONSerializing>


@property (nonatomic, copy) NSString *name;

@property (readonly, copy, nonatomic) NSArray *one;

@property (readonly, copy, nonatomic) NSArray *two;

@property (readonly, copy, nonatomic) NSArray *free;



@end
