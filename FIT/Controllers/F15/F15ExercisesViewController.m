//
//  F15ExercisesViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 16/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "F15ExercisesViewController.h"
#import "FITExerciseDetailsRLM.h"
#import "FITWorkoutDetailsRLM.h"
#import "FITF15ExerciseOptionsVC.h"
#import "Exercise.h"


@interface F15ExercisesViewController()
@property NSMutableArray *systemNames;
@property long labelsIndex;

@end

@implementation F15ExercisesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUIContent];
    
}

-(void) loadUIContent {
//    [self.navigationItem.title = [self localisedStringForSection:@"" andKey:@""]];
    
    [self programImageUpdate:self.topShapes withImageName:@"topshapes"];
    _programName = self.currentCourse.programName;
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    
    UIColor *todayColor;
    UIColor *previousDayColor;
    switch ([self.currentCourse.courseType integerValue]) {
        case C9:
            todayColor = [THM C9Color];
            break;
        case F15Begginner1:
            todayColor = [THM F15BeginnerColorWithSixtyPercentAlpha];
            previousDayColor = [THM F15BeginnerColorWithThirtyPercentAlpha];
            break;
        case F15Begginner2:
            todayColor = [THM F15BeginnerColorWithSixtyPercentAlpha];
            previousDayColor = [THM F15BeginnerColorWithThirtyPercentAlpha];
            break;
        case F15Intermidiate1:
            todayColor = [THM F15IntermidiateColorWithSixtyPercentAlpha];
            previousDayColor = [THM F15IntermidiateColorWithThirtyPercentAlpha];
            break;
        case F15Intermidiate2:
            todayColor = [THM F15IntermidiateColorWithSixtyPercentAlpha];
            previousDayColor = [THM F15IntermidiateColorWithThirtyPercentAlpha];
            break;
        case F15Advance1:
            todayColor = [THM F15AdvanceColorWithSixtyPercentAlpha];
            previousDayColor = [THM F15AdvanceColorWithThirtyPercentAlpha];
            break;
        case F15Advance2:
            todayColor = [THM F15AdvanceColorWithSixtyPercentAlpha];
            previousDayColor = [THM F15AdvanceColorWithThirtyPercentAlpha];
            break;
            
        default:
            break;
    }
    
    
    for(FITButton *dayButton in self.buttonDaysCollection) {
        if (dayButton.tag == self.day) {
            [self programButtonUpdate:dayButton buttonMode:1 inSection:@"" forKey:@"" withColor:todayColor];
        } else if(dayButton.tag < self.day) {
            [self programButtonUpdate:dayButton buttonMode:1 inSection:@"" forKey:@"" withColor:previousDayColor];
        } else {
            [self programButtonUpdate:dayButton buttonMode:1 inSection:@"" forKey:@"" withColor:[THM BMColor]];
        }
    }
    
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    DLog(@"%ld",(long)self.day);
    
    for (UIImageView *img in self.imageDaysCollection) {
        img.hidden = YES;
    }
    RLMResults *exerciseResults;
    for (int i = 0; i < self.day; i++) {
        exerciseResults= [Exercise objectsWhere:[NSString stringWithFormat:@"day = '%d' && programID = '%@'",i + 1, self.currentCourse.userProgramId]];
        if([exerciseResults count] == 3) {
            for (UIImageView *tickImage in self.tickImagesCollection) {
                if(tickImage.tag == i + 1) {
                    tickImage.alpha = 1;
                }
            }
        }
    }
    self.exerciseParadigms = @[
                               @[@"f15-beginner-workout-one",
                                 @"f15-beginner-cardio",
                                 @"rest",
                                 @"f15-beginner-workout-two",
                                 @"rest",
                                 @"f15-beginner-cardio",
                                 @"rest",
                                 @"f15-beginner-workout-one",
                                 @"f15-beginner-cardio",
                                 @"rest",
                                 @"f15-beginner-workout-two",
                                 @"rest",
                                 @"f15-beginner-workout-three",
                                 @"f15-beginner-cardio",
                                 @"rest"
                                 ],
                               @[@"f15-beginner-workout-four",
                                 @"f15-beginner-no-equipment-cardio",
                                 @"rest",
                                 @"f15-beginner-workout-five",
                                 @"f15-beginner-interval-cardio-intensity",
                                 @"rest",
                                 @"f15-beginner-workout-six",
                                 @"f15-beginner-no-equipment-cardio",
                                 @"rest",
                                 @"f15-beginner-workout-four",
                                 @"f15-beginner-interval-cardio-intensity",
                                 @"rest",
                                 @"f15-beginner-workout-five",
                                 @"rest",
                                 @"f15-beginner-workout-six"
                                 ],
                               @[@"f15-intermediate-workout-one",
                                 @"f15-intermediate-1-cardio",
                                 @"rest",
                                 @"f15-intermediate-workout-two",
                                 @"f15-intermediate-1-interval-cardio",
                                 @"rest",
                                 @"f15-intermediate-yoga-one",
                                 @"f15-intermediate-1-cardio",
                                 @"rest",
                                 @"f15-intermediate-workout-one",
                                 @"f15-intermediate-1-interval-cardio",
                                 @"rest",
                                 @"f15-intermediate-workout-two",
                                 @"rest",
                                 @"f15-intermediate-yoga-one"
                                 ],
                               @[@"f15-intermediate-workout-three",
                                 @"f15-intermediate-1-cardio",
                                 @"f15-intermediate-workout-four",
                                 @"f15-intermediate-hiit-cardio-mix",
                                 @"rest",
                                 @"f15-intermediate-yoga-two",
                                 @"f15-intermediate-hiit-strength-cardio",
                                 @"f15-intermediate-workout-three",
                                 @"f15-intermediate-1-cardio",
                                 @"rest",
                                 @"f15-intermediate-workout-four",
                                 @"f15-intermediate-hiit-cardio-mix",
                                 @"f15-intermediate-yoga-two",
                                 @"f15-intermediate-hiit-strength-cardio",
                                 @"rest"
                                 ],
                               @[@"f15-advanced--backside-workout-one",
                                 @"f15-advanced-tabata-cardio-one",
                                 @"f15-advanced-front-and-sideline-workout-one",
                                 @"rest",
                                 @"f15-advanced-treadmill-cardio-one",
                                 @"f15-advanced-quads-and-core-workout-one",
                                 @"f15-advanced-1-choice-cardio",
                                 @"rest",
                                 @"f15-advanced--backside-workout-one",
                                 @"f15-advanced-tabata-cardio-one",
                                 @"f15-advanced-front-and-sideline-workout-one",
                                 @"rest",
                                 @"f15-advanced-treadmill-cardio-one",
                                 @"f15-advanced-quads-and-core-workout-one",
                                 @"f15-advanced-1-choice-cardio"
                                 ],
                               @[@"f15-advanced-backside-workout-two",
                                 @"f15-advanced-tabata-cardio-two",
                                 @"f15-advanced-front-and-sideline--workout--two",
                                 @"rest",
                                 @"f15-advanced-treadmill--cardio--two",
                                 @"f15-advanced-quads-and-core--workout--two",
                                 @"f15-advanced-1-choice-cardio",
                                 @"rest",
                                 @"f15-advanced-backside-workout-two",
                                 @"f15-advanced-tabata-cardio-two",
                                 @"f15-advanced-front-and-sideline--workout--two",
                                 @"rest",
                                 @"f15-advanced-treadmill--cardio--two",
                                 @"f15-advanced-quads-and-core--workout--two",
                                 @"f15-advanced-1-choice-cardio"
                                 ],
                               
                               
                               ];
    
    self.displayModeParadigms = @[
                                  @[@1,@2,@0,@1,@0,@2,@0,@1,@2,@0,@1,@0,@1,@2,@0],
                                  @[@1,@3,@0,@1,@3,@0,@1,@3,@0,@1,@3,@0,@1,@0,@1],
                                  @[@1,@2,@0,@1,@2,@0,@1,@2,@0,@1,@2,@0,@1,@0,@1],
                                  @[@1,@2,@1,@3,@0,@1,@3,@1,@2,@0,@1,@3,@1,@3,@0],
                                  @[@1,@3,@1,@0,@1,@1,@2,@0,@1,@3,@1,@0,@3,@1,@2],
                                  @[@1,@3,@1,@0,@3,@1,@2,@0,@1,@3,@1,@0,@3,@1,@2]
                                  ];
    
    
    
    if([self.programName isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER1]) {
        self.labelsIndex = 0;
    } else if([self.programName isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER2]) {
        self.labelsIndex = 1;
    } else if([self.programName isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE1]) {
        self.labelsIndex = 2;
    } else if([self.programName isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE2]) {
        self.labelsIndex = 3;
    } else if([self.programName isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED1]) {
        self.labelsIndex = 4;
    } else if([self.programName isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED2]) {
        self.labelsIndex = 5;
    }
    
    self.properExercieNamesArray = [[NSMutableArray alloc] init];
    self.systemNames = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [self.exerciseParadigms[self.labelsIndex] count]; i++) {
        NSString *systemName = self.exerciseParadigms[self.labelsIndex][i];
        [self.systemNames addObject:systemName];
        RLMResults *exerciseResult = [FITWorkoutDetailsRLM objectsWhere:[NSString stringWithFormat:@"systemName = '%@'", systemName]];
        
        
        if ([exerciseResult count] > 0) {
            
            if([[exerciseResult firstObject][@"sectionName"] containsString:@"F15 "] || [[exerciseResult firstObject][@"sectionName"] containsString:@"F15"] || [[exerciseResult firstObject][@"sectionName"] containsString:@"Advanced "] || [[exerciseResult firstObject][@"sectionName"] containsString:@"Beginnner "] || [[exerciseResult firstObject][@"sectionName"] containsString:@"Intermediate "]) {
                [self.properExercieNamesArray addObject:[[[[[[[[exerciseResult firstObject] [@"sectionName"] lowercaseString] stringByReplacingOccurrencesOfString:@"f15" withString:@""] stringByReplacingOccurrencesOfString:@"advanced " withString:@""] stringByReplacingOccurrencesOfString:@"beginner " withString:@""] stringByReplacingOccurrencesOfString:@"intermediate " withString:@""] lowercaseString] capitalizedString]];
            } else {
                [self.properExercieNamesArray addObject:[exerciseResult firstObject][@"sectionName"]];
            }
        } else {
            [self.properExercieNamesArray addObject:@"Rest"];
            for (UIImageView *image in self.imageDaysCollection) {
                if(image.tag == i + 1) {
                    [image setImage:[UIImage imageNamed:@"resticon"]];
                    image.hidden = NO;
                }
            }
        }
        
        
        if(!([[self.properExercieNamesArray[i] lowercaseString] rangeOfString:@"cardio"].location == NSNotFound)) {
            
            for (UIImageView *image in self.imageDaysCollection) {
                if(image.tag == i + 1) {
                    [image setImage:[UIImage imageNamed:@"cardioicon"]];
                    image.hidden = NO;
                }
            }
            
        } else if(!([[self.properExercieNamesArray[i] lowercaseString] rangeOfString:@"yoga"].location == NSNotFound)) {
            
            for (UIImageView *image in self.imageDaysCollection) {
                if(image.tag == i + 1) {
                    [image setImage:[UIImage imageNamed:@"yogamaster"]];
                    image.hidden = NO;
                }
            }
            
        }
        
        
        for (UIView *lbl in self.view.subviews){
            
            if ([lbl isKindOfClass:[UILabel class]]) {
                
                UILabel *label = (UILabel *)lbl;
                if (label.tag == i + 1)
                {
                    label.text = self.properExercieNamesArray[i];
                }
            }
        }
        
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadUIContent];
}

- (IBAction)exerciseDayBtnTapped:(FITButton *)sender {
    
    self.workoutDisplayMode = self.displayModeParadigms[self.labelsIndex][sender.tag - 1];
    if([self.workoutDisplayMode intValue] == 0) {
        //TODO: Hadi IMPLEMENT REST BUTTON TAPPED LOGIC HERE
        DLog(@"You Tapped On Rest Btn");
        
        if(self.day == sender.tag) {
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            
            [Exercise createOrUpdateInRealm:realm withValue:@{@"day": [NSString stringWithFormat:@"%d",self.day], @"exerciseName": @"rest", @"exerciseType": @0, @"programID": self.currentCourse.userProgramId , @"isSynced" : @NO}];
            
            [CourseDay createOrUpdateInRealm:realm     withValue:@{
                                                                   @"dayId":[NSString stringWithFormat:@"%@_%@",self.currentCourse.userProgramId,[NSString stringWithFormat:@"%d",self.day]],
                                                                   @"programID":[NSString stringWithFormat:@"%@",self.currentCourse.userProgramId],
                                                                   @"day" : [NSString stringWithFormat:@"%d",self.day],
                                                                   @"date": [NSDate date]
                                                                   }];
            
            [realm commitWriteTransaction];
            [UIView animateWithDuration:1 animations:^{
                for (UILabel *dayLabel in self.labelDaysCollection) {
                    if(dayLabel.tag == sender.tag) {
                        dayLabel.alpha = 0;
                    }
                }
                
                for (UIImageView *dayImageIcon in self.imageDaysCollection) {
                    if(dayImageIcon.tag == sender.tag) {
                        dayImageIcon.alpha = 0;
                    }
                }
                
                for (FITButton *dayButton in self.buttonDaysCollection) {
                    if(dayButton.tag == sender.tag) {
                        dayButton.userInteractionEnabled = NO;
                    }
                }
                
                
                for (UIImageView *tickImage in self.tickImagesCollection) {
                    if(tickImage.tag == sender.tag) {
                        tickImage.alpha = 1;
                    }
                }
            }];
        }
    
        
        
    } else {
        [self performSegueWithIdentifier:@"gotoExercieOptions" sender:sender];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(FITButton *)sender {
    
    if ([segue.identifier isEqualToString:@"gotoExercieOptions"]) {
        FITF15ExerciseOptionsVC *exerciseOptionsVC = [segue destinationViewController];
        DLog(@"%@",sender.titleLabel.text);
        
        if(self.day == sender.tag) {
            exerciseOptionsVC.isCurrentDay = YES;
        } else {
            exerciseOptionsVC.isCurrentDay = NO;
        }
            for (UIView *lbl in self.view.subviews){
        
                if ([lbl isKindOfClass:[UILabel class]]) {
                    
                    UILabel *label = (UILabel *)lbl;
                    if (label.tag == sender.tag)
                    {
                        exerciseOptionsVC.exerciseName = label.text;
                        exerciseOptionsVC.systemName = self.systemNames[sender.tag - 1];
                        exerciseOptionsVC.workoutDisplayMode = self.workoutDisplayMode;
                    }
                }
            }
    }
}

@end
