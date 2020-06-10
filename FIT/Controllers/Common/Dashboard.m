//
//  Dashboard.m
//  FIT
//
//  Created by Hamid Mehmood on 08/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "Dashboard.h"
#import "StartProgramViewController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "ProgramDashboardViewController.h"
#import "FITWorkoutDetailsRLM.h"
#import "Locales.h"
#import "FLPIngredients.h"

@interface Dashboard ()

@property UserCourseType *courseSelected;
@property RLMResults *allScheduledPrograms;
@property RLMResults *allActivePrograms;

@end

@implementation Dashboard

#pragma mark - VIEW METHODS
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width,80.0)];
    
    swipeRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:nil];
    swipeRecognizer.delegate = self;
    [self.view addGestureRecognizer:swipeRecognizer];
    
    [self languageAndButtonUIUpdate:self.cnineBtn buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM C9Color]];
    [self languageAndButtonUIUpdate:self.vfiveBtn buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM V5Color]];
    [self languageAndButtonUIUpdate:self.fFifteenOneBtn buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15BeginnerColor]];
    [self languageAndButtonUIUpdate:self.fFifteenTwoBtn buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15IntermidiateColor]];
    [self languageAndButtonUIUpdate:self.fFifteenThreeBtn buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15AdvanceColor]];
    
    [self languageAndButtonUIUpdate:self.fFifteenDynamicBtn1 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM GreyColor]];
    [self languageAndButtonUIUpdate:self.fFifteenDynamicBtn2 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM GreyColor]];
    
    for (FITButton *grayBtn in self.grayBtn){
        [self languageAndButtonUIUpdate:grayBtn buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM GreyColor]];
        grayBtn.hidden = YES;
    }
    
    [self updateScheduledAndCompletedCoursesStatus];
    
    self.fFifteenDynamicImg1.alpha = 0;
    self.fFifteenDynamicImg2.alpha = 0;
    self.fFifteenDynamicLbl1.alpha = 0;
    self.fFifteenDynamicLbl2.alpha = 0;
    
    [self languageAndButtonUIUpdate:self.self.startBtn buttonMode:3 inSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE forKey:CONTENT_LABEL_START backgroundColor:[THM GreyColor]];
    [self logUser];
    
    
    [self.self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self loadContentUI];
    
    //Locale Download
    RLMResults *localeData = [Locales allObjects];
    if([localeData count] <1) {
        [[FITAPIManager sharedManager] getLocalesList];
    }
    
    int loaderTime = 1;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        // do some long running processing here
        
        // Check that there was not a nil handler passed.
        //        if( completionHandler )
        //        {
        //            // This assumes ARC. If no ARC, copy and autorelease the Block.
        //            [completionHandler performSelector:@selector(rmaddy_callBlockWithBOOL:)
        //                                      onThread:origThread
        //                                    withObject:@(ok)    // or [NSNumber numberWithBool:ok]
        //                                 waitUntilDone:NO];
        //        }
        //Download Ingredients
        RLMResults *ingredientsData = [FLPIngredients allObjects];
        if([ingredientsData count])
            [[FITAPIManager sharedManager] getIngredientsWithSuccess:^(NSArray<FLPIngredients *> *ingredients) {} failure:^(NSError *error) {}];
        
        //Download Exercises
        RLMResults *exercisesData = [FITWorkoutDetailsRLM allObjects];
        if([exercisesData count] < 1){
            [[FITAPIManager sharedManager] getExercise:C9Exercises success:^{} failure:^(NSError *error) {}];
            [[FITAPIManager sharedManager] getExercise:F15ExercisesBeginner1 success:^{} failure:^(NSError *error) {}];
            [[FITAPIManager sharedManager] getExercise:F15ExercisesBeginner2 success:^{} failure:^(NSError *error) {}];
            [[FITAPIManager sharedManager] getExercise:F15ExercisesIntermediate1 success:^{} failure:^(NSError *error) {}];
            [[FITAPIManager sharedManager] getExercise:F15ExercisesIntermediate2 success:^{} failure:^(NSError *error) {}];
            [[FITAPIManager sharedManager] getExercise:F15ExercisesAdvance1 success:^{} failure:^(NSError *error) {}];
            [[FITAPIManager sharedManager] getExercise:F15ExercisesAdvance2 success:^{} failure:^(NSError *error) {}];
            [[FITAPIManager sharedManager] getExercise:F15WarmUpCoolDown success:^{} failure:^(NSError *error) {}];
        }
        
        //Download Recipes
        RLMResults *recipesData = [FITRecipes allObjects];
        if([recipesData count] < 1){
            [[FITAPIManager sharedManager] getRecipesForProgram:C9 success:^(NSArray<FITRecipes *> *recipes) {} failure:^(NSError *error) {}];
            [[FITAPIManager sharedManager] getRecipesForProgram:F15Begginner1 success:^(NSArray<FITRecipes *> *recipes) {} failure:^(NSError *error) {}];
            [[FITAPIManager sharedManager] getRecipesForProgram:F15Begginner2 success:^(NSArray<FITRecipes *> *recipes) {} failure:^(NSError *error) {}];
            [[FITAPIManager sharedManager] getRecipesForProgram:F15Intermidiate1 success:^(NSArray<FITRecipes *> *recipes) {} failure:^(NSError *error) {}];
            [[FITAPIManager sharedManager] getRecipesForProgram:F15Intermidiate2 success:^(NSArray<FITRecipes *> *recipes) {} failure:^(NSError *error) {}];
            [[FITAPIManager sharedManager] getRecipesForProgram:F15Advance1 success:^(NSArray<FITRecipes *> *recipes) {} failure:^(NSError *error) {}];
            [[FITAPIManager sharedManager] getRecipesForProgram:F15Advance2 success:^(NSArray<FITRecipes *> *recipes) {} failure:^(NSError *error) {}];
        }
        
        //Download Awards
        RLMResults *freeAwardsData = [FITAwards allObjects];
        if([freeAwardsData count] < 1){
            [[FITAPIManager sharedManager] getAwardsWithSuccess:^(NSArray<FITAwards *> *awards) {
                
            } failure:^(NSError *error) {}];
        }
        //    loaderTime++;
        //Donwload free food if neccesary
        RLMResults *freeFoodData = [FITFreeFood allObjects];
        if([freeFoodData count] < 1){
            [[FITAPIManager sharedManager] getFreeFoodWithSuccess:^(NSArray<FITFreeFood *> *awards){} failure:^(NSError *error) {}];
        }
        
        
    });
}
- (void) loadContentUI {
    
    self.navigationController.navigationBar.barTintColor = [THM C9Color];
    [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS andKey:CONTENT_LABEL_SELECT_PROGRAM]];
    
    RLMResults *currentProgram = [UserCourse objectsWhere:@"status = %d",1];
    if(!self.isCreateNewProgram && [currentProgram count] > 0) {
        //goto program dashbaord
        ProgramDashboardViewController *programDashboard = (ProgramDashboardViewController *)[self.storyboard instantiateViewControllerWithIdentifier:PROGRAM_DASHBOARD];
        [self.navigationController pushViewController:programDashboard animated:YES];
    }
    
    
}
- (void) logUser {
    User *user = [User userInDB];
    [CrashlyticsKit setUserIdentifier:user.token];
    [CrashlyticsKit setUserEmail:user.email];
    [CrashlyticsKit setUserName:user.username];
}


- (void)updateScheduledAndCompletedCoursesStatus {
    self.allActivePrograms = [UserCourse objectsWhere:@"status = %d",1];
    self.allScheduledPrograms = [UserCourse objectsWhere:@"status = %d",2];
    DLog(@"ProgramID === %@ %@", self.allScheduledPrograms, self.allActivePrograms);
    for (RLMObject *program in self.allActivePrograms) {
        UserCourse *currentCourse = [[UserCourse alloc] init];
        currentCourse = program;
        if(currentCourse.courseType == C9){
            if([[Utils sharedUtils] getCurrentDayWithStartDate:program[@"startDate"]] > 9) {
                DLog(@"Found a course needs to set to completed");
            } else {
                DLog(@"All the current course should remain active");
            }
        } else {
            
            if([[Utils sharedUtils] getCurrentDayWithStartDate:program[@"startDate"]] > 15) {
                DLog(@"Found a course needs to set to completed");
            } else {
                DLog(@"All the current course should remain active");
            }
        }
    }
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadContentUI];
}

#pragma mark - CHECKING CONDITION FOR THE MAIN 5 BUTTONS
- (IBAction) buttonPressed:(FITButton *)sender {
    
    for (FITButton *b in self.buttons) {
        
        if (b.tag != sender.tag) {
            b.hidden = YES;
        } else {
            b.hidden = NO;
        }
        
        for (FITButton *grayBtn in self.grayBtn){
            if (sender.tag != grayBtn.tag) {
                grayBtn.hidden = NO;
            } else {
                grayBtn.hidden = YES;
            }
            
            
            if (sender == b || sender == grayBtn ) {
                
                b.userInteractionEnabled = NO;
                self.startBtn.userInteractionEnabled = YES;
                [self languageAndButtonUIUpdate:self.self.startBtn buttonMode:3 inSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE forKey:CONTENT_BUTTON_START_PROGRAM backgroundColor:[THM C9Color]];
                if(sender.tag == 1){
                    self.mainCourseSelected = C9;
                    self.courseSelected = C9;
                } else if (sender.tag == 2)
                    self.mainCourseSelected = V5;
                
                if(sender.tag == 3 || sender.tag == 4 || sender.tag == 5) {
                    
                    self.startBtn.userInteractionEnabled = NO;
                    [self languageAndButtonUIUpdate:self.self.startBtn buttonMode:3 inSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE forKey:CONTENT_BUTTON_START_PROGRAM backgroundColor:[THM GreyColor]];
                    self.fFifteenDynamicImg1.alpha = 1;
                    self.fFifteenDynamicImg2.alpha = 1;
                    self.fFifteenDynamicLbl1.alpha = 1;
                    self.fFifteenDynamicLbl2.alpha = 1;
                    [self.fFifteenDynamicBtn1 setUserInteractionEnabled:YES];
                    [self.fFifteenDynamicBtn2 setUserInteractionEnabled:YES];
                    
                    
                    if (sender.tag == 3) {
                        
                        self.fFifteenDynamicLbl1.text = [NSString stringWithFormat:@"%@ %@",[self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_LABEL_BEGINNER],@"1"];
                        self.fFifteenDynamicLbl2.text = [NSString stringWithFormat:@"%@ %@",[self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_LABEL_BEGINNER],@"2"];
                        self.mainCourseSelected = F15Begginner;
                        
                        [self languageAndButtonUIUpdate:self.self.self.fFifteenDynamicBtn1 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15Beginner1Color]];
                        [self languageAndButtonUIUpdate:self.self.self.self.fFifteenDynamicBtn2 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15Beginner2Color]];
                    } else if (sender.tag == 4) {
                        
                        self.fFifteenDynamicLbl1.text = [NSString stringWithFormat:@"%@ %@",[self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_LABEL_INTERMEDIATE],@"1"];
                        self.fFifteenDynamicLbl2.text = [NSString stringWithFormat:@"%@ %@",[self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_LABEL_INTERMEDIATE],@"2"];
                        self.mainCourseSelected = F15Intermidiate;
                        
                        [self languageAndButtonUIUpdate:self.self.self.fFifteenDynamicBtn1 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15Intermidiate1Color]];
                        [self languageAndButtonUIUpdate:self.self.self.self.fFifteenDynamicBtn2 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15Intermidiate2Color]];
                        
                    } else if (sender.tag == 5) {
                        
                        self.fFifteenDynamicLbl1.text = [NSString stringWithFormat:@"%@ %@",[self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_LABEL_ADVANCED],@"1"];
                        self.fFifteenDynamicLbl2.text = [NSString stringWithFormat:@"%@ %@",[self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_LABEL_ADVANCED],@"2"];
                        self.mainCourseSelected = F15Advance;
                        
                        [self languageAndButtonUIUpdate:self.self.self.fFifteenDynamicBtn1 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15Advance1Color]];
                        [self languageAndButtonUIUpdate:self.self.self.self.fFifteenDynamicBtn2 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15Advance2Color]];
                        
                    }
                    
                } else {
                    [self languageAndButtonUIUpdate:self.self.self.fFifteenDynamicBtn1 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM GreyColor]];
                    [self languageAndButtonUIUpdate:self.self.self.self.fFifteenDynamicBtn2 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM GreyColor]];
                    self.fFifteenDynamicImg1.alpha = 0;
                    self.fFifteenDynamicImg2.alpha = 0;
                    self.fFifteenDynamicLbl1.alpha = 0;
                    self.fFifteenDynamicLbl2.alpha = 0;
                    [self.fFifteenDynamicBtn1 setUserInteractionEnabled:NO];
                    [self.fFifteenDynamicBtn2 setUserInteractionEnabled:NO];
                }
                
                
                
            }
        }
    }
}


#pragma mark - ACTION FOR TWO DYNAMIC BUTTONS
- (IBAction) twoDynamicBtnPressed:(FITButton *)sender {
    if (sender.tag == 6) {
        if(self.mainCourseSelected == F15Begginner) {
            [self languageAndButtonUIUpdate:self.fFifteenDynamicBtn1 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15Beginner1Color]];
            self.courseSelected = F15Begginner1;
        }
        
        if(self.mainCourseSelected == F15Intermidiate) {
            [self languageAndButtonUIUpdate:self.fFifteenDynamicBtn1 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15Intermidiate1Color]];
            self.courseSelected = F15Intermidiate1;
        }
        
        if(self.mainCourseSelected == F15Advance) {
            [self languageAndButtonUIUpdate:self.fFifteenDynamicBtn1 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15Advance1Color]];
            self.courseSelected = F15Advance1;
        }
        
        [self languageAndButtonUIUpdate:self.fFifteenDynamicBtn2 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM GreyColor]];
        [self.fFifteenDynamicBtn2 setUserInteractionEnabled:YES];
        [self.fFifteenDynamicBtn1 setUserInteractionEnabled:NO];
        
        self.startBtn.userInteractionEnabled = YES;
        [self languageAndButtonUIUpdate:self.startBtn buttonMode:3 inSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE forKey:CONTENT_BUTTON_START_PROGRAM backgroundColor:[THM C9Color]];
    } else {
        
        [self languageAndButtonUIUpdate:self.fFifteenDynamicBtn2 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15Advance1Color]];
        
        if(self.mainCourseSelected == F15Begginner) {
            [self languageAndButtonUIUpdate:self.fFifteenDynamicBtn2 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15Beginner1Color]];
            self.courseSelected = F15Begginner2;
        }
        
        if(self.mainCourseSelected == F15Intermidiate) {
            [self languageAndButtonUIUpdate:self.fFifteenDynamicBtn2 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15Intermidiate1Color]];
            self.courseSelected = F15Intermidiate2;
        }
        
        if(self.mainCourseSelected == F15Advance) {
            [self languageAndButtonUIUpdate:self.fFifteenDynamicBtn2 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15Advance1Color]];
            self.courseSelected = F15Advance2;
        }
        
        [self languageAndButtonUIUpdate:self.fFifteenDynamicBtn1 buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM GreyColor]];
        [self.fFifteenDynamicBtn1 setUserInteractionEnabled:YES];
        [self.fFifteenDynamicBtn2 setUserInteractionEnabled:NO];
        
        
        self.startBtn.userInteractionEnabled = YES;
        [self languageAndButtonUIUpdate:self.self.startBtn buttonMode:3 inSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE forKey:CONTENT_BUTTON_START_PROGRAM backgroundColor:[THM C9Color]];
        
    }
    
}

- (IBAction)startBtnTapped:(id)sender {
    if(self.mainCourseSelected == V5){
        DLog(@"V5 selected");
        
        //        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[self localisedStringForSection:CONTENT_PLACEHOLDER_SECTION andKey:CONTENT_V5_ALERT_NO_AVAILABLE] preferredStyle:UIAlertControllerStyleAlert];
        //        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
        //        }]];
        //
        //        [self presentViewController:alertController animated:YES completion:nil];
        [[Utils sharedUtils] showAlertViewWithMessage:[self localisedStringForSection:CONTENT_PLACEHOLDER_SECTION andKey:CONTENT_V5_ALERT_NO_AVAILABLE] buttonTitle:@"OK"];
    } else {
        NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
        
        [defaults setInteger:self.courseSelected forKey:@"courseSelected"];
        [defaults synchronize];
        [self performSegueWithIdentifier:DAHSBOARD_SHOW_PROGRAM sender:nil];
    }
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:DAHSBOARD_SHOW_PROGRAM]) {
        StartProgramViewController *destinationVC = (StartProgramViewController *)segue.destinationViewController;
        destinationVC.courseSelected = self.courseSelected;
    }
}




@end
