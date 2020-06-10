//
//  FITFoodMealCell.h
//  fitapp
//
//  Created by Hadi Roohian on 29/12/2016.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FITFoodMealCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mealLbl;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UIButton *rowCheckBtn;
@property (weak, nonatomic) IBOutlet UIView *backgroud;

@property (weak, nonatomic) IBOutlet UIView *buttonBackground;
@property (weak, nonatomic) IBOutlet UIButton *baseButton;


- (IBAction)rowCheckBtnTapped:(id)sender;
- (IBAction)baseButtonTapped:(id)sender;

@end
