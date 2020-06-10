//
//  C9ExercisesViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "C9ExercisesViewController.h"
#import "RLMResults.h"
#import "Exercise.h"


@interface C9ExercisesViewController ()

@end

@implementation C9ExercisesViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    DLog(@"%ld",(long)self.day);
    
#pragma mark TODO check here
    NSString *howToLabel =[self localisedStringForSection:CONTENT_FIT_C9_EXERCISE_SECTION andKey:CONTENT_WORKOUT_EXERCISE_INSTRUCTIONS];
    if(![howToLabel isEqualToString:@""]){
        [self.exercisesHowToLabel setText:howToLabel];
    }
    // Do any additional setup after loading the view.
    [self programButtonUpdate:self.twoMinutesStretchBtn buttonMode:1 inSection:CONTENT_FIT_C9_EXERCISE_SECTION forKey:CONTENT_WORKOUT_2_MINUTES_STRETCH];
    [self programButtonUpdate:self.fiveMinutesWarmupBtn buttonMode:1 inSection:CONTENT_FIT_C9_EXERCISE_SECTION forKey:CONTENT_WORKOUT_5_MINUTES_WARM_UP];
    [self programButtonUpdate:self.thirtyMinutesExerciseBtn buttonMode:1 inSection:CONTENT_FIT_C9_EXERCISE_SECTION forKey:CONTENT_WORKOUT_30_MINUTE_EXERCISE];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadCurrentFinishedExercises];
}

- (void)loadCurrentFinishedExercises {
    self.result = [Exercise objectsWhere:[NSString stringWithFormat:@"day = '%d' && exerciseName = 'twoMinutes' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
    if([self.result count]) {
        self.isTwoMinutesDone = YES;
    }
    
    self.result = [Exercise objectsWhere:[NSString stringWithFormat:@"day = '%d' && exerciseName = 'fiveMinutes' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
    if([self.result count]) {
        self.isFiveMinutesDone = YES;
    }
    
    self.result = [Exercise objectsWhere:[NSString stringWithFormat:@"day = '%d' && exerciseName = 'thirtyMinutes' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
    if([self.result count]) {
        self.isThirtyMinutesDone = YES;
    }
    
    
    if(_isTwoMinutesDone) {
        
        [self.twoMinutesStretchBtn setUserInteractionEnabled:NO];
        [self.twoMinutesStretchBtn setBackgroundColor:[UIColor colorWithRed:(192.0/255.0) green:(107.0/255.0) blue:(167.0/255.0) alpha:1]];
        self.twoMinutesStretchBtn.titleLabel.alpha = 0.2;
        [self programButtonUpdate:self.twoMinutesStretchBtn buttonMode:1 inSection:@"" forKey:@""];
        [UIView animateWithDuration:1 animations:^{
            
            self.tick1ImageView.alpha = 1;
        }];
        
    }
    
    if(_isFiveMinutesDone) {
        
        [self.fiveMinutesWarmupBtn setUserInteractionEnabled:NO];
        [self.fiveMinutesWarmupBtn setBackgroundColor:[UIColor colorWithRed:(192.0/255.0) green:(107.0/255.0) blue:(167.0/255.0) alpha:1]];
        self.fiveMinutesWarmupBtn.titleLabel.alpha = 0.2;
        [self programButtonUpdate:self.fiveMinutesWarmupBtn buttonMode:1 inSection:@"" forKey:@""];
        [UIView animateWithDuration:1 animations:^{
            
            self.tick2ImageView.alpha = 1;
        }];
        
    }
    
    if(_isThirtyMinutesDone) {
        
        [self.thirtyMinutesExerciseBtn setUserInteractionEnabled:YES];
        [self.thirtyMinutesExerciseBtn setBackgroundColor:[UIColor colorWithRed:(192.0/255.0) green:(107.0/255.0) blue:(167.0/255.0) alpha:1]];
        self.thirtyMinutesExerciseBtn.titleLabel.alpha = 0.2;
        [self programButtonUpdate:self.thirtyMinutesExerciseBtn buttonMode:1 inSection:@"" forKey:@""];
        [UIView animateWithDuration:1 animations:^{
            
            self.tick3ImageView.alpha = 1;
        }];
        
    }
    
    if (_isThirtyMinutesDone && _isFiveMinutesDone && _isTwoMinutesDone){
        DLog(@"👍 Exercises Achived");
        
        
            
        
        RLMResults *awardsAlreadyAchived = [FITAwardCompleted objectsWhere:[NSString stringWithFormat:@"awardCompleteId = '%@' ",[NSString stringWithFormat:@"%@_%@_%@",self.currentCourse.userProgramId,[self checkProgram:self.currentCourse.programName],[NSString stringWithFormat:@"%d",self.day]]]];
        if([awardsAlreadyAchived count] <= 0){
            [[FITAPIManager sharedManager] sendMessageWithConversationId:[NSString stringWithFormat:@"%@",self.currentCourse.conversationId] message:@"EXERCISE AWARD MESSAGE" image:@"" messageTyp:@"TEXT" date:@"" imageType:@"" awardsId:[self checkProgram:self.currentCourse.programName] notificaionId:@""  success:^(int *status) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"MESSAGE SENT");
                });
                
            } failure:^(NSError *error) {
                
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
            
                        notification.alertBody = [NSString stringWithFormat:@"%@ Fitness Fanatic %@",[self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS andKey:CONTENT_SHARE_AWARDS_TEXT_PART1],[self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS andKey:CONTENT_SHARE_AWARDS_TEXT_PART2]];
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
        
        NSLog(@"%@",self.currentCourse.conversationId);
        
        
        
        
    }
}


- (IBAction)twoMinutesBtnTapped:(id)sender {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    [Exercise createOrUpdateInRealm:realm withValue:@{@"day": [NSString stringWithFormat:@"%d",self.day], @"exerciseName": @"twoMinutes", @"programID": self.currentCourse.userProgramId, @"exerciseType" : @1, @"isSynced" : @NO}];
    
    [CourseDay createOrUpdateInRealm:realm     withValue:@{
                                                           @"dayId":[NSString stringWithFormat:@"%@_%@",self.currentCourse.userProgramId,[NSString stringWithFormat:@"%d",self.day]],
                                                           @"programID":[NSString stringWithFormat:@"%@",self.currentCourse.userProgramId],
                                                           @"day" : [NSString stringWithFormat:@"%d",self.day],
                                                           @"date": [NSDate date]
                                                           }];
    
    [realm commitWriteTransaction];
    [self.twoMinutesStretchBtn setUserInteractionEnabled:NO];
    [self.twoMinutesStretchBtn setBackgroundColor:[UIColor colorWithRed:(192.0/255.0) green:(107.0/255.0) blue:(167.0/255.0) alpha:1]];
    self.twoMinutesStretchBtn.titleLabel.alpha = 0.2;
    [self programButtonUpdate:self.twoMinutesStretchBtn buttonMode:1 inSection:@"" forKey:@""];
    [UIView animateWithDuration:1 animations:^{
        
        self.tick1ImageView.alpha = 1;
    }];
    
    
}

- (IBAction)fiveMinutesBtnTapped:(id)sender {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    //    self.result = [Exercise objectsWhere:[NSString stringWithFormat:@"day = '%d' && partOfDay = '%@' && programID = '%@'",self.day,self.partOfDay, _programID]];
    //        int newCount = self.currentCheckedCount + 1;
    [Exercise createOrUpdateInRealm:realm withValue:@{@"day": [NSString stringWithFormat:@"%d",self.day], @"exerciseName": @"fiveMinutes", @"programID": self.currentCourse.userProgramId, @"exerciseType" : @3, @"isSynced" : @NO}];
    
    [CourseDay createOrUpdateInRealm:realm     withValue:@{
                                                           @"dayId":[NSString stringWithFormat:@"%@_%@",self.currentCourse.userProgramId,[NSString stringWithFormat:@"%d",self.day]],
                                                           @"programID":[NSString stringWithFormat:@"%@",self.currentCourse.userProgramId],
                                                           @"day" : [NSString stringWithFormat:@"%d",self.day],
                                                           @"date": [NSDate date]
                                                           }];
    
    [realm commitWriteTransaction];
    
    [self.fiveMinutesWarmupBtn setUserInteractionEnabled:NO];
    [self.fiveMinutesWarmupBtn setBackgroundColor:[UIColor colorWithRed:(192.0/255.0) green:(107.0/255.0) blue:(167.0/255.0) alpha:1]];
    self.fiveMinutesWarmupBtn.titleLabel.alpha = 0.2;
    [self programButtonUpdate:self.fiveMinutesWarmupBtn buttonMode:1 inSection:@"" forKey:@""];
    //
    [UIView animateWithDuration:1 animations:^{
        
        self.tick2ImageView.alpha = 1;
    }];
    
    
    
}

- (IBAction)thirtyMinutesBtnTapped:(id)sender {
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"C9ExercisesDetailViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(NSString*)checkProgram:(NSString*)fixProgram
{
    NSString* h;
    
    if ([fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED1] || [fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED2])
    {
        //        h = @"a1IK000000Pg4GdMAJ";
        RLMResults *awards = [FITAwards objectsWhere:@"awardKey = 'f15-advanced-perfect-performance'"];
        if([awards count] > 0){
            FITAwards *award = [[FITAwards alloc] init];
            award = [awards objectAtIndex:0];
            h = award.awrdsId;// @"a1IK000000Pg4FyMAJ";
        }
        
        
    }
    else if ([fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE1] || [fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE2])
    {
        //        h = @"a1IK000000Pg4GNMAZ";
        RLMResults *awards = [FITAwards objectsWhere:@"awardKey = 'f15-intermediate-perfect-performance'"];
        if([awards count] > 0){
            FITAwards *award = [[FITAwards alloc] init];
            award = [awards objectAtIndex:0];
            h = award.awrdsId;// @"a1IK000000Pg4FyMAJ";
        }
    }
    else if
        
        ([fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER1] || [fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER2])
    {
        //        h = @"a1IK000000Pg4G9MAJ";
        RLMResults *awards = [FITAwards objectsWhere:@"awardKey = 'f15-beginner-perfect-performance'"];
        if([awards count] > 0){
            FITAwards *award = [[FITAwards alloc] init];
            award = [awards objectAtIndex:0];
            h = award.awrdsId;// @"a1IK000000Pg4FyMAJ";
        }
    }
    else
    {
        RLMResults *awards = [FITAwards objectsWhere:@"awardKey = 'c9-perfect-performance'"];
        if([awards count] > 0){
            FITAwards *award = [[FITAwards alloc] init];
            award = [awards objectAtIndex:0];
            h = award.awrdsId;// @"a1IK000000Pg4FyMAJ";
        }
    }
    
    return h;
}


@end
