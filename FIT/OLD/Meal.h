//
//  Meal.h
//  fitapp
//
//  Created by Hadi Roohian on 22/02/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import "BaseRealmData.h"

@interface Meal : BaseRealmData

@property   (nonatomic, assign) NSString * _Nullable uid;
@property   NSString * _Nullable day;
@property NSString * _Nullable partOfDay;
@property NSString * _Nullable programID;
@property NSString * _Nullable foodID;
@property NSNumber<RLMInt> * _Nullable customFoodID;
@property BOOL isCustomRecipe;
@property NSNumber<RLMInt> * _Nullable serverMealId;

@end
RLM_ARRAY_TYPE(Meal)
