//
//  C9ExercisesViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface C9ExercisesViewController : ProgramBaseViewController
@property (weak, nonatomic) IBOutlet FITButton *twoMinutesStretchBtn;
@property (weak, nonatomic) IBOutlet FITButton *fiveMinutesWarmupBtn;
@property (weak, nonatomic) IBOutlet FITButton *thirtyMinutesExerciseBtn;

@property (weak, nonatomic) IBOutlet UIImageView *tick1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tick2ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tick3ImageView;
@property (weak, nonatomic) IBOutlet UILabel *exercisesHowToLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerText;

@property RLMResults *result;
@property bool isTwoMinutesDone;
@property bool isFiveMinutesDone;
@property bool isThirtyMinutesDone;
@property int day;
@end
