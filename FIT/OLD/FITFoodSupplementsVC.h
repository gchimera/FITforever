//
//  FITFoodSupplementsVC.h
//  fitapp
//
//  Created by Hadi Roohian on 29/12/2016.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FITDBChecklist.h"
#import "Realm.h"
#import "FITBurgerMenu.h"
#import "ProgramBaseViewController.h"

@interface FITFoodSupplementsVC : ProgramBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet FITButton *nextBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



- (IBAction)nextBtnTapped:(id)sender;
- (IBAction)drawerToggle:(id)sender;

@property NSString* mealSelected;
@property NSInteger courseMapNumber;


@end
