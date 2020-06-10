//
//  MTLExerciseComponents.h
//  FIT
//
//  Created by Karim Sallam on 19/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MTLExerciseComponents : MTLModel <MTLJSONSerializing>

@property (readonly, copy, nonatomic) NSString *duration;
@property (readonly, copy, nonatomic) NSString *name;

@end
