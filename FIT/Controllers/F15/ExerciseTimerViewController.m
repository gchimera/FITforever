//
//  ExerciseTimerViewController.m
//  FIT
//
//  Created by Hadi Roohian on 03/04/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ExerciseTimerViewController.h"

@interface ExerciseTimerViewController ()
@property RLMResults *result;
@property NSString *programID;
@property NSTimer *timer;
@property int remainingCounts;
@property int currentExerciseIndex;
@property int totalExerciseCount;
@property bool isExerciseDone;
@end

@implementation ExerciseTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self programImageUpdate:self.topShapes withImageName:@"topshapes"];
    [self programButtonUpdate:self.doneBtn buttonMode:3 inSection:@"" forKey:@""];

//    RLMResults *currentProgram = [Program objectsWhere:@"isCurrentProgram = YES"];
//    DLog(@"ProgramID === %@",[currentProgram objectAtIndex:0][@"ID"]);
//    _programID = [[NSString alloc] initWithString:[currentProgram objectAtIndex:0][@"ID"]];
//    self.day = (int)[[FITSettings sharedSettings] getCurrentDayWithStartDate:[currentProgram objectAtIndex:0][@"startDate"]];
//    DLog(@"%ld",(long)self.day);
    
    self.isExerciseDone = NO;
    self.currentExerciseIndex = 0;
    self.totalExerciseCount = (int)[self.exerciseDetails count] - 1;
    

}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [self updateTimerSettings];
    
}



#pragma mark - burger delegate

-(void)drawerToggle:(id)selectionIndex
{
    DLog(@"FITNavDrawerSelection = %li", (long)selectionIndex);
    
}

-(void)countDown {
    
    [UIView animateWithDuration:1 animations:^{
        self.timerBar.value -= 1;;
    } completion:^(BOOL finished) {
        
        
        
    }];
    
    if (self.remainingCounts-- == 0) {
        self.currentExerciseIndex++;
        if (self.totalExerciseCount < self.currentExerciseIndex) {
            self.timerBar.value = 0;
            self.timerBar.maxValue = 0;
            [self.timer invalidate];
            self.nextExerciseLbl.text = @"All rounds complete";
            self.currentExerciseLbl.text = @"";
            self.secondsLbl.text = @"Well Done";
            self.tickImg.hidden = NO;
            self.isExerciseDone = YES;
            [self.doneBtn setTitle:@"FINISH" forState:UIControlStateNormal];
        } else {
            [self updateTimerSettings];
        }
    }
    
}


- (void)updateTimerSettings {
    
    self.remainingCounts = [[[self.exerciseDetails objectAtIndex:self.currentExerciseIndex] valueForKey:@"exerciseTime"] intValue];
    self.currentExerciseLbl.text  = [[self.exerciseDetails objectAtIndex:self.currentExerciseIndex] valueForKey:@"exerciseName"];
    
    if(self.totalExerciseCount >= self.currentExerciseIndex) {
        if (self.totalExerciseCount == self.currentExerciseIndex) {
            self.nextExerciseLbl.text = @"";
            self.nextExerciseTimeLbl.text = @"";
        } else {
            self.nextExerciseLbl.text = [[self.exerciseDetails objectAtIndex:self.currentExerciseIndex + 1] valueForKey:@"exerciseName"];
            self.nextExerciseTimeLbl.text = [NSString stringWithFormat:@"%@ sec",[[self.exerciseDetails objectAtIndex:self.currentExerciseIndex + 1] valueForKey:@"exerciseTime"]];
        }
    }
    self.timerBar.maxValue = self.remainingCounts;
    self.timerBar.value = self.remainingCounts;
    
}


- (IBAction)doneBtnTapped:(UIButton *)sender {
    if (!(self.isExerciseDone)) {
        if (self.remainingCounts == [[[self.exerciseDetails objectAtIndex:self.currentExerciseIndex] valueForKey:@"exerciseTime"] intValue] || !(self.timer.isValid) ) {
            [self.doneBtn setTitle:@"PAUSE" forState:UIControlStateNormal];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        } else {
            [self.doneBtn setTitle:@"PLAY" forState:UIControlStateNormal];
            [self.timer invalidate];
            
        }
    } else {

            self.result = [Exercise objectsWhere:[NSString stringWithFormat:@"day = '%d' && exerciseName = 'workOut' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
            if([self.result count]) {
                NSLog(@"No Insertion");
            } else {
                RLMRealm *realm = [RLMRealm defaultRealm];
                [realm beginWriteTransaction];
                [Exercise createOrUpdateInRealm:realm withValue:@{@"day": [NSString stringWithFormat:@"%d",self.day], @"exerciseName": @"workOut", @"exerciseType": @3, @"programID": self.currentCourse.userProgramId, @"isSynced" : @NO}];
                
                [CourseDay createOrUpdateInRealm:realm     withValue:@{
                                                                       @"dayId":[NSString stringWithFormat:@"%@_%@",self.currentCourse.userProgramId,[NSString stringWithFormat:@"%d",self.day]],
                                                                       @"programID":[NSString stringWithFormat:@"%@",self.currentCourse.userProgramId],
                                                                       @"day" : [NSString stringWithFormat:@"%d",self.day],
                                                                       @"date": [NSDate date]
                                                                       }];
                [realm commitWriteTransaction];
                NSLog(@"inserted again into database");
            }
        [self.navigationController popViewControllerAnimated:YES];
        }
    
}
@end
