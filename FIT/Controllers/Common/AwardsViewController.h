//
//  AwardsViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface AwardsViewController : ProgramBaseViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet FITButton *wellSuppliedBtn;
@property (weak, nonatomic) IBOutlet FITButton *quenchedBtn;
@property (weak, nonatomic) IBOutlet FITButton *fightingFitBtn;
@property (weak, nonatomic) IBOutlet FITButton *wellSuppliedBtn2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *topShape;

@property NSMutableArray *selCell;
@property int day;
@property RLMResults *result;
@property NSString *programName;
@end
