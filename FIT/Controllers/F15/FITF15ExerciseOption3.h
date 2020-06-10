//
//  FITF15ExerciseOption2.h
//  fitapp
//
//  Created by Hadi Roohian on 10/03/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FITBurgerMenu.h"
#import "Realm/Realm.h"
#import "Exercise.h"
//#import "MBCircularProgressBarView.h"
#import "ProgramBaseViewController.h"

@interface FITF15ExerciseOption3 : ProgramBaseViewController <UITableViewDelegate, UITableViewDataSource>
@property int day;
@property (weak, nonatomic) IBOutlet FITButton *startWorkoutBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *topShapes;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;
@property NSString *exerciseName;
@property NSString *systemName;
@property bool isCurrentDay;

- (IBAction)drawerToggle:(id)sender;
- (IBAction)startWorkoutBtnTapped:(id)sender;

@end
