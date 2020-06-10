//
//  recipeDetail.h
//  FIT
//
//  Created by Guglielmo Chimera on 03/04/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuBaseViewController.h"

@interface recipeDetail : MenuBaseViewController

@property (weak, nonatomic) IBOutlet UILabel *mainWorkoutLB;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet FITButton *doneBtn;
@property IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *descRecipeLB;
@property NSString* descRecipe;
@property NSString *imglink;
@property NSString* nameRecipe;
@property NSString* calories;
@property NSString* ingredients;

@property (weak, nonatomic) IBOutlet UIButton *caloriesBT;

@end
