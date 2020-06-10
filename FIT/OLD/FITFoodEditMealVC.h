//
//  FITFoodEditMealVC.h
//  fitapp
//
//  Created by Hadi Roohian on 30/12/2016.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Realm/Realm.h"
#import "ProgramBaseViewController.h"

@interface FITFoodEditMealVC : ProgramBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet FITButton *addMealBtn;
@property (weak, nonatomic) IBOutlet FITButton *closeBtn;
@property (weak, nonatomic) IBOutlet FITButton *editBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *caloriesLbl;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;
@property NSString* sender;
@property NSString *foodDisplayMode;
@property NSMutableDictionary *mealDictionary;
@property (weak, nonatomic) IBOutlet FITButton *addIngredientsBtn;
@property (weak, nonatomic) IBOutlet UIView *nameBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *caloriesBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *descBackgroundView;

- (IBAction)addMealBtnTapped:(id)sender;
- (IBAction)drawerToggle:(id)sender;
- (IBAction)editBtnTapped:(id)sender;
- (IBAction)closeBtnTapped:(id)sender;


// recveing or sending
@property NSString* mealSelected;
@property NSInteger courseMapNumber;


@end
