//
//  FITFoodCreateMeal.h
//  fitapp
//
//  Created by Hadi Roohian on 28/12/2016.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FITFoodEditMealVC.h"
#import "FITBurgerMenu.h"
#import "ProgramBaseViewController.h"


@interface FITFoodCreateMealVC : ProgramBaseViewController < UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet FITButton *saveBtn;
@property (weak, nonatomic) IBOutlet FITButton *cancelBtn;
@property (weak, nonatomic) IBOutlet FITButton *portionBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *caloriesTxtField;
@property (weak, nonatomic) IBOutlet UITextField *descTxtField;
@property (weak, nonatomic) IBOutlet UILabel *mealNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *calorieLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property NSMutableDictionary *mealDictionary;
@property NSString* mealSelected;
@property NSInteger courseMapNumber;
//@property NSString *foodDisplayMode;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottomConstraint;

- (IBAction)saveBtnTapped:(id)sender;
- (IBAction)drawerToggle:(id)sender;
- (IBAction)cancelBtnTapped:(id)sender;
- (IBAction)portionBtnTapped:(id)sender;

@end
