//
//  ProgressViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgressViewController.h"
#import "Supplements.h"
#import "Exercise.h"
#import "Water.h"
#import "Meal.h"
#import "ProgramFIT.h"
#import "CourseMealMap.h"

@interface ProgressViewController ()
@property RLMResults *programSupplementsResults;
@property NSInteger program;
@property NSString *supplementNameForUsingInRealmQuery;
@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RLMResults *currentProgram = [UserCourse objectsWhere:@"status = %d",1];
    
    if([currentProgram count] > 0){
        self.currentCourse = [[UserCourse alloc] init];
        self.currentCourse = [currentProgram objectAtIndex:0];
    }
    
    [self programButtonUpdate:_shapeSupplements buttonMode:2 inSection:@"" forKey:@""];
    [self programButtonUpdate:_shapeMeals buttonMode:2 inSection:@"" forKey:@""];
    [self programButtonUpdate:_shapeExercise buttonMode:2 inSection:@"" forKey:@""];
    [self programButtonUpdate:_shapeWaterIntake buttonMode:2 inSection:@"" forKey:@""];
    
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    self.permenantCurrentDay = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    self.program = [self.currentCourse.courseType integerValue];
    NSLog(@"%ld",(long)self.day);
    
    [self programImageUpdate:self.topImage withImageName:@"topshapes"];
    self.supplementsLbl.text = [self localisedStringForSection:CONTENT_FIT_C9_PROGRESS_SECTION andKey:CONTENT_LABEL_SUPPLEMENTS];
    self.mealsLbl.text =[self localisedStringForSection:CONTENT_FIT_C9_PROGRESS_SECTION andKey:CONTENT_LABEL_MEALS];
    self.exerciseLbl.text =[self localisedStringForSection:CONTENT_FIT_C9_PROGRESS_SECTION andKey:CONTENT_LABEL_EXERCISE];
    self.waterIntakeLbl.text =[self localisedStringForSection:CONTENT_FIT_C9_PROGRESS_SECTION andKey:CONTENT_LABEL_WATER_INTAKE];
    
    if([self.currentCourse.courseType integerValue] == C9){
        self.supplementsLbl.textColor = [THM C9Color];
        self.mealsLbl.textColor = [THM C9Color];
        self.exerciseLbl.textColor = [THM C9Color];
        self.waterIntakeLbl.textColor = [THM C9Color];
        [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_FIT_C9_PROGRESS_SECTION andKey:CONTENT_PROGRESS_SCREEN_TITLE]];
    } else {
        self.supplementsLbl.textColor = [THM BMColor];
        self.mealsLbl.textColor = [THM BMColor];
        self.exerciseLbl.textColor = [THM BMColor];
        self.waterIntakeLbl.textColor = [THM BMColor];
        [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_FIT_F15_PROGRESS_SECTION andKey:CONTENT_PROGRESS_SCREEN_TITLE]];
    }
    
    
    if  ([self.currentCourse.courseType integerValue] == C9) self.totalDays = 9;
    else  self.totalDays = 15;
    
    self.screenWidth = [[UIScreen mainScreen] bounds].size.width;
    self.scrollView.delegate = self;
    
    [self loadScrollviewContent];
    
    self.previousDayMealsBtn.hidden = YES;
    self.previousDayWaterBtn.hidden = YES;
    self.previousDayExerciseBtn.hidden = YES;
    self.previousDaySupplementsBtn.hidden = YES;
    
    //Center the current day button in the top scrollview everytime view appeare
    CGFloat newContentOffsetX = (self.scrollView.contentSize.width - self.scrollView.frame.size.width) / 2;
    self.scrollView.contentOffset = CGPointMake(-newContentOffsetX + ( (self.day - 1) * (self.screenWidth / 5) ), 0);
    [self calculateBarsPercentage];
    [self updateProgressBars];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (IBAction)previousDayButtons:(UIButton *)ButtonSender {
    //    FITPreviousDayEditVC *previousDayEditVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FITPreviousDayEditVC"];
    //
    //    switch (ButtonSender.tag) {
    //        case 1:
    //            previousDayEditVC.sender = @"supplements";
    //            break;
    //        case 2:
    //            previousDayEditVC.sender = @"meals";
    //            break;
    //        case 3:
    //            previousDayEditVC.sender = @"exercise";
    //            break;
    //        case 4:
    //            previousDayEditVC.sender = @"water";
    //            break;
    //
    //        default:
    //            break;
    //    }
    //
    //    [self.navigationController pushViewController:previousDayEditVC animated:YES];
    
    
}
#pragma mark - SCROLLVIEW CONTENT AND DAYS ACTION

//LOAD DAY BUTTONS INSIDE SCROLLVIEW
- (void)loadScrollviewContent {
    FITButton * btn;
    float btnWidth = (self.screenWidth / 5);
    for(int i = 1;i <= self.totalDays; i++) {
        btn = [FITButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont fontWithName:@"SanFranciscoText-Bold" size:15.0];
        
        NSLog(@"YEEEES %f",self.scrollView.frame.size.height);
        
        
        if  ([self.currentCourse.courseType integerValue] == C9) btn.frame = CGRectMake(((i - 1) * btnWidth) + (i * 2), 0, btnWidth, btnWidth * 1.2);
        else  btn.frame = CGRectMake(((i - 1) * btnWidth), 0, btnWidth, btnWidth * 1.2);
        
        
        [btn setTitle:[NSString stringWithFormat:@"DAY %d", i] forState:UIControlStateNormal];
        if(i == self.day) { //Current Day Button - Purple Color
            [btn setBackgroundColor:[UIColor colorWithRed:(92.0/255.0) green:(38.0/255.0) blue:(131.0/255.0) alpha:1]];
            [btn addTarget:self action:@selector(dayButtonTappedInScrollview:) forControlEvents:UIControlEventTouchUpInside];
            [self programButtonUpdate:btn buttonMode:1 inSection:@"" forKey:@""];
            [btn setTitle:[NSString stringWithFormat:@"%@ %d",[self localisedStringForSection:CONTENT_PROGRESS_SCREEN andKey:CONTENT_LABEL_DAY],i] forState:UIControlStateNormal];
        } else if ( i > self.day ) { //Future Days Button - Gray Color
            [btn setBackgroundColor:[UIColor colorWithRed:(250.0/255.0) green:(250.0/255.0) blue:(250.0/255.0) alpha:1]];
            [btn setTitleColor:[UIColor colorWithRed:(221.0/255.0) green:(221.0/255.0) blue:(221.0/255.0) alpha:1] forState:UIControlStateNormal];
            [self programButtonUpdate:btn buttonMode:5 inSection:@"" forKey:@""];
            [btn setTitle:[NSString stringWithFormat:@"%@ %d",[self localisedStringForSection:CONTENT_PROGRESS_SCREEN andKey:CONTENT_LABEL_DAY],i] forState:UIControlStateNormal];
            [btn setEnabled: NO];
        } else {
            //Previous Days Buttons - Light Purple Color
            [btn setBackgroundColor:[UIColor colorWithRed:(137.0/255.0) green:(82.0/255.0) blue:(138.0/255.0) alpha:1]];
            [btn addTarget:self action:@selector(dayButtonTappedInScrollview:) forControlEvents:UIControlEventTouchUpInside];
            [self programButtonUpdate:btn buttonMode:1 inSection:@"" forKey:@""];
            [btn setTitle:[NSString stringWithFormat:@"%@ %d",[self localisedStringForSection:CONTENT_PROGRESS_SCREEN andKey:CONTENT_LABEL_DAY],i] forState:UIControlStateNormal];
        }
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [btn setTag:i];
        [self.scrollView addSubview:btn];
    }
    
    if  ([self.currentCourse.courseType integerValue] == C9) [self.scrollView setContentSize:CGSizeMake( (btnWidth * self.totalDays) + (self.totalDays * 2), btnWidth * 1.2)];
    else  [self.scrollView setContentSize:CGSizeMake(btnWidth*self.totalDays, btnWidth * 1.2)];
    NSLog(@"%f",self.scrollView.frame.size.height);
    
    
}

//ACTION WHEN USER SELECTS A DAY
-(void) dayButtonTappedInScrollview:(UIButton *)sender {
    
    if(self.permenantCurrentDay == (int)sender.tag + 1) {
        self.previousDayMealsBtn.hidden = YES;
        self.previousDayWaterBtn.hidden = NO;
        self.previousDayExerciseBtn.hidden = NO;
        self.previousDaySupplementsBtn.hidden = NO;
    } else {
        self.previousDayMealsBtn.hidden = YES;
        self.previousDayWaterBtn.hidden = YES;
        self.previousDayExerciseBtn.hidden = YES;
        self.previousDaySupplementsBtn.hidden = YES;
    }
    
    self.day = (int)(sender.tag);
    self.navigationItem.title = [NSString stringWithFormat:@"Day %d", self.day];
    
    CGFloat newContentOffsetX;
    if  ([self.currentCourse.courseType integerValue] == C9) newContentOffsetX = (self.scrollView.contentSize.width - self.scrollView.frame.size.width) / 2;
    else  newContentOffsetX = (self.scrollView.contentSize.width - self.scrollView.frame.size.width) / 5;
    
    
     // 73 is each button width
    [self.scrollView setContentOffset:CGPointMake(-newContentOffsetX + ( ((sender.tag) - 1 ) * (self.screenWidth / 5) ), 0) animated:YES];
    [self calculateBarsPercentage];
    [self updateProgressBars];
    
    
}



#pragma mark - CALCULATE SUPPLEMENT,WATER AND BARS PERCENTAGE
//CALCULATE ALL THE SUPPLEMENTS CHECKED
-(void)loadCurrentCheckedCount {
    
    
    
    
    
    self.totalSupplements = 0;
    if(self.program == 0) {
        
        NSString *dayIDForUsingInRealmQuery;
        switch (self.day) {
            case 1 ... 2:
                dayIDForUsingInRealmQuery = @"fit-supplements-c9-days-1-2";
                break;
            case 3 ... 8:
                dayIDForUsingInRealmQuery = @"fit-supplements-c9-days-3-8";
                break;
            case 9:
                dayIDForUsingInRealmQuery = @"fit-supplements-c9-days-9";
            default:
                break;
        }
        
        
        NSArray *foodNames = @[@"breakfastSupplements",@"lunchSupplements", @"dinnerSupplements", @"snackSupplements",@"eveningSupplements"];
        
        for (int i = 0; i < [foodNames count]; i++) {
            NSString *name = [foodNames objectAtIndex:i];
            
        self.programSupplementsResults = [[[[[[ProgramFIT objectsWhere:[NSString stringWithFormat:@"name = 'C9'"]] valueForKey:@"days"] objectAtIndex:0] objectsWhere:[NSString stringWithFormat:@"idDays = '%@'",dayIDForUsingInRealmQuery]] valueForKey:name] objectAtIndex:0];
            
            
            for (RLMObject *supplement in self.programSupplementsResults) {
                NSLog(@"%@",[supplement valueForKey:@"components"]);
                if([[[supplement valueForKey:@"components"] valueForKey:@"interval"] boolValue]) {
                } else {
                    self.totalSupplements++;
                }
            }
        }
        
    } else {
        
        NSString *nameProgramForUsingInRealmQuery = [[NSString alloc] init];
        switch ([self.currentCourse.courseType integerValue]) {
            case F15Begginner1:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-beginner-1";
                break;
                
            case F15Begginner2:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-beginner-2";
                break;
                
            case F15Intermidiate1:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-intermediate-1";
                break;
                
            case F15Intermidiate2:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-intermediate-2";
                break;
                
            case F15Advance1:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-advanced-1";
                break;
                
            case F15Advance2:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-advanced-2";
                break;
                
            default:
                
                break;
        }
        
        
        NSArray *foodNames = @[@"breakfastSupplements",@"lunchSupplements", @"dinnerSupplements", @"snackSupplements",@"eveningSupplements"];
        
        
        for (int i = 0; i < [foodNames count]; i++) {
            NSString *name = [foodNames objectAtIndex:i];
            self.programSupplementsResults = [[[[[[ProgramFIT objectsWhere:[NSString stringWithFormat:@"name = 'F15'"]] valueForKey:@"days"] objectAtIndex:0] objectsWhere:[NSString stringWithFormat:@"idDays = '%@'", nameProgramForUsingInRealmQuery]] valueForKey:name] objectAtIndex:0];
            
            
            for (RLMObject *supplement in self.programSupplementsResults) {
                NSLog(@"%@",[supplement valueForKey:@"components"]);
                if([[[supplement valueForKey:@"components"] valueForKey:@"interval"] boolValue]) {
                } else {
                    self.totalSupplements++;
                }
            }
            
        }
        
    }
    NSLog(@"All Supppps : %@",self.programSupplementsResults);
    
    
    
    
//    
//    int systemDay;
//    switch (self.day) {
//        case 1 ... 2:
//            systemDay = 0;
//            break;
//        case 3 ... 8:
//            systemDay = 1;
//            break;
//        case 9:
//            systemDay = 2;
//            break;
//        default:
//            break;
//    }
    
    self.result = [Supplements objectsWhere:[NSString stringWithFormat:@"day = '%d' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
    NSLog(@"%@",_result);
    self.totalSupplementsChecked = (int)[[self.result objectsWithPredicate:[NSPredicate predicateWithFormat:@"isChecked == YES"]] count];
    //TODO HADIII
    //    self.result =  [FITC9Checklist objectsWhere:[NSString stringWithFormat:@"daysSystem = %d",systemDay]];
//    self.totalSupplements = (int)[self.result count];
//    if (self.day >= 3) {
//        self.totalSupplements -= 1;
//    }
    
}



- (void)fetchChecklistFromRealmForDay {
    //change real days to systemDays to use in our query to Realm DB.
    
    
    
    if(self.program == 0) {
        
        NSString *dayIDForUsingInRealmQuery;
        switch (self.day) {
            case 1 ... 2:
                dayIDForUsingInRealmQuery = @"fit-supplements-c9-days-1-2";
                break;
            case 3 ... 8:
                dayIDForUsingInRealmQuery = @"fit-supplements-c9-days-3-8";
                break;
            case 9:
                dayIDForUsingInRealmQuery = @"fit-supplements-c9-days-9";
            default:
                break;
        }
        
        
        
        //        self.programSupplementsResults = [[[[[[ProgramFIT objectsWhere:[NSString stringWithFormat:@"name = 'C9'"]] valueForKey:@"days"] objectAtIndex:0] objectsWhere:[NSString stringWithFormat:@"idDays = '%@'",dayIDForUsingInRealmQuery]] valueForKey:self.supplementNameForUsingInRealmQuery] objectAtIndex:0];
        
        
    } else {
        
        NSString *nameProgramForUsingInRealmQuery = [[NSString alloc] init];
        switch ([self.currentCourse.courseType integerValue]) {
            case F15Begginner1:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-beginner-1";
                break;
                
            case F15Begginner2:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-beginner-2";
                break;
                
            case F15Intermidiate1:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-intermediate-1";
                break;
                
            case F15Intermidiate2:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-intermediate-2";
                break;
                
            case F15Advance1:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-advanced-1";
                break;
                
            case F15Advance2:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-advanced-2";
                break;
                
            default:
                
                break;
        }
        
        
        
        
        
        //        self.programSupplementsResults = [[[[[[ProgramFIT objectsWhere:[NSString stringWithFormat:@"name = 'F15'"]] valueForKey:@"days"] objectAtIndex:0] objectsWhere:[NSString stringWithFormat:@"idDays = '%@'", nameProgramForUsingInRealmQuery]] valueForKey:self.supplementNameForUsingInRealmQuery] objectAtIndex:0];
    }
    NSLog(@"All Supppps : %@",self.programSupplementsResults);
    
}





//CALCULATE WATER USER ALREADY HAD
- (void)loadCurrentWaterRate {
    self.result = [Water objectsWhere:[NSString stringWithFormat:@"day = '%d' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
    int waterPassed = [[self.result sumOfProperty:@"count"] intValue];
    self.waterIntakePassed = waterPassed;
    
}


//CALCULATE EXERCISES USER ALREADY DONE
- (void)loadCurrentExercisePassed {
    self.result = [Exercise objectsWhere:[NSString stringWithFormat:@"day = '%d' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
    self.exercisePassed = (int)[self.result count];
    
}

//CALCULATE MEALS USER ALREADY DONE
- (void)loadCurrentMealsPassed {
    self.result = [Meal objectsWhere:[NSString stringWithFormat:@"day = '%d' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
    self.mealsPassed = (int)[self.result count];
    
}



//CALCULATE BARS PERCENTAGE
- (void)calculateBarsPercentage {
    [self loadCurrentCheckedCount];
    if (self.totalSupplementsChecked == 0 || self.totalSupplements == 0) {
        self.supplementsNumber = 0;
    } else {
        self.supplementsNumber = (self.totalSupplementsChecked * 100) / self.totalSupplements;
    }
    
    [self loadCurrentWaterRate];
    if (self.waterIntakePassed == 0) {
        self.waterIntakeNumber = 0;
    } else {
        self.waterIntakeNumber = (self.waterIntakePassed * 100) / 8;
    }
    
    [self loadCurrentExercisePassed];
    if (self.exercisePassed == 0) {
        self.exerciseNumber = 0;
    } else {
        self.exerciseNumber = (self.exercisePassed * 100) / 3;
    }
    
    
    [self loadCurrentMealsPassed];
    
    self.totalMeal = 0;
    
    
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

    RLMObject *mapResult = [[CourseMealMap objectsWhere:[NSString stringWithFormat:@"program = %d && day = %d",tempProgram, tempDay]] firstObject];
    
    NSLog(@"%@",mapResult);
    NSArray *foodNames = @[@"breakfast",@"morningSnack",@"lunch",@"dinner",@"eveningShake"];
    for (int i = 0; i < [foodNames count]; i++) {
        if([[mapResult valueForKey:foodNames[i]] integerValue] == 2 || [[mapResult valueForKey:foodNames[i]] integerValue] == 3 || [[mapResult valueForKey:foodNames[i]] integerValue] == 4 ) {
            self.totalMeal++;
        }
    }
    NSLog(@"Total mealssss %d", self.totalMeal);
    
    
    if (self.mealsPassed == 0) {
        self.mealsNumber = 0;
    } else {
        self.mealsNumber = (self.mealsPassed * 100) / self.totalMeal;
    }
    
    
}



#pragma mark - UPDATE PROGRESS BARS, PERCENTAGE LABELS

//UPDATE PROGRESS BARS AND PERCENTAGE LABELS
-(void) updateProgressBars {
    [self updateShapesSizeForButton:self.shapeSupplements Number:self.supplementsNumber withButtonMode:4];
    [self updateShapesSizeForButton:self.shapeMeals Number:self.mealsNumber withButtonMode:4];
    [self updateShapesSizeForButton:self.shapeExercise Number:self.exerciseNumber withButtonMode:4];
    [self updateShapesSizeForButton:self.shapeWaterIntake Number:self.waterIntakeNumber withButtonMode:4];
    
    self.supplementsPercentLbl.text = [NSString stringWithFormat:@"%d%%",self.supplementsNumber];
    self.mealsPercentLbl.text = [NSString stringWithFormat:@"%d%%",self.mealsNumber];
    self.exercisePercentLBL.text = [NSString stringWithFormat:@"%d%%",self.exerciseNumber];
    self.waterIntakePercentLbl.text = [NSString stringWithFormat:@"%d%%",self.waterIntakeNumber];
}


//UPDATE BARS SHAPE SIZE
- (void)updateShapesSizeForButton:(UIButton *)button Number:(float)number withButtonMode:(int)buttonMode  {
    
    
    float fill = 50.0 + ((self.screenWidth * number) / 100.0);
    float multiplyNumber = fill / (self.screenWidth + 100);
    UIImage *img = [FITButton  returnImageWithColor:[UIColor redColor] andFrame:button.frame sizeNumber:multiplyNumber];
    button.backgroundColor = [UIColor clearColor];
    
    [button setBackgroundImage:img forState:UIControlStateNormal];
    
    
    [self updateGradient:button];
}


#pragma mark - UPDATE GRADIENT ON BARS

- (void)updateGradient:(UIButton *)button {
    CAGradientLayer *gradient = [[CAGradientLayer alloc] init];
    gradient.frame = button.bounds ;
    gradient.position = CGPointMake((button.bounds.size.width /2), button.bounds.size.height /2);
    
    if([self.currentCourse.courseType integerValue] == C9){
        gradient.colors = [NSArray arrayWithObjects:
                           (id)[UIColor colorWithRed:(137.0/255.0) green:(82.0/255.0) blue:(138.0/255.0) alpha:1].CGColor,
                           (id)[UIColor colorWithRed:(255.0/255.0) green:(182.0/255.0) blue:(252.0/255.0) alpha:1].CGColor,
                           nil];
    } else if ([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2){
        gradient.colors = [NSArray arrayWithObjects:
                           (id)[UIColor colorWithRed:(137.0/255.0) green:(189.0/255.0) blue:(35.0/255.0) alpha:1].CGColor,
                           (id)[UIColor colorWithRed:(178.0/255.0) green:(208.0/255.0) blue:(108.0/255.0) alpha:1].CGColor,
                           nil];
    } else if ([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        gradient.colors = [NSArray arrayWithObjects:
                           (id)[UIColor colorWithRed:(249.0/255.0) green:(163.0/255.0) blue:(26.0/255.0) alpha:1].CGColor,
                           (id)[UIColor colorWithRed:(251.0/255.0) green:(180.0/255.0) blue:(76.0/255.0) alpha:1].CGColor,
                           nil];
    } else if ([self.currentCourse.courseType integerValue] == F15Advance || [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2){
        gradient.colors = [NSArray arrayWithObjects:
                           (id)[UIColor colorWithRed:(206.0/255.0) green:(54.0/255.0) blue:(47.0/255.0) alpha:1].CGColor,
                           (id)[UIColor colorWithRed:(214.0/255.0) green:(96.0/255.0) blue:(76.0/255.0) alpha:1].CGColor,
                           nil];
    }
    
    [gradient setStartPoint:CGPointMake(0.0, 0.5)];
    [gradient setEndPoint:CGPointMake(1.0, 0.5)];
    
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(0, 0, button.frame.size.width, button.frame.size.height);
    maskLayer.contents = (id)[button.currentBackgroundImage CGImage];
    gradient.mask = maskLayer;
    
    
    UIImage *img = [self imageFromLayer:gradient];
    [button setBackgroundImage:img forState:UIControlStateNormal];
    
    
    
}

// CONVERTING CALAYER GRADIENT TO UIIMAGE
- (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, NO, 0);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end
