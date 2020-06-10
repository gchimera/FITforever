//
//  F15ExercisesViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 16/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface F15ExercisesViewController : ProgramBaseViewController

@property (weak, nonatomic) IBOutlet UILabel *lblDay1;
@property (weak, nonatomic) IBOutlet UILabel *lblDay2;
@property (weak, nonatomic) IBOutlet UILabel *lblDay3;
@property (weak, nonatomic) IBOutlet UILabel *lblDay4;
@property (weak, nonatomic) IBOutlet UILabel *lblDay5;
@property (weak, nonatomic) IBOutlet UILabel *lblDay6;
@property (weak, nonatomic) IBOutlet UILabel *lblDay7;
@property (weak, nonatomic) IBOutlet UILabel *lblDay8;
@property (weak, nonatomic) IBOutlet UILabel *lblDay9;
@property (weak, nonatomic) IBOutlet UILabel *lblDay10;
@property (weak, nonatomic) IBOutlet UILabel *lblDay11;
@property (weak, nonatomic) IBOutlet UILabel *lblDay12;
@property (weak, nonatomic) IBOutlet UILabel *lblDay13;
@property (weak, nonatomic) IBOutlet UILabel *lblDay14;
@property (weak, nonatomic) IBOutlet UILabel *lblDay15;

@property (weak, nonatomic) IBOutlet FITButton *day1Button;
@property (weak, nonatomic) IBOutlet FITButton *day2Button;
@property (weak, nonatomic) IBOutlet FITButton *day3Button;
@property (weak, nonatomic) IBOutlet FITButton *day4Button;
@property (weak, nonatomic) IBOutlet FITButton *day5Button;
@property (weak, nonatomic) IBOutlet FITButton *day6Button;
@property (weak, nonatomic) IBOutlet FITButton *day7Button;
@property (weak, nonatomic) IBOutlet FITButton *day8Button;
@property (weak, nonatomic) IBOutlet FITButton *day9Button;
@property (weak, nonatomic) IBOutlet FITButton *day10Button;
@property (weak, nonatomic) IBOutlet FITButton *day11Button;
@property (weak, nonatomic) IBOutlet FITButton *day12Button;
@property (weak, nonatomic) IBOutlet FITButton *day13Button;
@property (weak, nonatomic) IBOutlet FITButton *day14Button;
@property (weak, nonatomic) IBOutlet FITButton *day15Button;

@property (weak, nonatomic) IBOutlet UIImageView *imageDay1;
@property (weak, nonatomic) IBOutlet UIImageView *imageDay2;
@property (weak, nonatomic) IBOutlet UIImageView *imageDay3;
@property (weak, nonatomic) IBOutlet UIImageView *imageDay4;
@property (weak, nonatomic) IBOutlet UIImageView *imageDay5;
@property (weak, nonatomic) IBOutlet UIImageView *imageDay6;
@property (weak, nonatomic) IBOutlet UIImageView *imageDay7;
@property (weak, nonatomic) IBOutlet UIImageView *imageDay8;
@property (weak, nonatomic) IBOutlet UIImageView *imageDay9;
@property (weak, nonatomic) IBOutlet UIImageView *imageDay10;
@property (weak, nonatomic) IBOutlet UIImageView *imageDay11;
@property (weak, nonatomic) IBOutlet UIImageView *imageDay12;
@property (weak, nonatomic) IBOutlet UIImageView *imageDay13;
@property (weak, nonatomic) IBOutlet UIImageView *imageDay14;
@property (weak, nonatomic) IBOutlet UIImageView *imageDay15;



@property (weak, nonatomic) IBOutlet UIImageView *tickImageDay1;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageDay2;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageDay3;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageDay4;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageDay5;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageDay6;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageDay7;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageDay8;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageDay9;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageDay10;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageDay11;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageDay12;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageDay13;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageDay14;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageDay15;



@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *tickImagesCollection;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageDaysCollection;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labelDaysCollection;
@property (strong, nonatomic) IBOutletCollection(FITButton) NSArray *buttonDaysCollection;



@property (weak, nonatomic) IBOutlet UIImageView *topShapes;

@property RLMResults *result;
@property bool isTwoMinutesDone;
@property bool isFiveMinutesDone;
@property bool isThirtyMinutesDone;
@property int day;
@property NSArray *exerciseParadigms;
@property NSArray *displayModeParadigms;
@property NSNumber *workoutDisplayMode;
@property NSMutableArray *properExercieNamesArray;
@property NSString *programName;


@end
