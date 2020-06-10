//
//  ProgramDashboardViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 09/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramDashboardViewController.h"
#import "FITFoodOptionsVC.h"
#import "FITFoodSupplementsVC.h"
#import "CourseMealMap.h"
#import "FITFoodMealOptionsVC.h"
#import "C9PopupViewController.h"


@interface ProgramDashboardViewController ()
//@property int choose;  // 0 = lunch ; 1 = dinner
//@property NSInteger days;
@property NSInteger day;


@property NSInteger program;
@property NSInteger courseMapNumber;
@property RLMObject *courseMapResult;
@property NSString *mealSelected;

//@property NSString *programID;
//@property NSString *foodDisplayMode;
@end

@implementation ProgramDashboardViewController
@synthesize mealSelected;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self programButtonUpdate:self.checkList buttonMode:1 inSection:@"" forKey:@"" withColor:[UIColor whiteColor]];
    [self programButtonUpdate:self.progress buttonMode:1 inSection:@"" forKey:@""];
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    if(self.day > 0){
        self.dayLabel.text = [NSString stringWithFormat:@"%@ %ld",[self localisedStringForSection:CONTENT_FIT_C9_DASHBOARD_SECTION andKey:CONTENT_LABEL_DAY],(long)self.day];
    } else {
        
        self.dayLabel.text = [NSString stringWithFormat:@"%@ -",[self localisedStringForSection:CONTENT_FIT_C9_DASHBOARD_SECTION andKey:CONTENT_LABEL_DAY]];
    }
    
    
    if([self.currentCourse.courseType integerValue] == C9){
        [self viewConfigureC9];
    } else if ([self.currentCourse.courseType integerValue] == F15Begginner1) {
        [self viewConfigureF15Beginner1];
    } else if ([self.currentCourse.courseType integerValue] == F15Begginner2) {
        [self viewConfigureF15Beginner2];
    } else if ([self.currentCourse.courseType integerValue] == F15Intermidiate1) {
        [self viewConfigureF15Intermediate1];
    } else if ([self.currentCourse.courseType integerValue] == F15Intermidiate2) {
        [self viewConfigureF15Intermediate2];
    } else if ([self.currentCourse.courseType integerValue] == F15Advance1) {
        [self viewConfigureF15Advanced1];
    } else if ([self.currentCourse.courseType integerValue] == F15Advance2) {
        [self viewConfigureF15Advanced2];
    }
    
    
    
    self.program = [self.currentCourse.courseType integerValue];
    
    int tempDay = 0;
    int tempProgram = 0;
    switch ([self.currentCourse.courseType integerValue]) {
        case C9:
            if(self.day < 3) {
                tempDay = 1;
            } else {
                tempDay = 2;
            }
            tempProgram = 0;
            break;
            
        case F15Begginner1:
            tempProgram = 2;
            tempDay = 1;
            break;
        case F15Begginner2:
            tempProgram = 3;
            tempDay = 1;
            break;
            
        default:
            tempProgram = 7;
            tempDay = 1;
            break;
    }
            NSLog(@"%@",self.currentCourse.thirdDayChoose);

    if([self.currentCourse.thirdDayChoose isEqual: @1]) {

        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [CourseMealMap createOrUpdateInRealm:realm withValue:@{ @"id" : @2, @"lunch" : @3, @"dinner" : @2}];
        [realm commitWriteTransaction];
  
    } else if([self.currentCourse.thirdDayChoose isEqual: @2]) {
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [CourseMealMap createOrUpdateInRealm:realm withValue:@{ @"id" : @2, @"lunch" : @2, @"dinner" : @3}];
        [realm commitWriteTransaction];

    }
    
    
    
    self.courseMapResult = [[CourseMealMap objectsWhere:[NSString stringWithFormat:@"program = %d && day = %d",tempProgram, tempDay]] firstObject];
    
    if(self.day > 0) {
        [self.bottomMenu.waterBtn setEnabled:YES];
        [self.bottomMenu.trophyBtn setEnabled:YES];
        [self.bottomMenu.homeBtn setEnabled:YES];
        [self.bottomMenu.exerciseBtn setEnabled:YES];
        [self.bottomMenu.weightBtn setEnabled:YES];
    } else {
        [self.bottomMenu.waterBtn setEnabled:NO];
        [self.bottomMenu.trophyBtn setEnabled:NO];
        [self.bottomMenu.homeBtn setEnabled:NO];
        [self.bottomMenu.exerciseBtn setEnabled:NO];
        [self.bottomMenu.weightBtn setEnabled:NO];
    }
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.day > 0) {
        if([self.currentCourse.thirdDayChoose integerValue] == 0 && self.program == 0 && self.day > 2){
            C9PopupViewController *popUpViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"C9PopupViewController"];
            [self.navigationController pushViewController:popUpViewController animated:YES];
        }
    }
    
    
    RLMResults *results = [UserCourse allObjects];
    NSLog(@"%@",results);
    
    RLMResults *resutls2 = [CourseMealMap allObjects];
    NSLog(@"%@",resutls2);

}

-(void)viewConfigureC9
{
    
    
    [self programButtonUpdate:self.option1Button buttonMode:1 inSection:CONTENT_FIT_C9_DASHBOARD_SECTION forKey:CONTENT_BUTTON_BREAKFAST];
    [self programButtonUpdate:self.option2Button buttonMode:1 inSection:CONTENT_FIT_C9_DASHBOARD_SECTION forKey:CONTENT_BUTTON_MORNING_SNACK];
    
    [self programButtonUpdate:self.option3Button buttonMode:1 inSection:CONTENT_FIT_C9_DASHBOARD_SECTION forKey:CONTENT_BUTTON_LUNCH];
    [self programButtonUpdate:self.option4Button buttonMode:1 inSection:CONTENT_FIT_C9_DASHBOARD_SECTION forKey:CONTENT_BUTTON_DINNER];
    [self programButtonUpdate:self.option5Button buttonMode:1 inSection:CONTENT_FIT_C9_DASHBOARD_SECTION forKey:CONTENT_BUTTON_EVENINGS];
    [self programButtonUpdate:self.option6Button buttonMode:1 inSection:CONTENT_FIT_C9_DASHBOARD_SECTION forKey:CONTENT_BUTTON_FREE_FOODS];
    [self programImageUpdate:self.programImage withImageName:@"programName"];
    [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_FIT_C9_DASHBOARD_SECTION andKey:CONTENT_DASHBOARD_SCREEN_TITLE]];
    
    
    [self programLabelColor:self.dayLabel];
    
    
    [self.checkList setExclusiveTouch:YES];
    [self.progress setExclusiveTouch:YES];
    [self.option6Button setExclusiveTouch:YES];
    [self.option1Button setExclusiveTouch:YES];
    [self.option5Button setExclusiveTouch:YES];
    [self.option2Button setExclusiveTouch:YES];
    [self.option4Button setExclusiveTouch:YES];
    [self.option3Button setExclusiveTouch:YES];
    
    
}

-(void)viewConfigureF15Beginner1
{
    
    
    [self programButtonUpdate:self.option1Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION forKey:CONTENT_BUTTON_BREAKFAST];
    [self programButtonUpdate:self.option2Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION  forKey:CONTENT_BUTTON_MORNING_SNACK];
    [self programButtonUpdate:self.option3Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION  forKey:CONTENT_BUTTON_LUNCH];
    [self programButtonUpdate:self.option4Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION  forKey:CONTENT_BUTTON_DINNER];
    [self programButtonUpdate:self.option5Button buttonMode:1 inSection:@""  forKey:@"" withColor:[THM F15BegginerColorDisable]];
    [self programButtonUpdate:self.option6Button buttonMode:1 inSection:@""  forKey:@"" withColor:[THM F15BegginerColorDisable]];
    [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_FIT_F15_DASHBOARD_SECTION andKey:CONTENT_DASHBOARD_SCREEN_TITLE]];
    
    [self programImageUpdate:self.programImage withImageName:@"programName"];
    [self programLabelColor:self.dayLabel];
    
    [self.checkList setExclusiveTouch:YES];
    [self.progress setExclusiveTouch:YES];
    
    [self.option1Button setExclusiveTouch:YES];
    [self.option2Button setExclusiveTouch:YES];
    [self.option3Button setExclusiveTouch:YES];
    [self.option4Button setExclusiveTouch:YES];
    
    [self.option5Button setExclusiveTouch:NO];
    [self.option6Button setExclusiveTouch:NO];
    
    [self.option5Button setEnabled:false];
    [self.option6Button setEnabled:false];
}

-(void)viewConfigureF15Beginner2
{
    
    
    [self programButtonUpdate:self.option1Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION forKey:CONTENT_BUTTON_BREAKFAST];
    [self programButtonUpdate:self.option2Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION  forKey:CONTENT_BUTTON_MORNING_SNACK];
    [self programButtonUpdate:self.option3Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION  forKey:CONTENT_BUTTON_LUNCH];
    [self programButtonUpdate:self.option4Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION  forKey:CONTENT_BUTTON_DINNER];
    [self programButtonUpdate:self.option5Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION  forKey:CONTENT_BUTTON_SHAKES];
    [self programButtonUpdate:self.option6Button buttonMode:1 inSection:@""  forKey:@"" withColor:[THM F15BegginerColorDisable]];
    [self programImageUpdate:self.programImage withImageName:@"programName"];
    
    [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_FIT_F15_DASHBOARD_SECTION andKey:CONTENT_DASHBOARD_SCREEN_TITLE]];
    
    [self programLabelColor:self.dayLabel];
    
    [self.checkList setExclusiveTouch:YES];
    [self.progress setExclusiveTouch:YES];
    [self.option1Button setExclusiveTouch:YES];
    [self.option5Button setExclusiveTouch:YES];
    [self.option2Button setExclusiveTouch:YES];
    [self.option4Button setExclusiveTouch:YES];
    [self.option3Button setExclusiveTouch:YES];
    
    [self.option6Button setExclusiveTouch:NO];
    [self.option6Button setEnabled:false];
}


-(void)viewConfigureF15CommonIntermediate
{
    
    
    [self programButtonUpdate:self.option1Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION forKey:CONTENT_BUTTON_BREAKFAST];
    [self programButtonUpdate:self.option2Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION  forKey:CONTENT_BUTTON_MORNING_SNACK];
    [self programButtonUpdate:self.option3Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION  forKey:CONTENT_BUTTON_LUNCH];
    [self programButtonUpdate:self.option4Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION  forKey:CONTENT_BUTTON_DINNER];
    [self programButtonUpdate:self.option5Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION  forKey:CONTENT_BUTTON_SHAKES];
    [self programButtonUpdate:self.option6Button buttonMode:1 inSection:@""  forKey:@"" withColor:[THM F15IntermidiateColorDisable]];
    [self programImageUpdate:self.programImage withImageName:@"programName"];
    //    [self programImageUpdate:self.programImage withImageName:@"programName"];
    
    [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_FIT_F15_DASHBOARD_SECTION andKey:CONTENT_DASHBOARD_SCREEN_TITLE]];
    
    [self programLabelColor:self.dayLabel];
    
    [self.checkList setExclusiveTouch:YES];
    [self.progress setExclusiveTouch:YES];
    [self.option1Button setExclusiveTouch:YES];
    [self.option2Button setExclusiveTouch:YES];
    [self.option3Button setExclusiveTouch:YES];
    [self.option4Button setExclusiveTouch:YES];
    [self.option5Button setExclusiveTouch:YES];
    
    [self.option6Button setExclusiveTouch:NO];
    [self.option6Button setEnabled:false];
    
}


-(void)viewConfigureF15CommonAdvanced
{
    
    
    [self programButtonUpdate:self.option1Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION forKey:CONTENT_BUTTON_BREAKFAST];
    [self programButtonUpdate:self.option2Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION  forKey:CONTENT_BUTTON_MORNING_SNACK];
    [self programButtonUpdate:self.option3Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION  forKey:CONTENT_BUTTON_LUNCH];
    [self programButtonUpdate:self.option4Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION  forKey:CONTENT_BUTTON_DINNER];
    [self programButtonUpdate:self.option5Button buttonMode:1 inSection:CONTENT_FIT_F15_DASHBOARD_SECTION  forKey:CONTENT_BUTTON_SHAKES];
    [self programButtonUpdate:self.option6Button buttonMode:1 inSection:@""  forKey:@"" withColor:[THM F15AdvanceColorDisable]];
    [self programImageUpdate:self.programImage withImageName:@"programName"];
    //    [self programImageUpdate:self.programImage withImageName:@"programName"];
    
    [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_FIT_F15_DASHBOARD_SECTION andKey:CONTENT_DASHBOARD_SCREEN_TITLE]];
    
    [self programLabelColor:self.dayLabel];
    
    [self.checkList setExclusiveTouch:YES];
    [self.progress setExclusiveTouch:YES];
    [self.option1Button setExclusiveTouch:YES];
    [self.option2Button setExclusiveTouch:YES];
    [self.option3Button setExclusiveTouch:YES];
    [self.option4Button setExclusiveTouch:YES];
    [self.option5Button setExclusiveTouch:YES];
    
    [self.option6Button setExclusiveTouch:NO];
    [self.option6Button setEnabled:false];
    
}


-(void)viewConfigureF15Intermediate1
{
    
    
    [self viewConfigureF15CommonIntermediate];
    
}

-(void)viewConfigureF15Intermediate2
{
    
    
    [self viewConfigureF15CommonIntermediate];
    
}

-(void)viewConfigureF15Advanced1
{
    
    
    [self viewConfigureF15CommonAdvanced];
    
}

-(void)viewConfigureF15Advanced2
{
    
    
    [self viewConfigureF15CommonAdvanced];
    
}



- (IBAction)foodBtnTapped:(UIButton *)sender {
    
    if(self.day > 0) {
        
        switch (sender.tag) {
            case 1:
                mealSelected = @"Breakfast";
                break;
            case 2:
                mealSelected = @"Snack";
                break;
            case 3:
                mealSelected = @"Lunch";
                break;
            case 4:
                mealSelected = @"Dinner";
                break;
            case 5:
                mealSelected = @"EveningShake";
                break;
                
            default:
                break;
        }
        
        
        if ([mealSelected isEqualToString:@"Breakfast"]) {
            
            switch ([[self.courseMapResult valueForKey:@"breakfast"] integerValue]) {
                case 1:
                    [self performSegueWithIdentifier:@"FoodSupplementsVC" sender:self];
                    
                    break;
                case 2:
                    self.courseMapNumber = 2;
                    [self performSegueWithIdentifier:@"FoodOptionsVC" sender:sender];
                    break;
                    
                case 3:
                    self.courseMapNumber = 3;
                    [self performSegueWithIdentifier:@"FoodOptionsVC" sender:sender];
                    break;
                    
                case 4:
                    self.courseMapNumber = 4;
                    [self performSegueWithIdentifier:@"FITFoodMealOptionsVC" sender:sender];
                    break;
                    
                default:
                    break;
            }
            
            
            
            
            
        } else if([mealSelected isEqualToString:@"Snack"]) {
            
            switch ([[self.courseMapResult valueForKey:@"morningSnack"] integerValue]) {
                case 1:
                    [self performSegueWithIdentifier:@"FoodSupplementsVC" sender:self];
                    
                    break;
                case 2:
                    self.courseMapNumber = 2;
                    [self performSegueWithIdentifier:@"FoodOptionsVC" sender:sender];
                    break;
                    
                case 3:
                    self.courseMapNumber = 3;
                    [self performSegueWithIdentifier:@"FoodOptionsVC" sender:sender];
                    break;
                    
                case 4:
                    self.courseMapNumber = 4;
                    [self performSegueWithIdentifier:@"FITFoodMealOptionsVC" sender:sender];
                    break;
                    
                default:
                    break;
            }
            
            
        } else if([mealSelected isEqualToString:@"Lunch"]) {
            
            switch ([[self.courseMapResult valueForKey:@"lunch"] integerValue]) {
                case 1:
                    [self performSegueWithIdentifier:@"FoodSupplementsVC" sender:self];
                    
                    break;
                case 2:
                    self.courseMapNumber = 2;
                    [self performSegueWithIdentifier:@"FoodOptionsVC" sender:sender];
                    break;
                    
                case 3:
                    self.courseMapNumber = 3;
                    [self performSegueWithIdentifier:@"FoodOptionsVC" sender:sender];
                    break;
                    
                case 4:
                    self.courseMapNumber = 4;
                    [self performSegueWithIdentifier:@"FITFoodMealOptionsVC" sender:sender];
                    break;
                    
                default:
                    break;
            }
            
        } else if([mealSelected isEqualToString:@"Dinner"]) {
            
            switch ([[self.courseMapResult valueForKey:@"dinner"] integerValue]) {
                case 1:
                    [self performSegueWithIdentifier:@"FoodSupplementsVC" sender:self];
                    
                    break;
                case 2:
                    self.courseMapNumber = 2;
                    [self performSegueWithIdentifier:@"FoodOptionsVC" sender:sender];
                    break;
                    
                case 3:
                    self.courseMapNumber = 3;
                    [self performSegueWithIdentifier:@"FoodOptionsVC" sender:sender];
                    break;
                    
                case 4:
                    self.courseMapNumber = 4;
                    [self performSegueWithIdentifier:@"FITFoodMealOptionsVC" sender:sender];
                    break;
                    
                default:
                    break;
            }
            
        } else if([mealSelected isEqualToString:@"EveningShake"]) {
            
            switch ([[self.courseMapResult valueForKey:@"eveningShake"] integerValue]) {
                case 1:
                    [self performSegueWithIdentifier:@"FoodSupplementsVC" sender:self];
                    
                    break;
                case 2:
                    self.courseMapNumber = 2;
                    [self performSegueWithIdentifier:@"FoodOptionsVC" sender:sender];
                    break;
                    
                case 3:
                    self.courseMapNumber = 3;
                    [self performSegueWithIdentifier:@"FoodOptionsVC" sender:sender];
                    break;
                    
                case 4:
                    self.courseMapNumber = 4;
                    [self performSegueWithIdentifier:@"FITFoodMealOptionsVC" sender:sender];
                    break;
                    
                default:
                    break;
            }
        }
        
    } else {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"This course hasn't started yet"
                                     message:@"This course hasn't started yet please wait and you will be notified when the course is ready to start"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender {
    
    //    if ([self.currentCourse.courseType integerValue]  == C9){
    FITFoodOptionsVC *foodOptionsVC = (FITFoodOptionsVC *)[segue destinationViewController];
    FITFoodSupplementsVC *foodSupplementsVC = (FITFoodSupplementsVC *)[segue destinationViewController];
    FITFoodMealOptionsVC *foodMealOptionsVC = (FITFoodMealOptionsVC *)[segue destinationViewController];
    
    
    
    if ([segue.identifier isEqualToString:@"FoodOptionsVC"]) {
        
        foodOptionsVC.mealSelected = mealSelected;
        foodOptionsVC.courseMapNumber = self.courseMapNumber;
        
        
    } else if ([segue.identifier isEqualToString:@"FoodSupplementsVC"]) {
        
        foodSupplementsVC.mealSelected = mealSelected;
        foodSupplementsVC.courseMapNumber = self.courseMapNumber;
        
    } else if ([segue.identifier isEqualToString:@"FITFoodMealOptionsVC"]) {
        
        foodMealOptionsVC.mealSelected = mealSelected;
        foodMealOptionsVC.courseMapNumber = self.courseMapNumber;
    }
    
    
    
    
}
- (IBAction)checklistTap:(id)sender {
    if(self.day > 0) {
        UIViewController *checklist = [self.storyboard instantiateViewControllerWithIdentifier:@"CheckListViewController"];
        [self.navigationController pushViewController:checklist animated:YES];
    } else {
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"This course hasn't started yet"
                                     message:@"This course hasn't started yet please wait and you will be notified when the course is ready to start"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}

- (IBAction) buttonPressed:(UIButton *)sender
{
    
    NSLog(@"button Tag:%@",sender);
}

- (IBAction)freeFoodsBtnTapped:(id)sender {
    if(self.day > 0) {
    UIViewController *freefood = [self.storyboard instantiateViewControllerWithIdentifier:F15_FREEFOOD];
    [self.navigationController pushViewController:freefood animated:YES];
    } else {
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"This course hasn't started yet"
                                     message:@"This course hasn't started yet please wait and you will be notified when the course is ready to start"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)progressBtnTapped:(id)sender {
    if(self.day > 0) {
        UIViewController *progress = [self.storyboard instantiateViewControllerWithIdentifier:PROGRESS_SCREEN];
        [self.navigationController pushViewController:progress animated:YES];
    } else {
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"This course hasn't started yet"
                                     message:@"This course hasn't started yet please wait and you will be notified when the course is ready to start"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}

@end
