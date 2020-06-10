//
//  JoinProgramViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 20/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "JoinProgramViewController.h"
#import "ProgramDashboardViewController.h"

@interface JoinProgramViewController ()

@property UIAlertController *alertController;

@end

@implementation JoinProgramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadContentUI];
}

-(void) loadContentUI{
    
    // Dispose of any resources that can be recreated.
    [self languageAndLabelUIUpdate:self.titleJoinProgram inSection:CONTENT_FIT_JOIN_PROG forKey:CONTENT_JOIN_EXISTING_PROGRAM_HEADING];
    [self languageAndLabelUIUpdate:self.descriptionJoinProgam inSection:CONTENT_FIT_JOIN_PROG forKey:CONTENT_JOIN_EXISTING_PROGRAM_DESCRIPTION];
    [self languageAndLabelUIUpdate:self.yourShareCode inSection:CONTENT_FIT_JOIN_PROG forKey:CONTENT_LABEL_ENTER_SHARED_CODE];
    
    NSString *topShapeImageName = @"topshapes";
    NSString *bottomShapeImageName = @"smallBaseshapes";
    
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    int courseType = [defaults integerForKey:@"courseSelected"];
    if(courseType == C9) {
        self.navigationItem.title = [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_C9_PROGRAM_NAME];
        [self languageAndButtonUIUpdate:self.joinProgram buttonMode:3 inSection:CONTENT_FIT_JOIN_PROG forKey:CONTENT_BUTTON_START_PROGRAM backgroundColor:[THM C9Color]];
        //image program change
        topShapeImageName = [NSString stringWithFormat:@"%@C9",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@C9",bottomShapeImageName];
        [self.navigationController.navigationBar setBarTintColor:[THM C9Color]];
        [self.titleJoinProgram setTextColor:[THM C9Color]];
        [self.yourShareCode setTextColor:[THM C9Color]];
    } else if (courseType == F15Begginner1 || courseType == F15Begginner2) {
        self.navigationItem.title = [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_F15_PROGRAM_NAME];
        [self languageAndButtonUIUpdate:self.joinProgram buttonMode:3 inSection:CONTENT_FIT_JOIN_PROG forKey:CONTENT_BUTTON_START_PROGRAM backgroundColor:[THM F15BeginnerColor]];
        topShapeImageName = [NSString stringWithFormat:@"%@F15B",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@F15B",bottomShapeImageName];
        [self.navigationController.navigationBar setBarTintColor:[THM F15BeginnerColor]];
        [self.titleJoinProgram setTextColor:[THM F15BeginnerColor]];
        [self.yourShareCode setTextColor:[THM F15BeginnerColor]];
    } else if (courseType == F15Intermidiate1 || courseType == F15Intermidiate2) {
        self.navigationItem.title = [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_F15_PROGRAM_NAME];
        [self languageAndButtonUIUpdate:self.joinProgram buttonMode:3 inSection:CONTENT_FIT_JOIN_PROG forKey:CONTENT_BUTTON_START_PROGRAM backgroundColor:[THM F15IntermidiateColor]];
        topShapeImageName = [NSString stringWithFormat:@"%@F15I",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@F15I",bottomShapeImageName];
        [self.navigationController.navigationBar setBarTintColor:[THM F15IntermidiateColor]];
        [self.titleJoinProgram setTextColor:[THM F15IntermidiateColor]];
        [self.yourShareCode setTextColor:[THM F15IntermidiateColor]];
    } else if (courseType == F15Advance1 || courseType == F15Advance2) {
        self.navigationItem.title = [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_NAMES andKey:CONTENT_F15_PROGRAM_NAME];
        [self languageAndButtonUIUpdate:self.joinProgram buttonMode:3 inSection:CONTENT_FIT_JOIN_PROG forKey:CONTENT_BUTTON_START_PROGRAM backgroundColor:[THM F15AdvanceColor]];
        topShapeImageName = [NSString stringWithFormat:@"%@F15A",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@F15A",bottomShapeImageName];
        [self.navigationController.navigationBar setBarTintColor:[THM F15AdvanceColor]];
        [self.titleJoinProgram setTextColor:[THM F15AdvanceColor]];
        [self.yourShareCode setTextColor:[THM F15AdvanceColor]];
    }
    [self.topShapes setImage:[UIImage imageNamed:topShapeImageName]];
    [self.bottomShapes setImage:[UIImage imageNamed:bottomShapeImageName]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadContentUI];
}

- (IBAction)JoinProgramClick:(id)sender {
    
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    int courseType = [defaults integerForKey:@"courseSelected"];
    int programDays =9;
    
    UserCourse *uCourse = [[UserCourse alloc] init];
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
    if(![self.shareCode hasText]){
        dispatch_async(dispatch_get_main_queue(), ^{
        
        self.alertController = [UIAlertController alertControllerWithTitle:@"" message:[self localisedStringForSection:CONTENT_FIT_JOIN_PROG andKey:CONTENT_LABEL_ENTER_SHARED_CODE] preferredStyle:UIAlertControllerStyleAlert];
        [self.alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {    }]];
            
            [self presentViewController:self.alertController animated:YES completion:nil];
        });
    } else {
        [[FITAPIManager sharedManager] joinProgram:uCourse.programName shareCode:self.shareCode.text success:^(id  _Nonnull responseObject) {
            
            ///here complete teh program
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if([[responseObject objectForKey:@"status"] integerValue] != nil && [[responseObject objectForKey:@"status"] integerValue] == Success){
                    DLog(@"OK");
                    NSError *jsonError;
                    
                    MTLCourse *data = [MTLJSONAdapter modelOfClass:[MTLCourse class] fromJSONDictionary:responseObject error:&jsonError];
                    
                    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                    [dateFormat setDateFormat:@"yyyy-MM-dd"];
                    NSDate *selectedDate = [dateFormat dateFromString:data.start_date];
                    User *user = [User userInDB];
                    
                    uCourse.courseType = @(courseType);
                    uCourse.userProgramId = [[NSUUID UUID] UUIDString];
                    uCourse.status = @(STATUS_IN_PROGRESS);
                    
                    uCourse.startDate = selectedDate;
                    uCourse.userId = user.userdId;
                    uCourse.isCurrentCourse = YES;
                    uCourse.programDays = @(programDays);
                    RLMRealm *realm = [RLMRealm defaultRealm];
                    [realm beginWriteTransaction];
                    
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
                    
                    ProgramDashboardViewController *joinProgram = (ProgramDashboardViewController *)[self.storyboard instantiateViewControllerWithIdentifier:PROGRAM_DASHBOARD];
                    
                    [self.navigationController pushViewController:joinProgram animated:YES];
                } else if ([[responseObject objectForKey:@"status"] integerValue] != nil && [[responseObject objectForKey:@"status"] integerValue] == 109){
                    
                    self.alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Share code inserted not valid" preferredStyle:UIAlertControllerStyleAlert];
                    [self.alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {    }]];
                    
                    [self presentViewController:self.alertController animated:YES completion:nil];
                }
            });
        } failure:^(NSError *error) {
            
            [[Utils sharedUtils] showAlertViewWithMessage:@"Code or program entered is wrong please retry" buttonTitle:@"OK"];
        }];
    }
}

@end
