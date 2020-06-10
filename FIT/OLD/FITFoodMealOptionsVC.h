//
//  FITFoodMealOptionsVC.h
//  fitapp
//
//  Created by Hadi Roohian on 28/12/2016.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FITBurgerMenu.h"
#import "ProgramBaseViewController.h"

@interface FITFoodMealOptionsVC : ProgramBaseViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet FITButton *createYourOwnMealBtn;
@property (weak, nonatomic) IBOutlet FITButton *doneBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)doneBtnTapped:(id)sender;

- (IBAction)drawerToggle:(id)sender;

// recveing or sending
@property NSString* mealSelected;
@property NSInteger courseMapNumber;



@end
