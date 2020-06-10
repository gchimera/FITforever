//
//  ProgramSettingsViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 20/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MenuBaseViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ProgramSettingsViewController : MenuBaseViewController <UNUserNotificationCenterDelegate>
@property (weak, nonatomic) IBOutlet FITButton *editStartDateBtn;
@property (weak, nonatomic) IBOutlet FITButton *logOutBtn;
@property (weak, nonatomic) IBOutlet FITButton *doneBtn;
@property (weak, nonatomic) IBOutlet UITextField *startDateTxtfield;
@property (weak, nonatomic) IBOutlet UISwitch *pushNotificationSwitch;
@property (weak, nonatomic) IBOutlet FITButton *currentCourseBtn;
@property (weak, nonatomic) IBOutlet UIButton *xButton;


- (IBAction)pushNotificationSwitchTapped:(id)sender;
- (IBAction)editStartBtnTapped:(id)sender;
- (IBAction)logOutBtnTapped:(id)sender;
- (IBAction)doneBtnTapped:(id)sender;
- (IBAction)xBtnTapped:(id)sender;


@end
