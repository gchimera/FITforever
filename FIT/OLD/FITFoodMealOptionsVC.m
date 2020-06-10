//
//  FITFoodMealOptionsVC.m
//  fitapp
//
//  Created by Hadi Roohian on 28/12/2016.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import "FITFoodMealOptionsVC.h"
#import "FITFoodMealCell.h"
#import "Realm/Realm.h"
#import "FITFoodCreateMealVC.h"
#import "CustomRecipe.h"
#import "FITFoodDetails.h"
#import "FITRecipes.h"
#import "Meal.h"
#import "CourseMealMap.h"

@interface FITFoodMealOptionsVC ()
@property RLMResults *defaultFoods;
@property RLMResults *customAddedFoods;
@property RLMResults *selectedMealResult;
@property NSString *partOfDay;

@property int day;
@property RLMResults *result;
@property NSInteger checkedRowNumber;
@property NSString *checkedRowID;
@property NSString *uniqueRowID;
@property NSInteger program;
@property RLMObject *courseMapResult;
@property NSNumber *recipeType;
@property bool isFirstLoad;
@property bool isCustom;

@end

@implementation FITFoodMealOptionsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.partOfDay = @"";
    self.checkedRowID = @"";
    self.checkedRowNumber = -1;
    self.isFirstLoad = YES;
    
    [[self segueView] setAndDisplayNumItems:3 spacing:80];
    [[self segueView] setActiveItem:0];
    [[self segueView] setActiveItem:1];
    [[self segueView] setActiveItem:2];
    
    NSLog(@"%@",self.mealSelected);
    
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    NSLog(@"%ld",(long)self.day);
    self.uniqueRowID = @"";
//    [[self segueView] setActiveItem:2];
    
    // Do any additional setup after loading the view.
    

    [self programButtonUpdate:self.doneBtn buttonMode:3 inSection:CONTENT_FIT_F15_SHAKE_SECTION forKey:CONTENT_BUTTON_CLOSE];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    
    switch (self.courseMapNumber) {
        case 2:
            self.recipeType = @1;
            self.navigationItem.title = [self localisedStringForSection:CONTENT_FIT_F15_MEALS_SECTION andKey:CONTENT_MEALS_SCREEN_TITLE];
            if([self.currentCourse.courseType integerValue] == C9) {
                [self programButtonUpdate:self.createYourOwnMealBtn buttonMode:3 inSection:CONTENT_FIT_F15_DINNER_SECTION forKey:CONTENT_BUTTON_CREATE_YOUR_OWN_MEAL withColor:[THM C9Color]];
            } else {
                [self programButtonUpdate:self.createYourOwnMealBtn buttonMode:3 inSection:CONTENT_FIT_F15_DINNER_SECTION forKey:CONTENT_BUTTON_CREATE_YOUR_OWN_MEAL withColor:[THM BMColor]];
            }
            break;
            
        default:
            self.recipeType = @0;
            self.navigationItem.title = [self localisedStringForSection:CONTENT_FIT_F15_SHAKE_SECTION andKey:CONTENT_SHAKE_SCREEN_TITLE];
            if([self.currentCourse.courseType integerValue] == C9) {
            [self programButtonUpdate:self.createYourOwnMealBtn buttonMode:3 inSection:CONTENT_FIT_F15_SHAKE_SECTION forKey:CONTENT_BUTTON_CREATE_YOUR_OWN_SHAKE];
            } else {
                [self programButtonUpdate:self.createYourOwnMealBtn buttonMode:3 inSection:CONTENT_FIT_F15_SHAKE_SECTION forKey:CONTENT_BUTTON_CREATE_YOUR_OWN_SHAKE withColor:[THM BMColor]];
            }
            break;
    }
    
    
//    [self programButtonUpdate:self.createYourOwnMealBtn buttonMode:3 inSection:CONTENT_FIT_F15_DINNER_SECTION forKey:CONTENT_BUTTON_CREATE_YOUR_OWN_MEAL];
    

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadTableDataFromRealm];
    
    self.selectedMealResult = [Meal objectsWhere:[NSString stringWithFormat:@"day = '%d' && programID = '%@' && partOfDay = '%@'",self.day, self.currentCourse.userProgramId, self.partOfDay]];
    
    if([self.selectedMealResult count] > 0) {
        NSLog(@"already selected a meal");
        self.checkedRowID = [self.selectedMealResult firstObject][@"foodID"];
    }
    
    
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.isFirstLoad = NO;
}

#pragma MARK TABLE VIEW SECTION

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FITFoodMealCell *mealCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    
    
    
//    if(self.isFirstLoad) {
    


        if(self.checkedRowNumber == -1) {
        if(indexPath.row < [self.defaultFoods count]) {
            if([self.checkedRowID isEqualToString:self.defaultFoods[indexPath.row][@"recipeId"]]) {
                self.checkedRowNumber = indexPath.row;
            }
        } else {
            long correctIndex = indexPath.row - [self.defaultFoods count];
            if([self.checkedRowID isEqualToString:self.customAddedFoods[correctIndex][@"recipeID"]]) {
                
                self.checkedRowNumber = correctIndex;
            }
        }
        }
 
//    }

    
    if(indexPath.row < [self.defaultFoods count]) {
        mealCell.mealLbl.text = self.defaultFoods[indexPath.row][@"name"];

    } else {
        long correctIndex = indexPath.row - [self.defaultFoods count];
        mealCell.mealLbl.text = self.customAddedFoods[correctIndex][@"name"];

    }
    
//    }
    
    
    
    mealCell.rowCheckBtn.tag = indexPath.row;
    mealCell.detailBtn.tag = indexPath.row;
    mealCell.baseButton.tag = indexPath.row;
    
    if([self.currentCourse.courseType integerValue ] == C9){
    } else {
        [mealCell.buttonBackground setBackgroundColor:[THM BMColor]];
    }
    [self programViewColor:mealCell.backgroud];
   [mealCell.rowCheckBtn addTarget:self action:@selector(cellSelected:) forControlEvents:UIControlEventTouchUpInside];

    if (indexPath.row == self.checkedRowNumber) {
        [self programButtonImageUpdate:mealCell.rowCheckBtn withImageName:@"hexagonon"];

    } else {
        [self programButtonImageUpdate:mealCell.rowCheckBtn withImageName:@"hexagonoff"];
    }

    return mealCell;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.defaultFoods.count + self.customAddedFoods.count;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



- (void) cellSelected:(UIButton *)sender {
    
    NSLog(@"%ld",(long)sender.tag);
    if (sender.tag == self.checkedRowNumber) {
        self.checkedRowNumber = -1;
    } else {
    self.checkedRowNumber = (int)[sender tag];
    }
    
    [_tableView reloadData];
}

-(void)loadTableDataFromRealm {
    
    NSString *recipeNameForUsingInRealmQuery;
    
    switch (self.courseMapNumber) {
        case 2:
            if ([self.mealSelected isEqualToString:@"Breakfast"]) {
                recipeNameForUsingInRealmQuery = @"fitapp-recipe-breakfast";
                
            } else if([self.mealSelected isEqualToString:@"Snack"]) {
                recipeNameForUsingInRealmQuery = @"fitapp-recipe-snack";
                
            } else if([self.mealSelected isEqualToString:@"Lunch"]) {
                recipeNameForUsingInRealmQuery = @"fitapp-recipe-lunch";
                
            } else if([self.mealSelected isEqualToString:@"Dinner"]) {
                recipeNameForUsingInRealmQuery = @"fitapp-recipe-dinner";
                
            } else if([self.mealSelected isEqualToString:@"EveningShake"]) {
                recipeNameForUsingInRealmQuery = @"fitapp-recipe-shakes";
                
            }
            break;
        case 3:
            recipeNameForUsingInRealmQuery = @"fitapp-recipe-shakes";
            break;
        case 4:
            recipeNameForUsingInRealmQuery = @"fitapp-recipe-shakes";
            break;
            
        default:
            break;
    }
    

    
    NSString *programNameForUsingInRealmQuery = @"";
    switch ([self.currentCourse.courseType integerValue]) {
            
        case F15Begginner1:
            programNameForUsingInRealmQuery = @"programF15Beginner1";
            break;
        case F15Begginner2:
            programNameForUsingInRealmQuery = @"programF15Beginner2";
            break;
            
        case F15Intermidiate1:
            programNameForUsingInRealmQuery = @"programF15Intermediate1";
            break;
            
        case F15Intermidiate2:
            programNameForUsingInRealmQuery = @"programF15Intermediate2";
            break;
            
        case F15Advance1:
            programNameForUsingInRealmQuery = @"programF15Advanced1";
            break;
            
        case F15Advance2:
            programNameForUsingInRealmQuery = @"programF15Advanced2";
            break;
            
        default:
            break;
    }
    

    if([programNameForUsingInRealmQuery isEqualToString:@""]) {
        self.defaultFoods = [FITRecipes objectsWhere:[NSString stringWithFormat:@"type = '%@' && programF15Beginner1 = NO && programF15Beginner2 = NO && programF15Intermediate1 = NO && programF15Intermediate2 = NO && programF15Advanced1 = NO && programF15Advanced2 = NO",recipeNameForUsingInRealmQuery]];
    } else {
        self.defaultFoods = [FITRecipes objectsWhere:[NSString stringWithFormat:@"type = '%@' && %@ = YES",recipeNameForUsingInRealmQuery, programNameForUsingInRealmQuery]];
    }
//    self.customAddedFoods = [CustomRecipe objectsWhere:[NSString stringWithFormat:@"programType = %ld && recipeType = %ld",[self.currentCourse.courseType integerValue], (long)[self.recipeType integerValue]]];
    
    self.customAddedFoods = [CustomRecipe objectsWhere:[NSString stringWithFormat:@"recipeType = %ld",(long)[self.recipeType integerValue]]];

    
    if ([self.mealSelected isEqualToString:@"Breakfast"]) {
        self.partOfDay = @"fitapp-recipe-breakfast";

    } else if([self.mealSelected isEqualToString:@"Snack"]) {
        self.partOfDay = @"fitapp-recipe-snack";

    } else if([self.mealSelected isEqualToString:@"Lunch"]) {
        self.partOfDay = @"fitapp-recipe-lunch";

    } else if([self.mealSelected isEqualToString:@"Dinner"]) {
        self.partOfDay = @"fitapp-recipe-dinner";

    } else if([self.mealSelected isEqualToString:@"EveningShake"]) {
        self.partOfDay = @"fitapp-recipe-shakes";
        
    }
    
    


    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", (long)indexPath.row);
    [self performSegueWithIdentifier:@"gotoFoodDetailsVC" sender:self];
    
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(FITButton *)sender {

    if ([[segue identifier] isEqualToString:@"gotoFoodCreateMealVC"]){
        FITFoodCreateMealVC *foodCreateMealVC = (FITFoodCreateMealVC*)[segue destinationViewController];
        
        foodCreateMealVC.mealSelected = self.mealSelected;
        foodCreateMealVC.courseMapNumber = self.courseMapNumber;
    } else if ([[segue identifier] isEqualToString:@"gotoFoodDetailsVC"] || [[segue identifier] isEqualToString:@"gotoFoodDetailsBaseVC"]){
        
        
        FITFoodDetails *foodDetailsVC = (FITFoodDetails*)[segue destinationViewController];
        foodDetailsVC.mealSelected = self.mealSelected;
        foodDetailsVC.courseMapNumber = self.courseMapNumber;
        
        if(sender.tag < [self.defaultFoods count]) {
            foodDetailsVC.isCustomMeal = NO;
            foodDetailsVC.indexPassed = sender.tag;
        } else {
            foodDetailsVC.isCustomMeal = YES;
            foodDetailsVC.indexPassed = sender.tag - [self.defaultFoods count];
        }
        
    }


}

- (BOOL)fetchSelectedMealFromRealm {
    if(self.checkedRowNumber >= 0) {
        if(self.checkedRowNumber < [self.defaultFoods count]) {
            self.checkedRowID = self.defaultFoods[self.checkedRowNumber][@"recipeId"];
            self.isCustom = NO;
            
        } else {
            long correctIndex = self.checkedRowNumber - [self.defaultFoods count];
            self.checkedRowID = [NSString stringWithFormat:@"%d", self.customAddedFoods[correctIndex][@"recipeID"]];
            self.isCustom = YES;
        }
    
        self.selectedMealResult = [Meal objectsWhere:[NSString stringWithFormat:@"day = '%d' && programID = '%@' && partOfDay = '%@'",self.day, self.currentCourse.userProgramId, self.partOfDay]];
        NSLog(@"Result Object Hadi::::: %@",self.selectedMealResult);
        if([self.selectedMealResult count] > 0) {
            NSLog(@"already selected a meal");
            self.uniqueRowID = [self.selectedMealResult firstObject][@"uid"];
//            [self showAlertViewWithMessage:@"You have already done your food" andTitle:@"Error"];
            return NO;
        } else {
            NSLog(@"Never selected any meals before.");
            return NO;
        }
    } else {
//        [self showAlertViewWithMessage:@"Please select your food" andTitle:@"Error"];
        return NO;
    }
}



-(BOOL) saveSelectedMealToRealm {
    
    if([self fetchSelectedMealFromRealm]) {
        return NO;
    } else {
        // Not selected meal before, needs to save the meal into the realm
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        if ([self.uniqueRowID isEqualToString:@""]) {
            [Meal createOrUpdateInRealm:realm withValue:@{@"day": [NSString stringWithFormat:@"%d",self.day], @"programID": self.currentCourse.userProgramId, @"partOfDay" : self.partOfDay, @"foodID" : self.checkedRowID, @"isSynced" : @NO, @"isCustomRecipe": @(self.isCustom)}];
        } else {
            [Meal createOrUpdateInRealm:realm withValue:@{@"uid": self.uniqueRowID, @"day": [NSString stringWithFormat:@"%d",self.day], @"programID": self.currentCourse.userProgramId, @"partOfDay" : self.partOfDay, @"foodID" : self.checkedRowID, @"isSynced" : @NO, @"isCustomRecipe": @(self.isCustom)}];
        }
        [realm commitWriteTransaction];
        RLMResults *mealCount = [Meal objectsWhere:[NSString stringWithFormat:@"day = '%d' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
        [self checkMealAward:self.currentCourse.programName currentday:self.day withMealCompelted:[mealCount count]];
        return YES;
    }
    
}


- (void)showAlertViewWithMessage:(NSString*)message andTitle:(NSString*)title
{
    dispatch_async(dispatch_get_main_queue(), ^{
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//        }]];
//        
//        [self presentViewController:alertController animated:YES completion:nil];
        [[Utils sharedUtils] showAlertViewWithMessage:message buttonTitle:@"OK"];
    });
    
    
}


- (IBAction)doneBtnTapped:(id)sender {
    //Save the selected state for this meal
    if([self saveSelectedMealToRealm]) {
        NSLog(@"YEEEES");
        UIViewController *home = [self.storyboard instantiateViewControllerWithIdentifier:PROGRAM_DASHBOARD];
        [self.navigationController pushViewController:home animated:YES];
    } else {
        NSLog(@"NOOOOOOOOO");
        [self showAlertViewWithMessage:@"Please select one of the foods then press Done." andTitle:@"Error"];
    }
  
}



-(void)checkMealAward:(NSString*)fixProgram currentday:(int)day withMealCompelted:(int)mealNumber
{
    NSString* h;
    int idprogram;
    
    
    if ([fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED1] || [fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED2])
    {
        idprogram = 7;
        RLMResults *awards = [FITAwards objectsWhere:@"awardKey = 'f15-advanced-fully-fueled'"];
        if([awards count] > 0){
            FITAwards *award = [[FITAwards alloc] init];
            award = [awards objectAtIndex:0];
            h = award.awrdsId;// @"a1IK000000Pg4FyMAJ";
        }
    } 
    else if ([fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE1] || [fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE2])
    {
        idprogram = 7;
        RLMResults *awards = [FITAwards objectsWhere:@"awardKey = 'f15-intermediate-fully-fueled'"];
        if([awards count] > 0){
            FITAwards *award = [[FITAwards alloc] init];
            award = [awards objectAtIndex:0];
            h = award.awrdsId;// @"a1IK000000Pg4FyMAJ";
        }    }
    else if ([fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER1] || [fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER2])
    {
        idprogram = 2;
        RLMResults *awards = [FITAwards objectsWhere:@"awardKey = 'f15-beginner-fully-fueled'"];
        if([awards count] > 0){
            FITAwards *award = [[FITAwards alloc] init];
            award = [awards objectAtIndex:0];
            h = award.awrdsId;// @"a1IK000000Pg4FyMAJ";
        }    }
    else
    {
        idprogram = 0;
        RLMResults *awards = [FITAwards objectsWhere:@"awardKey = 'c9-fully-fueled'"];
        if([awards count] > 0){
            FITAwards *award = [[FITAwards alloc] init];
            award = [awards objectAtIndex:0];
            h = award.awrdsId;// @"a1IK000000Pg4FyMAJ";
        }
    }
//    
//    
//    RLMResults *m = [CourseMealMap objectsWhere:[NSString stringWithFormat:@"program = %d AND day = %d",idprogram,day]];
//    
//    int tot1 = [[[m valueForKey:@"breakfast"]firstObject] intValue] ;
//    if (tot1 == 2 || tot1 == 3 || tot1 == 4) {
//        tot1 = 1;
//    }else{
//        tot1 = 0;
//    }
//    int tot2 = [[[m valueForKey:@"morningSnack"]firstObject ]intValue] ;
//    if (tot2 == 2 || tot2 == 3 || tot2 == 4) {
//        tot2 = 1;
//    }else{
//        tot2 = 0;
//    }
//    int tot3 = [[[m valueForKey:@"lunch"]firstObject ]intValue] ;
//    if (tot3 == 2 || tot3 == 3 || tot3 == 4) {
//        tot3 = 1;
//    }else{
//        tot3 = 0;
//    }
//    int tot4 = [[[m valueForKey:@"dinner"]firstObject ]intValue] ;
//    if (tot4 == 2 || tot4 == 3 || tot4 == 4) {
//        tot4 = 1;
//    }else{
//        tot4 = 0;
//    }
//    int tot5 = [[[m valueForKey:@"eveningShake"]firstObject ]intValue] ;
//    if (tot5 == 2 || tot5 == 3 || tot5 == 4) {
//        tot5 = 1;
//    }else{
//        tot5 = 0;
//    }
//
//    int y =tot1+tot2+tot3+tot4+tot5;
    
    //C9
    switch (idprogram) {
        case 0://C9
            if((self.day > 2 && mealNumber == 3) || (self.day <=2 && mealNumber == 1)){
                    [self saveAward:h];
            }
            break;
        case 2://Beginner 1
        case 3:// Beginenr 2
        case 7: // Others
            if(mealNumber > 3){
                [self saveAward:h];
            }
            break;
            
        default:
            break;
    }
    
}


-(void)saveAward:(NSString*)awardID {
    
    RLMResults *awardsAlreadyAchived = [FITAwardCompleted objectsWhere:[NSString stringWithFormat:@"awardCompleteId = '%@' ",[NSString stringWithFormat:@"%@_%@_%@",self.currentCourse.userProgramId,awardID,[NSString stringWithFormat:@"%d",self.day]]]];
    if([awardsAlreadyAchived count] <= 0){
        [[FITAPIManager sharedManager] sendMessageWithConversationId:[NSString stringWithFormat:@"%@",self.currentCourse.conversationId] message:@"EXERCISE AWARD MESSAGE" image:@"" messageTyp:@"TEXT" date:@"" imageType:@"" awardsId:awardID notificaionId:@""  success:^(int *status) {
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"MESSAGE SENT");
            });
            
        } failure:^(NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"FAILED %@", error);
            });
        }];
        
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        if (notification)
        {
            
            notification.fireDate = [NSDate date];
            
            notification.timeZone = [NSTimeZone defaultTimeZone];
            notification.applicationIconBadgeNumber = 1;
            notification.soundName = UILocalNotificationDefaultSoundName;
            
            notification.alertBody = [NSString stringWithFormat:@"%@ Fully Fueled %@",[self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS andKey:CONTENT_SHARE_AWARDS_TEXT_PART1],[self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS andKey:CONTENT_SHARE_AWARDS_TEXT_PART2]];
        }
        
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
    
    RLMRealm *realm1 = [RLMRealm defaultRealm];
    
    [realm1 beginWriteTransaction];
    [FITAwardCompleted createOrUpdateInRealm:realm1 withValue:
     @{
       @"awardCompleteId" : [NSString stringWithFormat:@"%@_%@_%@",self.currentCourse.userProgramId,awardID,[NSString stringWithFormat:@"%d",self.day]],
       @"programID" : self.currentCourse.userProgramId,
       @"dateAchieved" : [NSDate date],
       @"awardID" : awardID,
       @"day": [NSString stringWithFormat:@"%d",self.day],
       }];
    
    
    [CourseDay createOrUpdateInRealm:realm1     withValue:@{
                                                       @"dayId":[NSString stringWithFormat:@"%@_%@",self.currentCourse.userProgramId,[NSString stringWithFormat:@"%d",self.day]],
                                                       @"programID":[NSString stringWithFormat:@"%@",self.currentCourse.userProgramId],
                                                       @"day" : [NSString stringWithFormat:@"%d",self.day],
                                                       @"date": [NSDate date]
                                                       }];
    [realm1 commitWriteTransaction];

}

@end
