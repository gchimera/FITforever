//
//  FITF15ExerciseOptionsVC.m
//  fitapp
//
//  Created by Hadi Roohian on 09/03/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import "FITF15ExerciseOptionsVC.h"
#import "FITF15ExerciseOption3.h"
#import "FITF15ExerciseOption2ViewController.h"
#import "FITF15ExerciseOption1.h"

@interface FITF15ExerciseOptionsVC ()
@property RLMResults *result;
@property bool isTwoMinutesDone;
@property bool isFiveMinutesDone;
@property bool isThirtyMinutesDone;
@property int day;
@end

@implementation FITF15ExerciseOptionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    NSLog(@"%ld",(long)self.day);
    
    
    
    
    [self programImageUpdate:self.topShapes withImageName:@"topshapes"];
    [self programButtonUpdate:self.warmUpBtn buttonMode:1 inSection:CONTENT_F15_EXERCISES_SECTION forKey:CONTENT_WARMUP_BUTTON withColor:[THM BMColor]];
    [self programButtonUpdate:self.coolDownBtn buttonMode:1 inSection:CONTENT_F15_EXERCISES_SECTION forKey:CONTENT_CARDIO_BUTTON withColor:[THM BMColor]];
    [self programButtonUpdate:self.workOutBtn buttonMode:1 inSection:@"" forKey:@"" withColor:[THM BMColor]];
    
    self.workOutBtnTitleLbl.text = [self.exerciseName uppercaseString];
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if(self.isCurrentDay) {
        
        RLMResults *exerciseResults;
        exerciseResults= [Exercise objectsWhere:[NSString stringWithFormat:@"day = '%d' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
        
        for (RLMObject *exercise in exerciseResults) {
            if([exercise[@"exerciseName"] isEqualToString:@"warmUp"]) {
                self.tick1ImageView.alpha = 1;
                [self programButtonUpdate:self.warmUpBtn buttonMode:1 inSection:CONTENT_F15_EXERCISES_SECTION forKey:CONTENT_WARMUP_BUTTON withColor:[self programColor]];
                
            } else if([exercise[@"exerciseName"] isEqualToString:@"coolDown"]) {
                [self programButtonUpdate:self.coolDownBtn buttonMode:1 inSection:CONTENT_F15_EXERCISES_SECTION forKey:CONTENT_CARDIO_BUTTON withColor:[self programColor]];
                
                self.tick3ImageView.alpha = 1;
            } else if([exercise[@"exerciseName"] isEqualToString:@"workOut"]) {
                [self programButtonUpdate:self.workOutBtn buttonMode:1 inSection:@"" forKey:@"" withColor:[self programColor]];
                
                self.tick2ImageView.alpha = 1;
            }
            
        }
    }
    
}



- (void)loadCurrentFinishedExercises {
    self.result = [Exercise objectsWhere:[NSString stringWithFormat:@"day = '%d' && exerciseName = 'warmUp' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
    if([self.result count]) {
        self.isTwoMinutesDone = YES;
    }
    
    self.result = [Exercise objectsWhere:[NSString stringWithFormat:@"day = '%d' && exerciseName = 'workout' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
    if([self.result count]) {
        self.isFiveMinutesDone = YES;
    }
    
    self.result = [Exercise objectsWhere:[NSString stringWithFormat:@"day = '%d' && exerciseName = 'coolDown' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
    if([self.result count]) {
        self.isThirtyMinutesDone = YES;
    }
    
    
    if(_isTwoMinutesDone) {
        
        [self.warmUpBtn setUserInteractionEnabled:NO];
        self.warmUpBtn.titleLabel.alpha = 0.2;
        [self programButtonUpdate:self.warmUpBtn buttonMode:1 inSection:@"" forKey:@""];
        
        [UIView animateWithDuration:1 animations:^{
            
            self.tick1ImageView.alpha = 1;
        }];
        
    }
    
    if(_isFiveMinutesDone) {
        
        [self.workOutBtn setUserInteractionEnabled:NO];
        self.workOutBtn.titleLabel.alpha = 0.2;
        [self programButtonUpdate:self.workOutBtn buttonMode:1 inSection:@"" forKey:@""];
        
        [UIView animateWithDuration:1 animations:^{
            
            self.tick2ImageView.alpha = 1;
        }];
        
    }
    
    if(_isThirtyMinutesDone) {
        
        [self.coolDownBtn setUserInteractionEnabled:YES];
        self.coolDownBtn.titleLabel.alpha = 0.2;
        [self programButtonUpdate:self.coolDownBtn buttonMode:1 inSection:@"" forKey:@""];
        
        
        [UIView animateWithDuration:1 animations:^{
            
            self.tick3ImageView.alpha = 1;
        }];
        
    }
    
    
}


- (IBAction)workOutBtnTapped:(id)sender {
    
    if([self.workoutDisplayMode intValue] == 1) {
        
        FITF15ExerciseOption1 *exerciseOption1 = [self.storyboard instantiateViewControllerWithIdentifier:@"FITF15ExerciseOption1"];
        exerciseOption1.systemName = self.systemName;
        exerciseOption1.isCurrentDay = self.isCurrentDay;
        [self.navigationController pushViewController:exerciseOption1 animated:YES];
    } else if([self.workoutDisplayMode intValue] == 2) {
        
        FITF15ExerciseOption2ViewController *exerciseOption2 = [self.storyboard instantiateViewControllerWithIdentifier:@"FITF15ExerciseOption2"];
        exerciseOption2.systemName = self.systemName;
        exerciseOption2.isCurrentDay = self.isCurrentDay;
        [self.navigationController pushViewController:exerciseOption2 animated:YES];
    } else if([self.workoutDisplayMode intValue] == 3) {
        
        FITF15ExerciseOption3 *exerciseOption3 = [self.storyboard instantiateViewControllerWithIdentifier:@"FITF15ExerciseOption3"];
        exerciseOption3.systemName = self.systemName;
        exerciseOption3.exerciseName = self.exerciseName;
        exerciseOption3.isCurrentDay = self.isCurrentDay;
        [self.navigationController pushViewController:exerciseOption3 animated:YES];
    }
}


- (IBAction)warmUpBtnTapped:(id)sender {
    
    FITF15ExerciseOption1 *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FITF15ExerciseOption1"];
    vc.warmUpCoolDownMode = 1;
    vc.isCurrentDay = self.isCurrentDay;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (IBAction)coolDownBtnTapped:(id)sender {
    
    FITF15ExerciseOption1 *exerciseOption1 = [self.storyboard instantiateViewControllerWithIdentifier:@"FITF15ExerciseOption1"];
    exerciseOption1.warmUpCoolDownMode = 2;
    exerciseOption1.isCurrentDay = self.isCurrentDay;
    [self.navigationController pushViewController:exerciseOption1 animated:YES];
    
}
@end
