//
//  SettingsViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 20/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MenuBaseViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "STCollapseTableView.h"
#import "SettingsCustomCell.h"

@interface SettingsViewController : MenuBaseViewController <UNUserNotificationCenterDelegate,UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray* data;

@property (nonatomic, strong) NSArray* dataHeader;
@property (nonatomic, strong) NSArray* functionality;


@property (nonatomic, strong) NSMutableArray* headers;
@property IBOutlet STCollapseTableView *Tabella;
@property IBOutlet FITButton *logout;
@property IBOutlet FITButton *done;

@property SettingsCustomCell *cell;

- (IBAction)logoutBtnTapped:(id)sender;
- (IBAction)doneBtnTapped:(id)sender;


@end
