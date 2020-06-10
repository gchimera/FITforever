//
//  ShareCodeViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 20/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ShareCodeViewController.h"
#import "ProgramDashboardViewController.h"

@interface ShareCodeViewController ()
@property UIAlertController *alertController;

@end

@implementation ShareCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadContentUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadContentUI {
    
    
    [self languageAndLabelUIUpdate:self.shareCodeTitle inSection:CONTENT_FIT_NEW_PROG forKey:CONTENT_CREATE_NEW_PROGRAM_HEADING];
    [self languageAndLabelUIUpdate:self.shareCodeDetail inSection:CONTENT_FIT_NEW_PROG forKey:CONTENT_CREATE_NEW_PROGRAM_DESCRIPTION];
    [self languageAndLabelUIUpdate:self.yourShareCode inSection:CONTENT_FIT_NEW_PROG forKey:CONTENT_LABEL_YOUR_SHARE_CODE];
    [self languageAndLabelUIUpdate:self.GroupNameLabrl inSection:CONTENT_FIT_NEW_PROG forKey:CONTENT_LABEL_GROUP_NAME];
    
    NSString *topShapeImageName = @"topshapes";
    NSString *bottomShapeImageName = @"smallBaseshapes";
    
    if([self.currentCourse.courseType integerValue] == C9) {
        [self languageAndButtonUIUpdate:self.sendInvite buttonMode:3 inSection:CONTENT_FIT_NEW_PROG forKey:CONTENT_BUTTON_SELECT_YOUR_FRIENDS backgroundColor:[THM C9Color]];
        [self languageAndButtonUIUpdate:self.startProgram buttonMode:3 inSection:CONTENT_FIT_NEW_PROG forKey:CONTENT_BUTTON_START_PROGRAM backgroundColor:[THM C9Color]];
        //image program change
        topShapeImageName = [NSString stringWithFormat:@"%@C9",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@C9",bottomShapeImageName];
        
    } else if ([self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2) {
        [self languageAndButtonUIUpdate:self.sendInvite buttonMode:3 inSection:CONTENT_FIT_NEW_PROG forKey:CONTENT_BUTTON_SELECT_YOUR_FRIENDS backgroundColor:[THM F15BeginnerColor]];
        [self languageAndButtonUIUpdate:self.startProgram buttonMode:3 inSection:CONTENT_FIT_NEW_PROG forKey:CONTENT_BUTTON_START_PROGRAM backgroundColor:[THM F15BeginnerColor]];
        //image program change
        topShapeImageName = [NSString stringWithFormat:@"%@F15B",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@F15B",bottomShapeImageName];
        
    } else if ([self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2) {
        [self languageAndButtonUIUpdate:self.sendInvite buttonMode:3 inSection:CONTENT_FIT_NEW_PROG forKey:CONTENT_BUTTON_SELECT_YOUR_FRIENDS backgroundColor:[THM F15IntermidiateColor]];
        [self languageAndButtonUIUpdate:self.startProgram buttonMode:3 inSection:CONTENT_FIT_NEW_PROG forKey:CONTENT_BUTTON_START_PROGRAM backgroundColor:[THM F15IntermidiateColor]];
        topShapeImageName = [NSString stringWithFormat:@"%@F15I",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@F15I",bottomShapeImageName];
        
    } else if ([self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2) {
        [self languageAndButtonUIUpdate:self.sendInvite buttonMode:3 inSection:CONTENT_FIT_NEW_PROG forKey:CONTENT_BUTTON_SELECT_YOUR_FRIENDS backgroundColor:[THM F15AdvanceColor]];
        [self languageAndButtonUIUpdate:self.startProgram buttonMode:3 inSection:CONTENT_FIT_NEW_PROG forKey:CONTENT_BUTTON_START_PROGRAM backgroundColor:[THM F15AdvanceColor]];
        topShapeImageName = [NSString stringWithFormat:@"%@F15A",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@F15A",bottomShapeImageName];
    }else if ([self.currentCourse.courseType integerValue] == V5) {
        //navigation color change
        topShapeImageName = [NSString stringWithFormat:@"%@V5",topShapeImageName];
        bottomShapeImageName = [NSString stringWithFormat:@"%@V5",bottomShapeImageName];
        
    }
    self.navigationItem.title = [self localisedStringForSection:CONTENT_FITAPP_LABELS_INVITE_SCREEN andKey:CONTENT_LABEL_INVITE_FRIENDS];
    
    [self.topShapes setImage:[UIImage imageNamed:topShapeImageName]];
    [self.bottomShapes setImage:[UIImage imageNamed:bottomShapeImageName]];
    
    [self.shareCode setText:self.currentCourse.shareCode];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadContentUI];
}

- (IBAction)startProgramPress:(id)sender {
    if(![self.groupName hasText]){
        
        dispatch_async(dispatch_get_main_queue(), ^{
        self.alertController = [UIAlertController alertControllerWithTitle:@"" message:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_MANDATORY_DATA_MISSING] preferredStyle:UIAlertControllerStyleAlert];
        [self.alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {    }]];
            
            [self presentViewController:self.alertController animated:YES completion:nil];
        });
    } else {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *date = [dateFormatter stringFromDate:self.currentCourse.startDate];
        [[FITAPIManager sharedManager] programUpsert:UPDATE
                                           programId:[self.currentCourse.serverProgramId integerValue]
                                         programName:self.currentCourse.programName
                                           startDate:date
                                         isCompleted:NO
                                isNotificationEnable:YES
                                            isDelete:NO
                                         programDays:[self.currentCourse.programDays integerValue]
                                   conversationTitle:self.groupName.text
                                             success:^(id  _Nonnull responseObject) {
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     if([[responseObject objectForKey:@"status"] integerValue] != nil && [[responseObject objectForKey:@"status"] integerValue] == Success){
                                                         DLog(@"OK");
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
    }
        
}

- (IBAction)sendInvitesPress:(id)sender {
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",[self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS andKey:CONTENT_SHARE_PROGRAM_TEXT_PART1],self.currentCourse.programName, [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS andKey:CONTENT_SHARE_PROGRAM_TEXT_PART2],self.currentCourse.shareCode,[self localisedStringForSection:CONTENT_PLACEHOLDER_SECTION andKey:CONTENT_SHARE_END_PART]];
    
    UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:@[text] applicationActivities:nil];
    activityViewControntroller.excludedActivityTypes = @[];
    
    [self presentViewController:activityViewControntroller animated:true completion:nil];
}
@end
