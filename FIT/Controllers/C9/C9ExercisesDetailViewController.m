//
//  C9ExcercisesDetailViewController.m
//  FIT
//
//  Created by Bruce Cresanta on 3/17/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C9ExercisesDetailViewController.h"
#import "FITWorkoutDetailsRLM.h"
#import "Exercise.h"

@implementation C9ExercisesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    DLog(@"%ld",(long)self.day);
    
    [self programButtonUpdate:self.doneBtn buttonMode:3 inSection:CONTENT_FIT_C9_WATER_INTAKE_SECTION forKey:CONTENT_BUTTON_DONE];
    
    
    //    self.day = 4;
    RLMResults *exerciseResults;
    
    switch (self.day) {
            
        case 1 ... 2: {
            
            exerciseResults = [FITWorkoutDetailsRLM objectsWhere:[NSString stringWithFormat:@"systemName == 'fit-exercise-c9-days-1-2'"]];
            
            _titleLB.text = [[exerciseResults firstObject] valueForKey:@"sectionName"];
            
            NSError *err = nil;
            
            _descriptLB.attributedText =
            [[NSAttributedString alloc]
             initWithData: [[[exerciseResults firstObject] valueForKey:@"desc"] dataUsingEncoding:NSUTF8StringEncoding]
             options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
             documentAttributes: nil
             error: &err];
            _descriptLB.textColor = [UIColor colorWithRed:0.404 green:0.000 blue:0.522 alpha:1.00];
            
        }
            break;
            
        case 3 ... 9: {
            
//            exerciseResults = [FITWorkoutDetailsRLM objectsWhere:[NSString stringWithFormat:@"systemName == 'fit-exercise-c9-days-3-9'"]];
            
            
            if ([exerciseResults count] > 0) {
                
                _titleLB.text = [[exerciseResults firstObject] valueForKey:@"sectionName"];
                
                NSError *err = nil;
                
                
                
                _descriptLB.attributedText =
                [[NSAttributedString alloc]
                 initWithData: [[[exerciseResults firstObject] valueForKey:@"desc"] dataUsingEncoding:NSUTF8StringEncoding]
                 options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                 documentAttributes: nil
                 error: &err];
                
                _descriptLB.textColor = [UIColor colorWithRed:0.404 green:0.000 blue:0.522 alpha:1.00];
                
                
            }
            break;
        }
            
            
            
        default:
            DLog(@"Day property is out of range !!!!!!!");
            break;
    }
    
//    [self updateUI:self.doneBtn buttonMode:3];
}
- (IBAction)doneBtnTapped:(id)sender {
    self.result = [Exercise objectsWhere:[NSString stringWithFormat:@"day = '%d' && exerciseName = 'thirtyMinutes' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
    if([self.result count]) {
        DLog(@"No Insertion");
    } else {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [Exercise createOrUpdateInRealm:realm withValue:@{@"day": [NSString stringWithFormat:@"%d",self.day], @"exerciseName": @"thirtyMinutes", @"programID": self.currentCourse.userProgramId, @"exerciseType" : @2, @"isSynced" : @NO}];
        
        [CourseDay createOrUpdateInRealm:realm     withValue:@{
                                                                @"dayId":[NSString stringWithFormat:@"%@_%@",self.currentCourse.userProgramId,[NSString stringWithFormat:@"%d",self.day]],
                                                                @"programID":[NSString stringWithFormat:@"%@",self.currentCourse.userProgramId],
                                                                @"day" : [NSString stringWithFormat:@"%d",self.day],
                                                                @"date": [NSDate date]
                                                                }];
        
        [realm commitWriteTransaction];
        DLog(@"inserted again into database");
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end

