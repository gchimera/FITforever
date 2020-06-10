//
//  FITF15ExerciseOption2.m
//  fitapp
//
//  Created by Hadi Roohian on 10/03/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import "FITF15ExerciseOption3.h"
#import "FITWorkoutDetailsRLM.h"
#import "FITExerciseDetailsRLM.h"
#import "ExerciseTimerCell.h"
#import "ExerciseTimerViewController.h"





//#import "ExerciseTimeCell.h"
//#import "FITF15ExerciseTimerVC.h"

@interface FITF15ExerciseOption3 ()
@property RLMResults *result;
@property RLMResults *workoutResults;
@property RLMResults *exerciseResults;
@property NSMutableArray *exercisesDetails;
@end

@implementation FITF15ExerciseOption3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    NSLog(@"%ld",(long)self.day);
    [self programImageUpdate:self.topShapes withImageName:@"topshapes"];
    [self programButtonUpdate:self.startWorkoutBtn buttonMode:3 inSection:CONTENT_FIT_F15_EXERCISE_SECTION forKey:CONTENT_BUTTON_START_WORKOUT];
    
    NSLog(@"%@",self.exerciseName);
    NSLog(@"%@",self.systemName);
    [self loadExercisesFromRealm];
    
    [self programLabelColor:self.titleLbl];

    
}


- (void)loadExercisesFromRealm {
    self.workoutResults = [FITWorkoutDetailsRLM objectsWhere:[NSString stringWithFormat:@"systemName = '%@'",self.systemName]];
    NSLog(@"%@",self.workoutResults);
    self.exerciseResults = [FITExerciseDetailsRLM objectsWhere:[NSString stringWithFormat:@"systemName = '%@'",self.systemName]];
    NSLog(@"%@",self.exerciseResults);
    
    
    RLMObject *workoutObject = [self.workoutResults firstObject];
    self.titleLbl.text = workoutObject[@"name"];
    
    
    
    NSError *err;
    NSString *descTextWithFont = [NSString stringWithFormat:@"<span style=\"font-family: HelveticaNeue; font-size: 12\">%@</span>", [workoutObject valueForKey:@"desc"]];
    
    NSMutableString *mutableStringWithExercises = [descTextWithFont mutableCopy];

    
    
    
    self.exercisesDetails = [[NSMutableArray alloc] init];
        for (RLMObject *exercise in self.exerciseResults) {
//            [mutableStringWithExercises appendString:[NSString stringWithFormat:@"%@<br />",[exercise valueForKey:@"name"]]];
            [self.exercisesDetails addObject:@{@"exerciseName" : exercise[@"exerciseName"], @"exerciseTime" : exercise[@"duration"]}];
        }

    
    self.descLbl.attributedText = [[NSAttributedString alloc] initWithData: [mutableStringWithExercises dataUsingEncoding:NSUTF8StringEncoding] options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes: nil error: &err];
  
}



#pragma mark - burger delegate

-(void)drawerToggle:(id)selectionIndex
{
    NSLog(@"FITNavDrawerSelection = %li", (long)selectionIndex);
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.exercisesDetails count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExerciseTimerCell *timerCell = [tableView dequeueReusableCellWithIdentifier:@"timerCell"];
    timerCell.exerciseTitleLbl.text = self.exercisesDetails[indexPath.row][@"exerciseName"];
    timerCell.exercieTimeLbl.text = [NSString stringWithFormat:@"%@ Sec",self.exercisesDetails[indexPath.row][@"exerciseTime"]];
    return  timerCell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 32.0;
}


- (IBAction)startWorkoutBtnTapped:(UIButton *)sender {
    
    if(self.isCurrentDay) {
        ExerciseTimerViewController *exerciseTimerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ExerciseTimerViewController"];
        exerciseTimerVC.exerciseDetails = self.exercisesDetails;
        exerciseTimerVC.isCurrentDay = self.isCurrentDay;
        [self.navigationController pushViewController:exerciseTimerVC animated:YES];
    } else {
        NSLog(@"User is trying to start a future workout");
        [[Utils sharedUtils] showAlertViewWithMessage:@"Future workout cannot be started" buttonTitle:@"OK"];
    }
 
}
@end
