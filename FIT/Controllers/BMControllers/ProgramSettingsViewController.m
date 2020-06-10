//
//  ProgramSettingsViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 20/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramSettingsViewController.h"
#import "InitialViewController.h"


@interface ProgramSettingsViewController ()

@property bool isEditingMode;

@end

@implementation ProgramSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self languageAndButtonUIUpdate:self.editStartDateBtn buttonMode:3 inSection:CONTENT_FITAPP_PROGRAM_SETTINGS_SECTION forKey:CONTENT_BUTTON_EDIT_START_DATE backgroundColor:[THM BMColor]];
    [self languageAndButtonUIUpdate:self.logOutBtn buttonMode:3 inSection:CONTENT_FITAPP_PROGRAM_SETTINGS_SECTION forKey:CONTENT_BUTTON_LOG_OUT backgroundColor:[THM BMColor]];
    [self languageAndButtonUIUpdate:self.doneBtn buttonMode:3 inSection:CONTENT_FITAPP_PROGRAM_SETTINGS_SECTION forKey:CONTENT_BUTTON_SAVE backgroundColor:[THM BMColor]];
    
    
    self.isEditingMode = NO;
    self.xButton.layer.cornerRadius = self.xButton.frame.size.width / 2;
    
    RLMResults *userCourseResults = [UserCourse objectsWhere:[NSString stringWithFormat:@"status = 1"]];
    

    if([userCourseResults count] > 0 ) {
        RLMObject *userCourse = [userCourseResults firstObject];
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSString *dateString = [formatter stringFromDate:userCourse[@"startDate"]];
        
        
        self.startDateTxtfield.text = dateString;

        
        NSDate *today = [NSDate date];
        NSComparisonResult result;
        //NSOrderedSame,NSOrderedDescending, NSOrderedAscending

        result = [today compare:userCourse[@"startDate"]];
        
        if ( !(result == NSOrderedAscending) ) {
            self.editStartDateBtn.hidden = YES;
        }
        
        NSLog(@"%@",userCourse[@"courseType"]);
        
        if([userCourse[@"courseType"] integerValue] == C9){

            [self languageAndButtonUIUpdate:self.currentCourseBtn buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM C9Color]];
            [self.currentCourseBtn setTitle:[NSString stringWithFormat:@"C9"] forState:UIControlStateNormal];
            
        } else if ([userCourse[@"courseType"] integerValue] == F15Begginner1) {
            [self languageAndButtonUIUpdate:self.currentCourseBtn buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15BeginnerColor]];
            [self.currentCourseBtn setTitle:[NSString stringWithFormat:@"F15"] forState:UIControlStateNormal];
        } else if ([userCourse[@"courseType"] integerValue] == F15Begginner2) {
            [self languageAndButtonUIUpdate:self.currentCourseBtn buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15BeginnerColor]];
            [self.currentCourseBtn setTitle:[NSString stringWithFormat:@"F15"] forState:UIControlStateNormal];
        } else if ([userCourse[@"courseType"] integerValue] == F15Intermidiate1) {
            [self languageAndButtonUIUpdate:self.currentCourseBtn buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15IntermidiateColor]];
            [self.currentCourseBtn setTitle:[NSString stringWithFormat:@"F15"] forState:UIControlStateNormal];
        } else if ([userCourse[@"courseType"] integerValue] == F15Intermidiate2) {
            [self languageAndButtonUIUpdate:self.currentCourseBtn buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15IntermidiateColor]];
            [self.currentCourseBtn setTitle:[NSString stringWithFormat:@"F15"] forState:UIControlStateNormal];
        } else if ([userCourse[@"courseType"] integerValue] == F15Advance1) {
            [self languageAndButtonUIUpdate:self.currentCourseBtn buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15AdvanceColor]];
            [self.currentCourseBtn setTitle:[NSString stringWithFormat:@"F15"] forState:UIControlStateNormal];
        } else if ([userCourse[@"courseType"] integerValue] == F15Advance2) {
            [self languageAndButtonUIUpdate:self.currentCourseBtn buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15AdvanceColor]];
            [self.currentCourseBtn setTitle:[NSString stringWithFormat:@"F15"] forState:UIControlStateNormal];

        }
    }
}


- (IBAction)pushNotificationSwitchTapped:(id)sender {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error)
     {
         if( !error )
         {
             [[UIApplication sharedApplication] registerForRemoteNotifications];
             NSLog( @"Push registration success." );
         }
         else
         {
             NSLog( @"Push registration FAILED" );
             NSLog( @"ERROR: %@ - %@", error.localizedFailureReason, error.localizedDescription );
             NSLog( @"SUGGESTIONS: %@ - %@", error.localizedRecoveryOptions, error.localizedRecoverySuggestion );
         }
     }];
}

- (IBAction)editStartBtnTapped:(id)sender {
    if(self.isEditingMode) {
        

        NSString *date = self.startDateTxtfield.text;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        if ([dateFormatter dateFromString:date]) {
            //YES
        
        
        
        [[FITAPIManager sharedManager] programUpsert:UPDATE
                                           programId:[self.currentCourseBM.serverProgramId integerValue]
                                         programName:self.currentCourseBM.programName
                                           startDate:date
                                         isCompleted:NO
                                isNotificationEnable:YES
                                            isDelete:NO
                                         programDays:[self.currentCourseBM.programDays integerValue]
                                   conversationTitle:@""
                                             success:^(id  _Nonnull responseObject) {
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     if([[responseObject objectForKey:@"status"] integerValue] != nil && [[responseObject objectForKey:@"status"] integerValue] == Success){
                                                         DLog(@"OK");
                                                         
                                                         
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
        } else {
            NSLog(@"Not Saved");
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"The date entered is not in the correct format \n Ex. 2017-05-20" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }

        self.startDateTxtfield.userInteractionEnabled = NO;
        self.xButton.hidden = YES;
        self.isEditingMode = NO;
        [self languageAndButtonUIUpdate:self.editStartDateBtn buttonMode:3 inSection:CONTENT_FITAPP_PROGRAM_SETTINGS_SECTION forKey:CONTENT_BUTTON_EDIT_START_DATE backgroundColor:[THM BMColor]];
        
        
        
    } else {
        self.isEditingMode = YES;
        self.startDateTxtfield.userInteractionEnabled = YES;
        self.xButton.hidden = NO;
        [self languageAndButtonUIUpdate:self.editStartDateBtn buttonMode:3 inSection:CONTENT_FITAPP_PROGRAM_SETTINGS_SECTION forKey:CONTENT_BUTTON_SAVE backgroundColor:[THM BMColor]];
  
    }
    
    
    
    
    
    
}

- (IBAction)logOutBtnTapped:(id)sender {
    [[Utils sharedUtils] logoutAndCleanAllData];
    InitialViewController *loginController = [[UIStoryboard storyboardWithName:LOGIN_STORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:INITIAL_SCREEN]; //or the homeController
    [self.navigationController pushViewController:loginController animated:YES];

}

- (IBAction)doneBtnTapped:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Program" bundle:nil];
    
    UIViewController *home = [sb instantiateViewControllerWithIdentifier:PROGRAM_DASHBOARD];
    [self.navigationController pushViewController:home animated:YES];
}

- (IBAction)xBtnTapped:(id)sender {
    self.startDateTxtfield.text = @"";
}
@end
