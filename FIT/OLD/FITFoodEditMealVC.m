//
//  FITFoodEditMealVC.m
//  fitapp
//
//  Created by Hadi Roohian on 30/12/2016.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import "FITFoodEditMealVC.h"
#import "FITFoodMealOptionsVC.h"
#import "CustomRecipe.h"
#import <Realm/Realm.h>


@interface FITFoodEditMealVC ()
@property (strong, nonatomic) FITBurgerMenu *rootNav;

@property int day;
@property RLMResults *result;

@end

@implementation FITFoodEditMealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //    @property (weak, nonatomic) IBOutlet UIView *nameBackgroundView;
    //    @property (weak, nonatomic) IBOutlet UIView *caloriesBackgroundView;
    //    @property (weak, nonatomic) IBOutlet UIView *descBackgroundView;
    [self programViewColor:self.nameBackgroundView];
    
    if([self.currentCourse.courseType integerValue] == C9){
        [self.caloriesBackgroundView setBackgroundColor:[THM C9Color]];
        [self.descBackgroundView setBackgroundColor:[THM C9Color]];
    } else {
        [self.caloriesBackgroundView setBackgroundColor:[THM BMColor]];
        [self.descBackgroundView setBackgroundColor:[THM BMColor]];
    }

    
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    NSLog(@"%ld",(long)self.day);
    
    NSLog(@"%@",_sender);
    
    [self programButtonUpdate:self.addMealBtn buttonMode:3 inSection:CONTENT_FIT_C9_MEALS_SECTION forKey:CONTENT_BUTTON_ADD_MEAL];
    [self programButtonUpdate:self.closeBtn buttonMode:3 inSection:CONTENT_FIT_C9_MEALS_SECTION forKey:CONTENT_BUTTON_CLOSE];
    [self programButtonUpdate:self.editBtn buttonMode:3 inSection:CONTENT_FIT_C9_MEALS_SECTION forKey:CONTENT_BUTTON_EDIT];
    [self programButtonUpdate:self.addIngredientsBtn buttonMode:3 inSection:CONTENT_FIT_F15_MEALS_SECTION forKey:CONTENT_BUTTON_ADD_YOUR_OWN_INGREDIENTS];
    
    self.titleLabel.text = [self localisedStringForSection:CONTENT_FIT_C9_MEALS_SECTION andKey:CONTENT_LABEL_CREATE_YOUR_OWN_MEAL];
    
    if([self.currentCourse.courseType integerValue] == C9){
        self.titleLabel.textColor = [THM C9Color];
        self.addIngredientsBtn.hidden = YES;
    } else {
        self.titleLabel.textColor = [THM BMColor];
        self.addIngredientsBtn.hidden = NO;
    }
    
    self.nameLbl.text = self.mealDictionary[@"name"];
    self.caloriesLbl.text = self.mealDictionary[@"estimatedCalories"];
    self.descLbl.text = self.mealDictionary[@"desc"];
    
    self.rootNav = (FITBurgerMenu *)self.navigationController;
    [self.rootNav setFITNavDrawerDelegate:self];
}

 
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)persistDataInRealm:(NSDictionary *)mealDictionary {
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm beginWriteTransaction];
//    
//    
//    if ([_sender isEqualToString:@"dinner"]) {
//        
//        Dinner *dinnerCreateMeal = [[Dinner alloc] initWithMealDictionary:mealDictionary];
//        [realm addOrUpdateObject:dinnerCreateMeal];
//        
//    }else if ([_sender isEqualToString:@"shake"]) {
//        
//            Shake *shakeCreateMeal = [[Shake alloc] initWithMealDictionary:mealDictionary];
//            [realm addOrUpdateObject:shakeCreateMeal];
//        
//    } else if ([_sender isEqualToString:@"breakfast"]) {
//        
//        Breakfast *breakfastCreateMeal = [[Breakfast alloc] initWithMealDictionary:mealDictionary];
//        [realm addOrUpdateObject:breakfastCreateMeal];
//        
//    } else if ([_sender isEqualToString:@"lunch"]) {
//        
//        Lunch *lunchCreateMeal = [[Lunch alloc] initWithMealDictionary:mealDictionary];
//        [realm addOrUpdateObject:lunchCreateMeal];
//        
//    } else if ([_sender isEqualToString:@"evening"]) {
//        
//        Evening *eveningCreateMeal = [[Evening alloc] initWithMealDictionary:mealDictionary];
//        [realm addOrUpdateObject:eveningCreateMeal];
//        
//    }
//
//    [realm commitWriteTransaction];
// }





- (IBAction)addMealBtnTapped:(id)sender {
    
    
    if (!([self.mealDictionary[@"name"] isEqualToString:@""]  && [self.mealDictionary[@"estimatedCalories"]isEqualToString:@""] && [self.mealDictionary[@"desc"] isEqualToString:@""])) {
//        [sender setUserInteractionEnabled:NO];
//        [self persistDataInRealm:@{
//               @"name":self.mealDictionary[@"name"],
//               @"calories":self.mealDictionary[@"calories"],
//               @"ingredients":self.mealDictionary[@"desc"],
//               @"programID":self.programID
//       }];
        
//        [self sendReceipe];
        NSLog(@"Meal Dict = %@",self.mealDictionary.debugDescription);
        [self performSelector:@selector(dismissController) withObject:nil afterDelay:0.5];
    } else {
        //Alert To Fill The Form Completely.
        NSLog(@"HADI Error: at least one of the fields is empty!");
    }
}

- (void) dismissController {
    //    [[self navigationController] popViewControllerAnimated:YES];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        
        //Do not forget to import AnOldViewController.h
        if ([controller isKindOfClass:[FITFoodMealOptionsVC class]]) {
            
            [self.navigationController popToViewController:controller
                                                  animated:YES];
            break;
        }
    }
}

- (IBAction)editBtnTapped:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}


#pragma mark - burger delegate

-(void)FITNavDrawerSelection:(NSInteger)selectionIndex
{
    NSLog(@"FITNavDrawerSelection = %li", (long)selectionIndex);
}


- (IBAction)closeBtnTapped:(id)sender {
    FITFoodMealOptionsVC *foodMealOptionsVC = (FITFoodMealOptionsVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"FITFoodMealOptionsVC"];
    foodMealOptionsVC.mealSelected = self.mealSelected;
    foodMealOptionsVC.courseMapNumber = self.courseMapNumber;
    [self.navigationController pushViewController:foodMealOptionsVC animated:YES];
}
@end

