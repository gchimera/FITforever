//
//  AddIngredientsViewController.h
//  FIT
//
//  Created by Hadi Roohian on 03/04/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface AddIngredientsViewController : ProgramBaseViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet FITButton *saveBtn;
@property (weak, nonatomic) IBOutlet FITButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *addYourOwnIngredientsLabel;

- (IBAction)saveBtnTapped:(id)sender;
- (IBAction)cancelBtnTapped:(id)sender;

@end
