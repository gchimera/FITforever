//
//  MTLWorkoutComponent.h
//  FIT
//
//  Created by Karim Sallam on 19/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MTLWorkoutComponent : MTLModel <MTLJSONSerializing>

@property (readonly, copy, nonatomic) NSString *thumbnailImage;
@property (readonly, copy, nonatomic) NSString *workoutVideo;
@property (readonly, copy, nonatomic) NSString *workoutDescription;
@property (readonly, copy, nonatomic) NSString *workoutName;

@end
