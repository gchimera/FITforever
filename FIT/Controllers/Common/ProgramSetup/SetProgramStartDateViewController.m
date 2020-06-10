//
//  SetProgramStartDateViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 19/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "SetProgramStartDateViewController.h"
#import "ProgramDashboardViewController.h"

@interface SetProgramStartDateViewController ()

@property UIAlertController *alertController;

@end

@implementation SetProgramStartDateViewController

@synthesize pp;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    [self programButtonUpdate:self.doneBtn buttonMode:3 inSection:CONTENT_SECTION_WATER_C9 forKey:CONTENT_WATER_DONE_C9];
    
    _yearSel = @"2017";
    _monthSel = 01;
    _daySel = 01;
    
    _day.dataSource = self;
    _day.delegate = self;
    _month.dataSource = self;
    _month.delegate = self;
    _year.dataSource = self;
    _year.delegate = self;
    
    _day.selectionAlignment = LAPickerSelectionAlignmentCenter;
    _month.selectionAlignment = LAPickerSelectionAlignmentCenter;
    _year.selectionAlignment = LAPickerSelectionAlignmentCenter;
    
    _day.tag = 1;
    _month.tag = 2;
    _year.tag = 3;
    
    [self loadContentUI];
}

- (void) loadContentUI {
    
    
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    
    int courseType = [defaults integerForKey:@"courseSelected"];
    
    NSString *programImageName = @"programName";
    NSString *topShapeImageName = @"topshapes";
    NSString *bottomShapeImageName = @"smallBaseshapes";
    
    if(courseType == C9){
        //navigation color change
        [self.navigationController.navigationBar setBarTintColor:[THM C9Color]];
        [self.day setBackgroundColor:[THM C9Color]];
        [self.year setBackgroundColor:[THM C9Color]];
        [self.month setBackgroundColor:[THM C9Color]];
        //image program change
        topShapeImageName = [NSString stringWithFormat:@"%@C9",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@C9",bottomShapeImageName];
        
        self.navigationItem.title = [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_C9_PROGRAM_NAME];
        [self languageAndButtonUIUpdate:self.doneBtn buttonMode:3 inSection:CONTENT_FIT_C9_WATER_INTAKE_SECTION forKey:CONTENT_BUTTON_DONE backgroundColor:[THM C9Color]];
    } else if(courseType == F15Begginner || courseType == F15Begginner1 || courseType == F15Begginner2){
        //navigation color change
        [self.navigationController.navigationBar setBarTintColor:[THM F15BeginnerColor]];
        [self.day setBackgroundColor:[THM BMColor]];
        [self.year setBackgroundColor:[THM BMColor]];
        [self.month setBackgroundColor:[THM BMColor]];
        //image program change
        topShapeImageName = [NSString stringWithFormat:@"%@F15B",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@F15B",bottomShapeImageName];
        
        self.navigationItem.title = [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_F15_PROGRAM_NAME];
        [self languageAndButtonUIUpdate:self.doneBtn buttonMode:3 inSection:CONTENT_FIT_C9_WATER_INTAKE_SECTION forKey:CONTENT_BUTTON_DONE backgroundColor:[THM F15BeginnerColor]];
        
    } else if(courseType == F15Intermidiate || courseType == F15Intermidiate1 || courseType == F15Intermidiate2){
        [self.navigationController.navigationBar setBarTintColor:[THM F15IntermidiateColor]];
        [self.day setBackgroundColor:[THM BMColor]];
        [self.year setBackgroundColor:[THM BMColor]];
        [self.month setBackgroundColor:[THM BMColor]];
        //navigation color change
        topShapeImageName = [NSString stringWithFormat:@"%@F15I",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@F15I",bottomShapeImageName];
        
        //image program change
        self.navigationItem.title = [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_F15_PROGRAM_NAME];
        [self languageAndButtonUIUpdate:self.doneBtn buttonMode:3 inSection:CONTENT_FIT_C9_WATER_INTAKE_SECTION forKey:CONTENT_BUTTON_DONE backgroundColor:[THM F15IntermidiateColor]];
        
    } else if(courseType == F15Advance || courseType == F15Advance1 || courseType == F15Advance2) {
        [self.navigationController.navigationBar setBarTintColor:[THM F15AdvanceColor]];
        [self.day setBackgroundColor:[THM BMColor]];
        [self.year setBackgroundColor:[THM BMColor]];
        [self.month setBackgroundColor:[THM BMColor]];
        //navigation color change
        topShapeImageName = [NSString stringWithFormat:@"%@F15A",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@F15A",bottomShapeImageName];
        
        //image program change
        self.navigationItem.title = [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_F15_PROGRAM_NAME];
        [self languageAndButtonUIUpdate:self.doneBtn buttonMode:3 inSection:CONTENT_FIT_C9_WATER_INTAKE_SECTION forKey:CONTENT_BUTTON_DONE backgroundColor:[THM F15AdvanceColor]];
        
    } else if (courseType == V5) {
        
        //        //navigation color change
        //        [self.mainProgramImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",programImageName,@"V5"]]];
        //        topShapeImageName = [NSString stringWithFormat:@"%@V5",topShapeImageName];
        //        bottomShapeImageName = [NSString stringWithFormat:@"%@V5",bottomShapeImageName];
        //
        //        //image program change
        //        self.navigationItem.title = [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_F15_PROGRAM_NAME];
        //        [self languageAndButtonUIUpdate:self.startNowBtn buttonMode:1 inSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS forKey:CONTENT_BUTTON_STARTNOW backgroundColor:[THM F15AdvanceColor]];
        //        [self languageAndButtonUIUpdate:self.setStartDateBtn buttonMode:1 inSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS forKey:CONTENT_BUTTON_SET_START_DATE backgroundColor:[THM F15AdvanceColor]];
        //        [self languageAndButtonUIUpdate:self.joinExistingProgram buttonMode:1 inSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE forKey:CONTENT_BUTTON_JOIN_EXISTING_PROGRAM backgroundColor:[THM F15AdvanceColor]];
    }
    
    [self.topShapes setImage:[UIImage imageNamed:topShapeImageName]];
    [self.bottomShapes setImage:[UIImage imageNamed:bottomShapeImageName]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadContentUI];
}

#pragma mark PICKERVIEW

- (NSInteger)numberOfComponentsInPickerView:(LAPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(LAPickerView *)pickerView numberOfColumnsInComponent:(NSInteger)component
{
    if (pickerView.tag == 1)
    {
        return 31;
    }
    else if (pickerView.tag == 2)
    {
        return 12;
    } else {
        return 5;
    }
}

- (NSString *)pickerView:(LAPickerView *)pickerView titleForColumn:(NSInteger)column forComponent:(NSInteger)component
{
    
    
    if (pickerView.tag == 1) {
        pp = [NSString stringWithFormat:@"%ld aaaaa",(long)column];
        return pp;
    } else if (pickerView.tag == 2){
        pp = [NSString stringWithFormat:@"%ld bbbbb",(long)column];
        return pp;
    } else {
        
        NSDate *currentDate = [NSDate date];
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* components = [calendar components:NSCalendarUnitYear fromDate:currentDate];
        
        [components month];
        [components day];
        [components year];
        
        pp = [NSString stringWithFormat:@"%ld ccccc",(long)(column + [components year])];
        return pp;
    }
    //    pp = [NSString stringWithFormat:@"%ld",(long)column];
    //    return pp;
    
}

- (void)pickerView:(LAPickerView *)pickerView didSelectColumn:(NSInteger)column inComponent:(NSInteger)component
{
    
    
    NSLog(@"Column:%ld",(long)column);
    
    [self.lblDay setTextColor:[UIColor blackColor]];
    
    
    
    if (pickerView.tag == 1)
    {
        self.lblDay.text = [NSString stringWithFormat:@"%ld",(long)column];
        _daySel = (long)column+1;
    }
    else if (pickerView.tag == 2)
    {
        self.lblMonth.text = [NSString stringWithFormat:@"%ld",(long)column];
        _monthSel = (long)column+1;
        
    } else {
        NSDate *currentDate = [NSDate date];
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* components = [calendar components:NSCalendarUnitYear fromDate:currentDate];
        self.lblYear.text = [NSString stringWithFormat:@"%ld",(long)(column + [components year])];
        _yearSel = [NSString stringWithFormat:@"%ld",(long)(column + [components year])];
    }
    
}

- (UIView *)pickerView:(LAPickerView *)pickerView viewForColumn:(NSInteger)column forComponent:(NSInteger)component reusingView:(UIView *)view
{
    FITRuler *aview = [[[NSBundle mainBundle] loadNibNamed:@"DateRuler" owner:self options:nil] objectAtIndex:0];
    
    
    if (pickerView.tag == 1){
        aview.LB.text= [NSString stringWithFormat:@"%ld",(long)(column + 1)];
        CGRect newFrame = CGRectMake( self.view.frame.origin.x, self.view.frame.origin.y, 90, self.day.frame.size.height - 40);
        aview.frame = newFrame;
        
    } else if (pickerView.tag == 2){
        
        CGRect newFrame = CGRectMake( self.view.frame.origin.x, self.view.frame.origin.y, 90, self.month.frame.size.height - 40);
        aview.frame = newFrame;
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        NSString *monthName = [[df monthSymbols] objectAtIndex:(column)];
        
        
        aview.LB.text= [NSString stringWithFormat:@"%@",monthName];
    } else {
        CGRect newFrame = CGRectMake( self.view.frame.origin.x, self.view.frame.origin.y, 90, self.year.frame.size.height - 40);
        aview.frame = newFrame;
        
        NSDate *currentDate = [NSDate date];
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* components = [calendar components:NSCalendarUnitYear fromDate:currentDate];
        aview.LB.text= [NSString stringWithFormat:@"%ld",(long)(column + [components year])];
    }
    
    
    
    aview.backgroundColor = [UIColor clearColor];
    aview.clipsToBounds = NO;
    [self.view addSubview:aview];
    
    return aview;
    
}


-(void)saveDB {
    NSString *theDate = [NSString stringWithFormat:@"%@-%02ld-%02ld",_yearSel,_monthSel,_daySel];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *selectedDate = [dateFormat dateFromString:theDate];
    User *user = [User userInDB];
    
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    
    int courseType = [defaults integerForKey:@"courseSelected"];
    int programDays =9;
    
    UserCourse *uCourse = [[UserCourse alloc] init];
    uCourse.courseType = @(courseType);
    uCourse.userProgramId = [[NSUUID UUID] UUIDString];
    uCourse.status = @(STATUS_IN_PROGRESS);
    
    uCourse.startDate = selectedDate;
    uCourse.userId = user.userdId;
    uCourse.isCurrentCourse = YES;
    if(self.courseSelected == C9) {
        uCourse.programName = COURSE_PROGRAM_NAME_C9;
        programDays= 9;
    } else if (self.courseSelected == F15Begginner1) {
        uCourse.programName = COURSE_PROGRAM_NAME_F15BEGINNER1;
        programDays = 15;
    }  else if (self.courseSelected == F15Begginner2) {
        uCourse.programName = COURSE_PROGRAM_NAME_F15BEGINNER2;
        programDays = 15;
    } else if (self.courseSelected == F15Intermidiate1) {
        uCourse.programName = COURSE_PROGRAM_NAME_F15INTERMEDIATE1;
        programDays = 15;
    } else if (self.courseSelected == F15Intermidiate2) {
        uCourse.programName = COURSE_PROGRAM_NAME_F15INTERMEDIATE2;
        programDays = 15;
    } else if (self.courseSelected == F15Advance1) {
        uCourse.programName = COURSE_PROGRAM_NAME_F15ADVANCED1;
        programDays = 15;
    } else if (self.courseSelected == F15Advance2) {
        uCourse.programName =COURSE_PROGRAM_NAME_F15ADVANCED2;
        programDays = 15;
    }
    uCourse.programDays = @(programDays);
    [[FITAPIManager sharedManager] programUpsert:CREATE
                                       programId:-1
                                     programName:uCourse.programName
                                       startDate:theDate
                                     isCompleted:NO
                            isNotificationEnable:YES
                                        isDelete:NO
                                     programDays:programDays
                               conversationTitle:@""
                                         success:^(id  _Nonnull responseObject) {
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 if([[responseObject objectForKey:@"status"] integerValue] != nil && [[responseObject objectForKey:@"status"] integerValue] == Success){
                                                     DLog(@"OK");
                                                     
                                                     RLMRealm *realm = [RLMRealm defaultRealm];
                                                     [realm beginWriteTransaction];
                                                     
                                                     NSError *jsonError;
                                                     
                                                     MTLCourse *data = [MTLJSONAdapter modelOfClass:[MTLCourse class] fromJSONDictionary:responseObject error:&jsonError];
                                                     
                                                     uCourse.serverProgramId = data.program_id;
                                                     uCourse.shareCode = data.program_code;
                                                     uCourse.userId = @0;//user.userdId;
                                                     
                                                     //chenge status of other program to set this as primary
                                                     
                                                     self.activeProgram =  [UserCourse objectsWhere:[NSString stringWithFormat:@"status = %d",1]];
                                                     if ([_activeProgram count] > 0) {
                                                         UserCourse *progUpdate = [[UserCourse alloc] init];
                                                         progUpdate = [_activeProgram objectAtIndex:0];
                                                         progUpdate.status = @(STATUS_WAITING);
                                                         [realm addOrUpdateObject:progUpdate];
                                                     }
                                                     
                                                     [realm commitWriteTransaction];
                                                     
                                                     [realm beginWriteTransaction];
                                                     
                                                     [realm addOrUpdateObject:uCourse];
                                                     
                                                     
                                                     [realm commitWriteTransaction];
                                                     [self performSegueWithIdentifier:CREATE_PROGRAM_CODE sender:nil];
                                                 }
                                             });
                                         } failure:^(NSError *error) {
                                             
                                             
                                             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                                            message:@"SERVER ERROR"
                                                                                                     preferredStyle:UIAlertControllerStyleAlert];
                                             [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                                                       style:UIAlertActionStyleCancel
                                                                                     handler:nil]];
                                             [self presentViewController:alert animated:true completion:nil];
                                         }];
}



//- (BOOL)isEndDateIsSmallerThanCurrent:(NSDate *)checkEndDate
//{
//    NSDate* enddate = checkEndDate;
//    NSDate* currentdate = [NSDate date];
//    NSTimeInterval distanceBetweenDates = [enddate timeIntervalSinceDate:currentdate];
//    double secondsInMinute = 60;
//    NSInteger secondsBetweenDates = distanceBetweenDates / secondsInMinute;
//
//    if (secondsBetweenDates == 0)
//        return YES;
//    else if (secondsBetweenDates < 0)
//        return YES;
//    else
//        return NO;
//}

- (IBAction)doneBtnTapped:(id)sender {
    
    //check day of the date selected is correct?
    int validNumberDay = NO;
    
    switch (_monthSel) {
        case 2:
            if(_daySel > 28){
                validNumberDay = NO;
            } else {
                validNumberDay = YES;
            }
            break;
        case 4:
        case 5:
        case 9:
        case 11:
            if(_daySel > 28){
                validNumberDay = NO;
            } else {
                validNumberDay = YES;
            }
            break;
            
        default:
            break;
    }
    
    if(validNumberDay){
        NSString *theDate = [NSString stringWithFormat:@"%@-%02ld-%02ld",_yearSel,_monthSel,_daySel];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        User *user = [User userInDB];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *selectedDate = [dateFormatter dateFromString:theDate];
        
        NSDate *today = [NSDate date];
        
        NSComparisonResult result;
        //NSOrderedSame,NSOrderedDescending, NSOrderedAscending
        
        result = [today compare:selectedDate];
        
        if ( result==NSOrderedDescending ) {
            NSLog(@"Select Future Date Please");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.alertController = [UIAlertController alertControllerWithTitle:@"" message:@"You must select a future date." preferredStyle:UIAlertControllerStyleAlert];
                [self.alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {    }]];
                
                [self presentViewController:self.alertController animated:YES completion:nil];
                return;
            });
        } else {
            [self saveDB];
        }
    } else {
        [[Utils sharedUtils] showAlertViewWithMessage:@"Please select correct date" buttonTitle:@"OK"];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:CREATE_PROGRAM_CODE]) {
        ProgramDashboardViewController *destinationVC = (ProgramDashboardViewController *)segue.destinationViewController;
    }
}

@end
