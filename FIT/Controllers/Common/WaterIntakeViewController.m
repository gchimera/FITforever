//
//  WaterIntakeViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "WaterIntakeViewController.h"
#import "mkunits.h"
#import "AppSettings.h"
#import "Water.h"
#import "FITAwardCompleted.h"

@interface WaterIntakeViewController ()

@property int fill;
@property int day;
@property float remainingWater;
@property float intakeWater;
@property int approxGlassCount;
@property RLMResults *result;
@property CGFloat screenWidth;
@property int newWaterRateCount;
@property bool isMetricLocale;
@property NSString* unitLabel;
@property float unitVolumeAdd;
@property NSString* formatLabel;

@end

@implementation WaterIntakeViewController

@synthesize description;
@synthesize informationIncreasing;
@synthesize informationHowTo;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_FIT_C9_WATER_INTAKE_SECTION andKey:CONTENT_WATER_INTAKE_SCREEN_TITLE]];
    
    [self programButtonUpdate:self.saveBtn buttonMode:3 inSection:CONTENT_FIT_C9_WATER_INTAKE_SECTION forKey:CONTENT_BUTTON_DONE];
    [self programLabelColor:self.informationHowTo inSection:CONTENT_FIT_C9_WATER_INTAKE_SECTION forKey:CONTENT_QUANTITY];
    [self programLabelColor:self.informationIncreasing inSection:CONTENT_FIT_C9_WATER_INTAKE_SECTION forKey:CONTENT_DESCRIPTION];
    
    [self programLabelColor:self.titlePage inSection:CONTENT_FIT_C9_WATER_INTAKE_SECTION forKey:CONTENT_LABEL_WATER_INTAKE];
    [self programLabelColor:self.description inSection:CONTENT_FIT_C9_WATER_INTAKE_SECTION forKey:CONTENT_INSTRUCTIONS];
    self.description.text = [self localisedHTMLForSection:CONTENT_FIT_C9_WATER_INTAKE_SECTION andKey:CONTENT_INSTRUCTIONS];
    self.approxLbl.text =[self localisedStringForSection:CONTENT_FIT_C9_WATER_INTAKE_SECTION andKey:CONTENT_QUANTITY];
    
    [self programLabelColor:self.remainingWaterLbl inSection:@"" forKey:@""];
    
    [self programButtonImageUpdate:self.arrowBtn withImageName:@"arrowup"];
    [self programButtonImageUpdate:self.arrowDown withImageName:@"arrowdown"];
    
    
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    
    NSLog(@"%ld",(long)self.day);
    [self dataFetchFromRealm];
    _isMetricLocale = [[[AppSettings getAppSettings] volumeType] integerValue] == LITRE;
    
    [self programImageUpdate:[self glassImageView] withImageName:@"glass"];
    [self programLabelColor:[self titlePage]];
    [self programLabelColor:[self description]];
    
    _approxGlassCount = _fill;
    _remainingWater = 64-_fill*8;
    MKQuantity * standardVolumeAddOz = [@8 volume_fluidounce];
    
    
    MKQuantity * waterRemainingOz = [@(_remainingWater) volume_fluidounce];
    
    
    MKQuantity * intakeWaterMax = [@64 volume_fluidounce];
    if (!self.isMetricLocale)
    {
        
        self.formatLabel = @"%.0f";
        self.unitLabel = [MKVolumeUnit fluidounce].symbol;
        self.remainingWater =[[[waterRemainingOz convertTo:[MKVolumeUnit fluidounce]] amountWithPrecision:0] floatValue];
        self.unitVolumeAdd = [[[standardVolumeAddOz convertTo:[MKVolumeUnit fluidounce]] amountWithPrecision:0] floatValue];
        self.intakeWater = [[[intakeWaterMax convertTo:[MKVolumeUnit fluidounce]] amountWithPrecision:0] floatValue];
    }
    else
    {
        self.formatLabel = @"%.1f";
        self.unitLabel = [MKVolumeUnit centilitre].symbol;
        self.remainingWater = [[[waterRemainingOz convertTo:[MKVolumeUnit centilitre]] amountWithPrecision:2] floatValue];
        
        self.unitVolumeAdd  = [[[standardVolumeAddOz convertTo:[MKVolumeUnit centilitre]] amountWithPrecision:2] floatValue];
        
        self.intakeWater  = [[[intakeWaterMax convertTo:[MKVolumeUnit centilitre]] amountWithPrecision:2] floatValue];
    }
    
    [self.view layoutIfNeeded];
    [self dataFetchFromRealm];
    
    self.screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    for (UIView *view in self.waterPart) {
        for (int i = 1; i <= self.fill; i++) {
            if(view.tag == i) {
                view.alpha = 1;
                
                //self.remainingWater += _unitVolumeAdd;
                
                float intakeWaterRemaining = self.intakeWater -self.remainingWater;
                if (intakeWaterRemaining <= 0) intakeWaterRemaining = 0;
                
                self.remainingWaterLbl.text = [[NSString stringWithFormat:self.formatLabel,intakeWaterRemaining] stringByAppendingString:_unitLabel];
                
                //self.approxGlassCount -= 1;
                [self.view layoutIfNeeded];
                if (self.screenWidth <= 320) {
                    self.approxBottomConstraint.constant -= 21;
                } else {
                    self.approxBottomConstraint.constant -= 25;
                }
                
                [UIView animateWithDuration:0.7 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
            if(self.fill >= 1) {
                self.informationIncreasing.alpha = 0;
                self.informationHowTo.alpha = 0;
                self.remainingWaterLbl.alpha = 1;
                self.approxLbl.alpha = 1;
            }
            
            if(self.fill == 8) {
                self.glassTickCompleteImage.alpha = 1;
                self.remainingWaterLbl.alpha = 0;
                self.approxLbl.alpha = 0;
            }
        }
    }
    
    
    if (self.fill == 8) {
        self.arrowBtn.enabled = NO;
        self.increaseArrowInGlass.enabled = NO;
    }
    
    if (self.fill == 0) {
        self.arrowDown.enabled = NO;
    }

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark SAVE BUTTON TAPPED
- (IBAction)saveBtnTapped:(id)sender {
    [self saveWaterRateInRealmDatabase];
    UIViewController *home = [self.storyboard instantiateViewControllerWithIdentifier:PROGRAM_DASHBOARD];
    [self.navigationController pushViewController:home animated:YES];
}

- (void)dataFetchFromRealm {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    self.result = [Water objectsWhere:[NSString stringWithFormat:@"day = '%d' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
    
    if(self.result.firstObject == NULL)
    {
        
        [Water createOrUpdateInRealm:realm withValue:@{
                                                       @"day": [NSString stringWithFormat:@"%d",self.day],
                                                       @"count": @0,
                                                       @"programID" : self.currentCourse.userProgramId,
                                                       @"isAchived" : @NO,
                                                       @"isSynced" :@NO,
                                                       }];
        
        [CourseDay createOrUpdateInRealm:realm withValue:@{
                                                           @"dayId":[NSString stringWithFormat:@"%@_%@",self.currentCourse.userProgramId,[NSString stringWithFormat:@"%d",self.day]],
                                                           @"programID":[NSString stringWithFormat:@"%@",self.currentCourse.userProgramId],
                                                           @"day" : [NSString stringWithFormat:@"%d",self.day],
                                                           @"date": [NSDate date]
                                                           }];
        self.newWaterRateCount = 0;
        self.fill = 0;
        
    } else {
        
        self.newWaterRateCount = [self.result[0][@"count"] intValue];
        self.fill = [self.result[0][@"count"] intValue];
        
    }
    [realm commitWriteTransaction];
}

#pragma mark Save Water Rate In Realm Database
-(void) saveWaterRateInRealmDatabase {

    // if _newWaterRateCount is = 8 then QUENCHED is achived
    if (_newWaterRateCount == 8) {
        
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
                
                notification.alertBody = [NSString stringWithFormat:@"%@ Quenched %@",[self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS andKey:CONTENT_SHARE_AWARDS_TEXT_PART1],[self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS andKey:CONTENT_SHARE_AWARDS_TEXT_PART2]];
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
           @"day" : [NSString stringWithFormat:@"%d",self.day],

           }];
        [realm1 commitWriteTransaction];
        
        

        
    
    }
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [Water createOrUpdateInRealm:realm withValue:@{
                                                   @"uid": self.result[0][@"uid"],
                                                   @"day": [NSString stringWithFormat:@"%d",self.day],
                                                   @"count": @(_newWaterRateCount),
                                                   @"programID" : self.currentCourse.userProgramId,
                                                   @"dateAchieved" : [NSDate date],
                                                   }];
    [realm commitWriteTransaction];
    
    
    


    
    
}

#pragma mark REDUCE WATER RATE
- (IBAction)reduceWaterUpdate:(id)sender {
    
    
    self.newWaterRateCount = self.fill - 1;
    self.fill -= 1;
    
    [UIView animateWithDuration:1.2 animations:^{
        [self.waterPart[self.fill] setAlpha:0];
        self.remainingWater += self.unitVolumeAdd;
        
        float intakeWaterRemaining = self.intakeWater -self.remainingWater;
        if (intakeWaterRemaining <= 0) intakeWaterRemaining = 0;
        
        self.remainingWaterLbl.text = [[NSString stringWithFormat:self.formatLabel,intakeWaterRemaining] stringByAppendingString:_unitLabel];
        self.approxGlassCount -= 1;
        [self.view layoutIfNeeded];
        if (self.screenWidth <= 320) {
            self.approxBottomConstraint.constant += 13;
        } else {
            self.approxBottomConstraint.constant += 15;
        }
        
        if(self.fill == 0) {
            self.informationIncreasing.alpha = 1;
            self.informationHowTo.alpha = 1;
            self.remainingWaterLbl.alpha = 0;
            self.approxLbl.alpha = 0;
        }
        if(self.fill == 7) {
            self.glassTickCompleteImage.alpha = 0;
            self.remainingWaterLbl.alpha = 1;
            self.approxLbl.alpha = 1;
        }
        
        
        [UIView animateWithDuration:0.7 animations:^{
            [self.view layoutIfNeeded];
        }];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
        }];
    }];
    
    if (self.fill == 0) {
        self.arrowDown.enabled = NO;
        [informationHowTo setText:[self localisedStringForSection:CONTENT_FIT_C9_WATER_INTAKE_SECTION andKey:CONTENT_INSTRUCTIONS]];
        [informationHowTo setText:[self localisedStringForSection:CONTENT_FIT_C9_WATER_INTAKE_SECTION andKey:CONTENT_QUANTITY]];
        
    }
    if (self.fill == 7) {
        self.arrowBtn.enabled = YES;
        self.increaseArrowInGlass.enabled = YES;
    }
    
}

- (IBAction)updateWater:(UIButton *)sender {
    
    self.newWaterRateCount = self.fill + 1;
    self.fill += 1;
    
    
    NSLog(@"Result Object Hadi::::: %@",self.result);
    
    for (UIView *view in self.waterPart) {
        for (int i = 1; i <= self.fill; i++) {
            [UIView animateWithDuration:1.2 animations:^{
                if(view.tag == i && view.alpha == 0) {
                    view.alpha = 1;
                    self.remainingWater -= self.unitVolumeAdd;
                    
                    float intakeWaterRemaining = self.intakeWater - self.remainingWater;
                    if (intakeWaterRemaining <= 0) intakeWaterRemaining = 0;
                    self.remainingWaterLbl.text = [[NSString stringWithFormat:self.formatLabel,intakeWaterRemaining] stringByAppendingString:_unitLabel];
                    self.approxGlassCount += 1;
                    [self.view layoutIfNeeded];
                    if (self.screenWidth <= 320) {
                        self.approxBottomConstraint.constant -= 13;
                    } else {
                        self.approxBottomConstraint.constant -= 15;
                    }
                    [UIView animateWithDuration:0.7 animations:^{
                        [self.view layoutIfNeeded];
                    }];
                    
                }
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 animations:^{
                    if(self.fill == 1) {
                        self.informationIncreasing.alpha = 0;
                        self.informationHowTo.alpha = 0;
                        self.remainingWaterLbl.alpha = 1;
                        self.approxLbl.alpha = 1;
                        //                        self.arrowDown.enabled = YES;
                    }
                    if(self.fill == 8) {
                        self.glassTickCompleteImage.alpha = 1;
                        self.remainingWaterLbl.alpha = 0;
                        self.approxLbl.alpha = 0;
                        //                        self.arrowBtn.enabled = NO;
                    }
                }];
            }];
        }
    }
    if (self.fill == 8) {
        self.arrowBtn.enabled = NO;
        self.increaseArrowInGlass.enabled = NO;
    }
    if (self.fill == 1) {
        self.arrowDown.enabled = YES;
    }
}



-(NSString*)checkProgram:(NSString*)fixProgram
{
    
    NSString* h;
    
    if ([fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED1] || [fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED2])
    {
        RLMResults *awards = [FITAwards objectsWhere:@"awardKey = 'f15-advanced-quenched'"];
        if([awards count] > 0){
            FITAwards *award = [[FITAwards alloc] init];
            award = [awards objectAtIndex:0];
            h = award.awrdsId;// @"a1IK000000Pg4FyMAJ";
        }
        
        
    }
    else if ([fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE1] || [fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE2])
    {
        RLMResults *awards = [FITAwards objectsWhere:@"awardKey = 'f15-intermediate-quenched'"];
        if([awards count] > 0){
            FITAwards *award = [[FITAwards alloc] init];
            award = [awards objectAtIndex:0];
            h = award.awrdsId;// @"a1IK000000Pg4FyMAJ";
        }
    }
    else if ([fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER1] || [fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER2])
    {
        RLMResults *awards = [FITAwards objectsWhere:@"awardKey = 'f15-beginner-quenched'"];
        if([awards count] > 0){
            FITAwards *award = [[FITAwards alloc] init];
            award = [awards objectAtIndex:0];
            h = award.awrdsId;// @"a1IK000000Pg4FyMAJ";
        }
    }
    else
    {
        RLMResults *awards = [FITAwards objectsWhere:@"awardKey = 'c9-quenched'"];
        if([awards count] > 0){
            FITAwards *award = [[FITAwards alloc] init];
            award = [awards objectAtIndex:0];
            h = award.awrdsId;// @"a1IK000000Pg4FyMAJ";
        }
    }
    
    return h;
}


@end
