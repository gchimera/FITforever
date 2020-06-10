//
//  CheckListViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface CheckListViewController : ProgramBaseViewController

@property (weak, nonatomic) IBOutlet UIView *scrollViewContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewContainerHeight;

@property long countBreakfast;
@property long countSnack;
@property long countLunch;
@property long countDinner;
@property long countEvening;

@property NSArray *meals;
@property RLMResults *breakfastChecklist;
@property RLMResults *snackChecklist;
@property RLMResults *lunchChecklist;
@property RLMResults *dinnerChecklist;
@property RLMResults *eveningChecklist;

@property RLMResults *supplementsCount;
@property int checkedCount;
@property RLMResults *waterCount;
@property int waterCheckedCount;


@property int day;
@property int meal;

@end
