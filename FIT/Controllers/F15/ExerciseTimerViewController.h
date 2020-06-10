//
//  ExerciseTimerViewController.h
//  FIT
//
//  Created by Hadi Roohian on 03/04/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"
#import "MBCircularProgressBarView.h"
#import "Exercise.h"

@interface ExerciseTimerViewController : ProgramBaseViewController
@property (weak, nonatomic) IBOutlet MBCircularProgressBarView *timerBar;
@property (weak, nonatomic) IBOutlet FITButton *doneBtn;
@property NSArray *exerciseDetails;
@property int day;
@property (weak, nonatomic) IBOutlet UIImageView *topShapes;
@property (weak, nonatomic) IBOutlet UILabel *currentExerciseLbl;
@property (weak, nonatomic) IBOutlet UILabel *nextExerciseLbl;
@property (weak, nonatomic) IBOutlet UILabel *nextExerciseTimeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *tickImg;
@property (weak, nonatomic) IBOutlet UILabel *secondsLbl;

- (IBAction)doneBtnTapped:(id)sender;
- (IBAction)drawerToggle:(id)sender;


@property RLMResults *workoutResults;
@property RLMResults *exerciseResults;
@property NSString *systemName;
@property bool isCurrentDay;
@end
