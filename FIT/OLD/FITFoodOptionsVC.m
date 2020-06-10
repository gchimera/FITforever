//
//  FITFoodOptions.m
//  fitapp
//
//  Created by Hadi Roohian on 29/12/2016.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import "FITFoodOptionsVC.h"
#import "FITFoodMealCell.h"
#import "Realm/Realm.h"
#import "FITFoodCreateMealVC.h"
//#import "Dinner.h"
//#import "Shake.h"
//#import "FITFoodDetails.h"
#import "FITFoodSupplementsVC.h"
#import "FITFoodMealOptionsVC.h"
#import "CourseMealMap.h"
#import "C9FinalPopupViewController.h"

@interface FITFoodOptionsVC ()
@property RLMObject *courseMapResult;
@property int day;
@property NSInteger program;
//@property NSInteger courseMapNumber;
@end

@implementation FITFoodOptionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self segueView] setAndDisplayNumItems:3 spacing:80];
    [[self segueView] setActiveItem:0];
    
    
    NSLog(@"%@",_mealSelected);
    
    [self programButtonUpdate:self.supplementsBtn buttonMode:1 inSection:CONTENT_FIT_C9_LUNCH_SECTION forKey:CONTENT_BUTTON_SUPPLEMENTS];
    [self programButtonUpdate:self.mealBtn buttonMode:1 inSection:CONTENT_FIT_C9_LUNCH_SECTION forKey:CONTENT_BUTTON_FOOD];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    self.program = [self.currentCourse.courseType integerValue];
    
    
    [self c9FinalDayPopup:self.mealSelected sender:nil];

    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = self.mealSelected;
  
    
}

- (void) c9FinalDayPopup:(NSString *)meal sender:(UIButton *)sender {
    
    if ([meal isEqualToString:@"Lunch"]) {
        if([self.currentCourse.thirdDayChoose integerValue] == 2 && self.program == 0 && self.day == 9) {
            C9FinalPopupViewController *finalPopupViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"C9FinalPopupViewController"];
            [self.navigationController pushViewController:finalPopupViewController animated:YES];

        }
    } else if ([meal isEqualToString:@"Dinner"]) {
        if([self.currentCourse.thirdDayChoose integerValue] == 1 && self.program == 0 && self.day == 9) {
            C9FinalPopupViewController *finalPopupViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"C9FinalPopupViewController"];
            [self.navigationController pushViewController:finalPopupViewController animated:YES];

        }
    }
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([[segue identifier] isEqualToString:@"meal"])
    {
        FITFoodMealOptionsVC *foodMealOptionsVC = (FITFoodMealOptionsVC *)[segue destinationViewController];
        foodMealOptionsVC.mealSelected = _mealSelected;
        foodMealOptionsVC.courseMapNumber = self.courseMapNumber;

        
    }else if ([[segue identifier] isEqualToString:@"supplement"]){
        
        FITFoodSupplementsVC *foodSupplementsVC = (FITFoodSupplementsVC *)[segue destinationViewController];
        foodSupplementsVC.mealSelected = _mealSelected;
        foodSupplementsVC.courseMapNumber = self.courseMapNumber;
    }
}

@end

