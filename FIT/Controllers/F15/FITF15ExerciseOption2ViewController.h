//
//  FITF15ExerciseOption2ViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 04/04/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"
#import "FITBurgerMenu.h"
#import "Realm/Realm.h"
#import "Exercise.h"

@interface FITF15ExerciseOption2ViewController : ProgramBaseViewController
@property int day;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *descriptLB;
- (IBAction)doneBtnTapped:(id)sender;
@property (weak, nonatomic) IBOutlet FITButton *doneBtn;
@property (weak, nonatomic) IBOutlet UIImageView *topShapes;

@property RLMResults *workoutResults;
@property RLMResults *exerciseResults;
@property NSString *exerciseName;
@property NSString *systemName;
@property bool isCurrentDay;

@end
