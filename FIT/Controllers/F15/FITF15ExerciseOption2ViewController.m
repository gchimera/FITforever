//
//  FITF15ExerciseOption2ViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 04/04/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "FITF15ExerciseOption2ViewController.h"
#import "FITWorkoutDetailsRLM.h"
#import "FITExerciseDetailsRLM.h"

@interface FITF15ExerciseOption2ViewController ()
@property RLMResults *result;

@end

@implementation FITF15ExerciseOption2ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    NSLog(@"%ld",(long)self.day);
    [self programImageUpdate:self.topShapes withImageName:@"topshapes"];
    [self programButtonUpdate:self.doneBtn buttonMode:3 inSection:CONTENT_FIT_F15_EXERCISE_SECTION forKey:CONTENT_BUTTON_CLOSE];
    
    
    [self loadDataFromRealmIntoRLMResults];
    [self displayeLoadedDataOnScreen];
    
    [self programLabelColor:self.titleLB];
    
}

-(void)loadDataFromRealmIntoRLMResults {
    self.workoutResults = [FITWorkoutDetailsRLM objectsWhere:[NSString stringWithFormat:@"systemName = '%@'",self.systemName]];
    NSLog(@"%@",self.workoutResults);
    self.exerciseResults = [FITExerciseDetailsRLM objectsWhere:[NSString stringWithFormat:@"systemName = '%@'",self.systemName]];
    NSLog(@"%@",self.exerciseResults);
    
    
}




-(void) displayeLoadedDataOnScreen {
    
    if([self.workoutResults count] > 0) {
        RLMObject *workoutObject = [self.workoutResults firstObject];
        
        self.titleLB.text = [workoutObject valueForKey:@"name"];
        
        NSError *err;
        NSString *descTextWithFont = [NSString stringWithFormat:@"<span style=\"font-family: HelveticaNeue; font-size: 12\">%@</span>", [workoutObject valueForKey:@"desc"]];
        
        NSMutableString *mutableStringWithExercises = [descTextWithFont mutableCopy];
        for (RLMObject *exercise in self.exerciseResults) {
            [mutableStringWithExercises appendString:[NSString stringWithFormat:@"%@<br />",[exercise valueForKey:@"name"]]];
        }
        
        
        
        self.descriptLB.attributedText = [[NSAttributedString alloc] initWithData: [mutableStringWithExercises dataUsingEncoding:NSUTF8StringEncoding] options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes: nil error: &err];
        
        
        
    }
}

#pragma mark - burger delegate

-(void)drawerToggle:(id)selectionIndex
{
    NSLog(@"FITNavDrawerSelection = %li", (long)selectionIndex);
    
}

- (IBAction)doneBtnTapped:(id)sender {
    
    if(self.isCurrentDay) {
        
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
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
