//
//  CustomRecipe.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"

@interface CustomRecipe : BaseRealmData

typedef enum : NSUInteger {
    TYPE_SHAKE = 0,
    TYPE_MEAL = 1
} CustomRecipeType;

@property (nonatomic, assign) NSString * _Nullable recipeID;

@property NSString * _Nullable name;
@property NSString * _Nullable serverId;
@property NSString * _Nullable estimatedCalories;
@property NSString * _Nullable description;
@property NSNumber<RLMInt> * _Nullable recipeType;
@property NSNumber<RLMInt> * _Nullable programType;


@end
