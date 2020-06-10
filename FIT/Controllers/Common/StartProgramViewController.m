//
//  StartProgramViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "StartProgramViewController.h"
#import "ProgramDashboardViewController.h"
#import "SetProgramStartDateViewController.h"
#import "JoinProgramViewController.h"

@interface StartProgramViewController ()

@end

@implementation StartProgramViewController

@synthesize setStartDateBtn,startNowBtn,joinExistingProgram;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadContentUI];
}

- (void) loadContentUI {
    
    _databaseProgramName = [[NSString alloc] init];
    NSString *programImageName = @"programName";
    NSString *topShapeImageName = @"topshapes";
    NSString *bottomShapeImageName = @"smallBaseshapes";
    
    if(self.courseSelected == C9){
        
        //navigation color change
        [self.navigationController.navigationBar setBarTintColor:[THM C9Color]];
        //image program change
        [self.mainProgramImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",programImageName,@"C9"]]];
        topShapeImageName = [NSString stringWithFormat:@"%@C9",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@C9",bottomShapeImageName];
        
        self.navigationItem.title = [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_C9_PROGRAM_NAME];
        [self languageAndButtonUIUpdate:self.startNowBtn buttonMode:1 inSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS forKey:CONTENT_BUTTON_STARTNOW backgroundColor:[THM C9Color]];
        [self languageAndButtonUIUpdate:self.setStartDateBtn buttonMode:1 inSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS forKey:CONTENT_BUTTON_SET_START_DATE backgroundColor:[THM C9Color]];
        [self languageAndButtonUIUpdate:self.joinExistingProgram buttonMode:1 inSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE forKey:CONTENT_BUTTON_JOIN_EXISTING_PROGRAM backgroundColor:[THM C9Color]];
    } else if(self.courseSelected  == F15Begginner || self.courseSelected == F15Begginner1 || self.courseSelected == F15Begginner2){
        //navigation color change
        [self.navigationController.navigationBar setBarTintColor:[THM F15BeginnerColor]];
        //image program change
        [self.mainProgramImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",programImageName,@"F15B"]]];
        topShapeImageName = [NSString stringWithFormat:@"%@F15B",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@F15B",bottomShapeImageName];
        
        self.navigationItem.title = [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_F15_PROGRAM_NAME];
        [self languageAndButtonUIUpdate:self.startNowBtn buttonMode:1 inSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS forKey:CONTENT_BUTTON_STARTNOW backgroundColor:[THM F15BeginnerColor]];
        [self languageAndButtonUIUpdate:self.setStartDateBtn buttonMode:1 inSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS forKey:CONTENT_BUTTON_SET_START_DATE backgroundColor:[THM F15BeginnerColor]];
        [self languageAndButtonUIUpdate:self.joinExistingProgram buttonMode:1 inSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE forKey:CONTENT_BUTTON_JOIN_EXISTING_PROGRAM backgroundColor:[THM F15BeginnerColor]];
    } else if(self.courseSelected == F15Intermidiate || self.courseSelected == F15Intermidiate1 || self.courseSelected == F15Intermidiate2){
        //navigation color change
        [self.navigationController.navigationBar setBarTintColor:[THM F15IntermidiateColor]];
        [self.mainProgramImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",programImageName,@"F15I"]]];
        topShapeImageName = [NSString stringWithFormat:@"%@F15I",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@F15I",bottomShapeImageName];
        
        //image program change
        self.navigationItem.title = [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_F15_PROGRAM_NAME];
        [self languageAndButtonUIUpdate:self.startNowBtn buttonMode:1 inSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS forKey:CONTENT_BUTTON_STARTNOW backgroundColor:[THM F15IntermidiateColor]];
        [self languageAndButtonUIUpdate:self.setStartDateBtn buttonMode:1 inSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS forKey:CONTENT_BUTTON_SET_START_DATE backgroundColor:[THM F15IntermidiateColor]];
        [self languageAndButtonUIUpdate:self.joinExistingProgram buttonMode:1 inSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE forKey:CONTENT_BUTTON_JOIN_EXISTING_PROGRAM backgroundColor:[THM F15IntermidiateColor]];
    } else if(self.courseSelected == F15Advance || self.courseSelected == F15Advance1 || self.courseSelected == F15Advance2) {
        //navigation color change
        [self.navigationController.navigationBar setBarTintColor:[THM F15AdvanceColor
                                                                  ]];
        [self.mainProgramImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",programImageName,@"F15A"]]];
        topShapeImageName = [NSString stringWithFormat:@"%@F15A",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@F15A",bottomShapeImageName];
        
        //image program change
        self.navigationItem.title = [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_F15_PROGRAM_NAME];
        [self languageAndButtonUIUpdate:self.startNowBtn buttonMode:1 inSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS forKey:CONTENT_BUTTON_STARTNOW backgroundColor:[THM F15AdvanceColor]];
        [self languageAndButtonUIUpdate:self.setStartDateBtn buttonMode:1 inSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS forKey:CONTENT_BUTTON_SET_START_DATE backgroundColor:[THM F15AdvanceColor]];
        [self languageAndButtonUIUpdate:self.joinExistingProgram buttonMode:1 inSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE forKey:CONTENT_BUTTON_JOIN_EXISTING_PROGRAM backgroundColor:[THM F15AdvanceColor]];
    } else if (self.courseSelected == V5) {
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message:@"Course yet not available" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancelAction= [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        //navigation color change
        [self.mainProgramImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",programImageName,@"V5"]]];
        topShapeImageName = [NSString stringWithFormat:@"%@V5",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@V5",bottomShapeImageName];
        
        //image program change
        self.navigationItem.title = [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_F15_PROGRAM_NAME];
        [self languageAndButtonUIUpdate:self.startNowBtn buttonMode:1 inSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS forKey:CONTENT_BUTTON_STARTNOW backgroundColor:[THM F15AdvanceColor]];
        [self languageAndButtonUIUpdate:self.setStartDateBtn buttonMode:1 inSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS forKey:CONTENT_BUTTON_SET_START_DATE backgroundColor:[THM F15AdvanceColor]];
        [self languageAndButtonUIUpdate:self.joinExistingProgram buttonMode:1 inSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE forKey:CONTENT_BUTTON_JOIN_EXISTING_PROGRAM backgroundColor:[THM F15AdvanceColor]];
    }
    
    [self.topShapes setImage:[UIImage imageNamed:topShapeImageName]];
    [self.bottomShapes setImage:[UIImage imageNamed:bottomShapeImageName]];
    
    [self.setStartDateBtn setUserInteractionEnabled:YES];
    self.setStartDateBtn.alpha = 1;
    [self.startNowBtn setUserInteractionEnabled:YES];
    self.startNowBtn.alpha = 1;

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadContentUI];
}

- (IBAction)startNowTapped:(id)sender {
    [self.startNowBtn setUserInteractionEnabled:NO];
    self.startNowBtn.alpha = 0.7;
    [self.setStartDateBtn setUserInteractionEnabled:YES];
    self.setStartDateBtn.alpha = 1;
    
    [self saveDB];
    
}

- (IBAction)setStartDateTapped:(id)sender {
    [self.setStartDateBtn setUserInteractionEnabled:NO];
    self.setStartDateBtn.alpha = 0.7;
    [self.startNowBtn setUserInteractionEnabled:YES];
    self.startNowBtn.alpha = 1;
    
    [self performSegueWithIdentifier:SET_START_DATE_PUSH sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SET_START_DATE_PUSH]) {
        SetProgramStartDateViewController *destinationVC = (SetProgramStartDateViewController *)segue.destinationViewController;
        destinationVC.courseSelected = self.courseSelected;
    } else if([segue.identifier isEqualToString:JOIN_EXISITING_PUSH]) {
        JoinProgramViewController *destinationVC = (JoinProgramViewController *)segue.destinationViewController;
        destinationVC.courseSelected = self.courseSelected;
    }
}

- (IBAction)joinExistingProgramTapped:(id)sender {
    [self performSegueWithIdentifier:JOIN_EXISITING_PUSH sender:nil];
}

-(void)saveDB{
    // convert date without time
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *now = [[NSDate alloc] init];
    NSString *theDate = [dateFormat stringFromDate:now];
    User *user = [User userInDB];
    
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    
    int courseType = [defaults integerForKey:@"courseSelected"];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    int programDays =9;
    
    UserCourse *uCourse = [[UserCourse alloc] init];
    uCourse.courseType = @(courseType);
    uCourse.userProgramId = [[NSUUID UUID] UUIDString];
    uCourse.status = @(STATUS_IN_PROGRESS);
    
    uCourse.startDate = now;
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
                               conversationTitle:uCourse.programName
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
                                                     uCourse.conversationId = data.conversation_id;
                                                     
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
                                                     
                                                     ProgramDashboardViewController *joinProgram = (ProgramDashboardViewController *)[self.storyboard instantiateViewControllerWithIdentifier:PROGRAM_DASHBOARD];
                                                     
                                                     [self.navigationController pushViewController:joinProgram animated:YES];
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
    
    [realm commitWriteTransaction];
}

@end
