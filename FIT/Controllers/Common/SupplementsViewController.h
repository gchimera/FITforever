//
//  SupplementsViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface SupplementsViewController : ProgramBaseViewController


@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet FITButton *nextBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



- (IBAction)nextBtnTapped:(id)sender;
- (IBAction)drawerToggle:(id)sender;

@property NSString* sender;
@property NSString *foodDisplayMode;




@end
