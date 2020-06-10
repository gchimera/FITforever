//
//  FITFoodSupplementsVC.m
//  fitapp
//
//  Created by Hadi Roohian on 29/12/2016.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import "FITFoodSupplementsVC.h"
#import "Supplements.h"
#import "FITFoodOptionsVC.h"
#import "SupplementCell.h"
#import "ProgramFIT.h"

@interface FITFoodSupplementsVC ()
//@property RLMResults *checklistData;
@property int day;
@property int meal;
@property NSInteger program;
@property NSString *partOfDay;
@property RLMResults *result;
@property int currentCheckedCount;
@property RLMResults *programSupplementsResults;
@property NSString *supplementNameForUsingInRealmQuery;
@end

@implementation FITFoodSupplementsVC

@synthesize mealSelected;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if ([mealSelected isEqualToString:@"Breakfast"]) {
        self.supplementNameForUsingInRealmQuery = @"breakfastSupplements";
        self.partOfDay =  @"fitapp-supplements-breakfast";
    } else if([mealSelected isEqualToString:@"Lunch"]) {
        self.partOfDay =   @"fitapp-supplements-lunch";
        self.supplementNameForUsingInRealmQuery = @"lunchSupplements";
    } else if([mealSelected isEqualToString:@"Dinner"]) {
        self.partOfDay =   @"fitapp-supplements-dinner";
        self.supplementNameForUsingInRealmQuery = @"dinnerSupplements";
    } else if([mealSelected isEqualToString:@"Snack"]) {
        self.partOfDay =   @"fitapp-supplements-snack";
        self.supplementNameForUsingInRealmQuery = @"snackSupplements";
    } else if([mealSelected isEqualToString:@"EveningShake"]) {
        self.partOfDay =   @"fitapp-supplements-evening";
        self.supplementNameForUsingInRealmQuery = @"eveningSupplements";
    }
    
    [[self segueView] setAndDisplayNumItems:3 spacing:80];
    [[self segueView] setActiveItem:0];
    [[self segueView] setActiveItem:1];
    [self programButtonUpdate:self.nextBtn buttonMode:3 inSection:CONTENT_FIT_C9_BREAKFAST_SECTION forKey:CONTENT_BUTTON_NEXT];
    
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    self.program = [self.currentCourse.courseType integerValue];
    
//    self.partOfDay = mealSelected;
    

    
    self.currentCheckedCount = 0;
    //    [self loadCurrentCheckedCount];
    [self fetchChecklistFromRealmForDay];
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    if ([mealSelected isEqualToString:@"Breakfast"]) {
        self.navigationItem.title = @"Breakfast";
    } else if([mealSelected isEqualToString:@"Lunch"]) {
        self.navigationItem.title = @"Lunch";
    } else if([mealSelected isEqualToString:@"Dinner"]) {
        self.navigationItem.title = @"Dinner";
    } else if([mealSelected isEqualToString:@"Snack"]) {
        self.navigationItem.title = @"Snack";
    } else if([mealSelected isEqualToString:@"EveningShake"]) {
        self.navigationItem.title = @"EveningShake";
    }
    
}

//- (NSString *)convertOldPartOfDayNamingToNewVersion:(NSString *)oldName {
//    if ([oldName isEqualToString:@"Breakfast"]) {
//        return @"fitapp-supplements-breakfast";
//    } else if ([oldName isEqualToString:@"Snack"]) {
//        return @"fitapp-supplements-snack";
//    }else if ([oldName isEqualToString:@"Lunch"]) {
//        return @"fitapp-supplements-lunch";
//    }else if ([oldName isEqualToString:@"Dinner"]) {
//        return @"fitapp-supplements-dinner";
//    } else {
//        return @"fitapp-supplements-evening";
//    }
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.programSupplementsResults count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.result = [Supplements objectsWhere:[NSString stringWithFormat:@"day = '%d' && partOfDay = '%@' && programID = '%@' && supplementID = '%@'",self.day,self.partOfDay, self.currentCourse.userProgramId, [self.programSupplementsResults objectAtIndex:indexPath.row][@"idSupplement"]]];
    
    SupplementCell *supplementCell = [tableView dequeueReusableCellWithIdentifier:@"supplementCell"];
    if ([[[self.result firstObject] valueForKey:@"isChecked"] boolValue]) {
        [self programButtonImageUpdate:supplementCell.supplementHexBtn withImageName:@"hexagonon"];
    } else if ( [[[self.programSupplementsResults objectAtIndex:indexPath.row][@"components"] valueForKey:@"interval"] boolValue]) {
        [self programButtonImageUpdate:supplementCell.supplementHexBtn withImageName:@"waitthirtyminutesicon"];
    } else {
        [self programButtonImageUpdate:supplementCell.supplementHexBtn withImageName:@"hexagonoff"];
    }
    [[supplementCell supplementLabel] setText:[self.programSupplementsResults objectAtIndex:indexPath.row][@"name"]];
    [[supplementCell supplementHexBtn] addTarget:self action:@selector(updateSelectedRow:) forControlEvents:UIControlEventTouchUpInside];
    [[supplementCell supplementHexBtn] setTag:indexPath.row];
    return supplementCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SupplementCell *supplementCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row  inSection:0]];
    self.result = [Supplements objectsWhere:[NSString stringWithFormat:@"day = '%d' && partOfDay = '%@' && programID = '%@' && supplementID = '%@'",self.day,self.partOfDay, self.currentCourse.userProgramId, [self.programSupplementsResults objectAtIndex:indexPath.row][@"idSupplement"]]];
    if (!([[[self.programSupplementsResults objectAtIndex:indexPath.row][@"components"] valueForKey:@"interval"] boolValue])) {
        if ([[[self.result firstObject] valueForKey:@"isChecked"] boolValue]) {
            [self updateSupplementsTableInRealm:supplementCell.supplementHexBtn shouldCheck:NO forID:[[self.result firstObject] valueForKey:@"uid"]];
        } else {
            [self updateSupplementsTableInRealm:supplementCell.supplementHexBtn shouldCheck:YES forID:[[self.result firstObject] valueForKey:@"uid"]];
        }
    }
    
    [self.tableView reloadData];
    
}


- (void)updateSelectedRow:(UIButton *)senderButton {
    
    self.result = [Supplements objectsWhere:[NSString stringWithFormat:@"day = '%d' && partOfDay = '%@' && programID = '%@' && supplementID = '%@'",self.day,self.partOfDay, self.currentCourse.userProgramId, [self.programSupplementsResults objectAtIndex:senderButton.tag][@"idSupplement"]]];
    if (!([[[self.programSupplementsResults objectAtIndex:senderButton.tag][@"components"] valueForKey:@"interval"] boolValue])) {
        if ([[[self.result firstObject] valueForKey:@"isChecked"] boolValue]) {
            [self updateSupplementsTableInRealm:senderButton shouldCheck:NO forID:[[self.result firstObject] valueForKey:@"uid"]];
        } else {
            [self updateSupplementsTableInRealm:senderButton shouldCheck:YES forID:[[self.result firstObject] valueForKey:@"uid"]];
        }
    }
    
    [self.tableView reloadData];
}

- (void)updateSupplementsTableInRealm:(UIButton *)senderButton shouldCheck:(BOOL)isChecked forID:(NSString *)primaryID {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    if([primaryID length] == 0) {
        [Supplements createOrUpdateInRealm:realm withValue:@{@"day": [NSString stringWithFormat:@"%d",self.day], @"partOfDay" : self.partOfDay, @"supplementID": [self.programSupplementsResults objectAtIndex:senderButton.tag][@"idSupplement"], @"programID": self.currentCourse.userProgramId, @"isChecked": @(isChecked), @"isSynced" : @NO}];
    } else {
        [Supplements createOrUpdateInRealm:realm withValue:@{@"uid":primaryID, @"day": [NSString stringWithFormat:@"%d",self.day], @"partOfDay":self.partOfDay, @"supplementID": [self.programSupplementsResults objectAtIndex:senderButton.tag][@"idSupplement"], @"programID": self.currentCourse.userProgramId, @"isChecked": @(isChecked), @"isSynced" : @NO}];
    }
    [realm commitWriteTransaction];
    
    
    // check how many suppliments are saved
    //    RLMResults* supp = [Supplements allObjects];
    RLMResults* supp = [Supplements objectsWhere:[NSString stringWithFormat:@"programID = '%@'",self.currentCourse.userProgramId]];
    
    int totSup = 0;
    switch ([self.currentCourse.courseType integerValue]) {
        case C9:
            totSup = 10;
            break;
        case F15ExercisesBeginner1:
        case F15ExercisesBeginner2:
        case F15Intermidiate1:
        case F15Intermidiate2:
        case F15Advance1:
        case F15Advance2:
            totSup = 7;
            break;
            
        default:
            break;
    }
    
    if (supp.count >= totSup) {
        
        RLMResults *awardsAlreadyAchived = [FITAwardCompleted objectsWhere:[NSString stringWithFormat:@"awardCompleteId = '%@' ",[NSString stringWithFormat:@"%@_%@_%@",self.currentCourse.userProgramId,[self checkProgram:self.currentCourse.programName],[NSString stringWithFormat:@"%d",self.day]]]];
        if([awardsAlreadyAchived count] <= 0){
            [[FITAPIManager sharedManager] sendMessageWithConversationId:[NSString stringWithFormat:@"%@",self.currentCourse.conversationId] message:@"EXERCISE AWARD MESSAGE" image:@"" messageTyp:@"TEXT" date:@"" imageType:@"" awardsId:[self checkProgram:self.currentCourse.programName] notificaionId:@""  success:^(int *status) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"MESSAGE SENT");
                });
                
            } failure:^(NSError *error) {
                
            }];
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            if (notification)
            {
                
                notification.fireDate = [NSDate date];
                
                notification.timeZone = [NSTimeZone defaultTimeZone];
                notification.applicationIconBadgeNumber = 1;
                notification.soundName = UILocalNotificationDefaultSoundName;
                
                notification.alertBody = [NSString stringWithFormat:@"%@ Well Supplied %@",[self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS andKey:CONTENT_SHARE_AWARDS_TEXT_PART1],[self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS andKey:CONTENT_SHARE_AWARDS_TEXT_PART2]];
                //@"Test Text For Award";
            }
            
            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
        }
        
        
        RLMRealm *realm1 = [RLMRealm defaultRealm];
        
        [realm1 beginWriteTransaction];
        [FITAwardCompleted createOrUpdateInRealm:realm1 withValue:
         @{
           @"awardCompleteId" : [NSString stringWithFormat:@"%@_%@_%@",self.currentCourse.userProgramId,[self checkProgram:self.currentCourse.programName],[NSString stringWithFormat:@"%d",self.day]],
           @"programID" : self.currentCourse.userProgramId,
           @"dateAchieved" : [NSDate date],
           @"awardID" : [self checkProgram:self.currentCourse.programName],
           @"day": [NSString stringWithFormat:@"%d",self.day],
           }];
        [realm1 commitWriteTransaction];
        
        
        
        
    }
    
}

#pragma mark - LOOP ON REALM DB TO SHOW LABELS
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
        
        
        
        self.programSupplementsResults = [[[[[[ProgramFIT objectsWhere:[NSString stringWithFormat:@"name = 'C9'"]] valueForKey:@"days"] objectAtIndex:0] objectsWhere:[NSString stringWithFormat:@"idDays = '%@'",dayIDForUsingInRealmQuery]] valueForKey:self.supplementNameForUsingInRealmQuery] objectAtIndex:0];
        
        
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
        
        
        
        
        
        self.programSupplementsResults = [[[[[[ProgramFIT objectsWhere:[NSString stringWithFormat:@"name = 'F15'"]] valueForKey:@"days"] objectAtIndex:0] objectsWhere:[NSString stringWithFormat:@"idDays = '%@'", nameProgramForUsingInRealmQuery]] valueForKey:self.supplementNameForUsingInRealmQuery] objectAtIndex:0];
    }
    NSLog(@"All Supppps : %@",self.programSupplementsResults);

}


-(NSString*)checkProgram:(NSString*)fixProgram
{
    NSString* h;
    
    if ([fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED1] || [fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED2])
    {
        //        h = @"a1IK000000Pg4GdMAJ";
        RLMResults *awards = [FITAwards objectsWhere:@"awardKey = 'f15-advanced-well-supplied'"];
        if([awards count] > 0){
            FITAwards *award = [[FITAwards alloc] init];
            award = [awards objectAtIndex:0];
            h = award.awrdsId;// @"a1IK000000Pg4FyMAJ";
        }
        
        
    }
    else if ([fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE1] || [fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE2])
    {
        //        h = @"a1IK000000Pg4GNMAZ";
        RLMResults *awards = [FITAwards objectsWhere:@"awardKey = 'f15-intermediate-well-supplied'"];
        if([awards count] > 0){
            FITAwards *award = [[FITAwards alloc] init];
            award = [awards objectAtIndex:0];
            h = award.awrdsId;// @"a1IK000000Pg4FyMAJ";
        }
    }
    else if ([fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER1] || [fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER2])
    {
        //        h = @"a1IK000000Pg4G9MAJ";
        RLMResults *awards = [FITAwards objectsWhere:@"awardKey = 'f15-beginner-well-supplied'"];
        if([awards count] > 0){
            FITAwards *award = [[FITAwards alloc] init];
            award = [awards objectAtIndex:0];
            h = award.awrdsId;// @"a1IK000000Pg4FyMAJ";
        }
    }
    else
    {
        RLMResults *awards = [FITAwards objectsWhere:@"awardKey = 'c9-well-supplied'"];
        if([awards count] > 0){
            FITAwards *award = [[FITAwards alloc] init];
            award = [awards objectAtIndex:0];
            h = award.awrdsId;// @"a1IK000000Pg4FyMAJ";
        }
    }
    
    return h;
}

- (IBAction)nextBtnTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end

