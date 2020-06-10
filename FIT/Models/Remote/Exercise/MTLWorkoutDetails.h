//
//  MTLWorkoutDetails.h
//  FIT
//
//  Created by Karim Sallam on 19/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <Mantle/Mantle.h>

@class MTLWorkoutComponents;

@interface MTLWorkoutDetails : MTLModel <MTLJSONSerializing>

@property (readonly, copy, nonatomic) NSString *idWorkoutDetails;
@property (readonly, copy, nonatomic) NSString *type;
@property (readonly, copy, nonatomic) NSString *title;
@property (readonly, copy, nonatomic) NSString *name;
@property (readonly, copy, nonatomic) NSString *language;
@property (readonly, copy, nonatomic) NSString *country;
@property (readonly, strong, nonatomic) MTLWorkoutComponents *components;

@end
