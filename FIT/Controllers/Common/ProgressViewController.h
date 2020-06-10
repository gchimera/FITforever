//
//  ProgressViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface ProgressViewController : ProgramBaseViewController<UIScrollViewDelegate>

@property int supplementsNumber; //Supplements percentage number
@property int totalSupplementsChecked;
@property int totalSupplements;
@property (weak, nonatomic) IBOutlet UIImageView* topImage;

@property int mealsNumber; // Meals percentage number
@property int mealsPassed; // Meals percentage number
@property int totalMeal;;


@property int exerciseNumber; // Exercise percentage number
@property int exercisePassed;

@property int waterIntakeNumber; //Water percentage number
@property int waterIntakePassed; //Water already user had

@property int day; //Current day
@property int totalDays; //Total days needed to calculate the bars width
@property float screenWidth;
@property RLMResults *result;
@property int permenantCurrentDay;


@property (weak, nonatomic) IBOutlet FITButton *shapeSupplements;
@property (weak, nonatomic) IBOutlet FITButton *shapeMeals;
@property (weak, nonatomic) IBOutlet FITButton *shapeExercise;
@property (weak, nonatomic) IBOutlet FITButton *shapeWaterIntake;
@property (weak, nonatomic) IBOutlet UILabel *supplementsPercentLbl;
@property (weak, nonatomic) IBOutlet UILabel *mealsPercentLbl;
@property (weak, nonatomic) IBOutlet UILabel *exercisePercentLBL;
@property (weak, nonatomic) IBOutlet UILabel *waterIntakePercentLbl;

@property (weak, nonatomic) IBOutlet UILabel *supplementsLbl;
@property (weak, nonatomic) IBOutlet UILabel *mealsLbl;
@property (weak, nonatomic) IBOutlet UILabel *exerciseLbl;
@property (weak, nonatomic) IBOutlet UILabel *waterIntakeLbl;



@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *supTrailing;
@property (weak, nonatomic) IBOutlet UIView *scrollViewView;
@property (weak, nonatomic) IBOutlet UIButton *previousDaySupplementsBtn;
@property (weak, nonatomic) IBOutlet UIButton *previousDayMealsBtn;
@property (weak, nonatomic) IBOutlet UIButton *previousDayExerciseBtn;
@property (weak, nonatomic) IBOutlet UIButton *previousDayWaterBtn;


- (IBAction)previousDayButtons:(UIButton *)ButtonSender;

@end
