//
//  FITF15ExerciseOption3.m
//  fitapp
//
//  Created by Hadi Roohian on 10/03/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import "FITF15ExerciseOption1.h"
#import "Realm/Realm.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "FITRecipes.h"
#import "UIImageView+WebCache.h"
//#import "Player.h"
#import "Exercise.h"
#import "FITWorkoutDetailsRLM.h"
#import "FITExerciseDetailsRLM.h"
#import "UIImageView+WebCache.h"

@interface FITF15ExerciseOption1 ()

@property NSString *partOfDay;
@property int day;
@property NSURL *videoURL;
@property RLMResults *result;

@end

@implementation FITF15ExerciseOption1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    NSLog(@"%ld",(long)self.day);
    
     [self programImageUpdate:self.topShapes withImageName:@"topshapes"];
    [self programButtonUpdate:self.doneBtn buttonMode:3 inSection:CONTENT_FIT_F15_EXERCISE_SECTION forKey:CONTENT_BUTTON_CLOSE];
    [self loadDataFromRealmIntoRLMResults];
    [self displayeLoadedDataOnScreen];
    
    
    //    UIImage *image1 = [UIImage imageNamed:@"play"];
    //
    //    // Round image
    //    _playBT.layer.cornerRadius = _playBT.frame.size.height/2;
    //    _playBT.layer.masksToBounds = YES;
    //
    //    _playBT.backgroundColor = [ UIColor colorWithPatternImage:image1];
    //    [_playBT setBackgroundImage:image1 forState:UIControlStateNormal];
    //    _playBT.backgroundColor = [UIColor colorWithRed:0.404 green:0.000 blue:0.522 alpha:1.00];

    
    [self programLabelColor:self.nameLbl];
    
}




-(void)loadDataFromRealmIntoRLMResults {
    if(self.warmUpCoolDownMode == 1) {
        self.systemName = @"f15-exercises-warm-up";
        self.navigationItem.title = @"Warm Up";
    } else if (self.warmUpCoolDownMode == 2) {
        self.systemName = @"f15-exercises-cool-down";
        self.navigationItem.title = @"Cool Down";
    }
    self.workoutResults = [FITWorkoutDetailsRLM objectsWhere:[NSString stringWithFormat:@"systemName = '%@'",self.systemName]];
    NSLog(@"%@",self.workoutResults);
    self.exerciseResults = [FITExerciseDetailsRLM objectsWhere:[NSString stringWithFormat:@"systemName = '%@'",self.systemName]];
    NSLog(@"%@",self.exerciseResults);
    
    
}




-(void) displayeLoadedDataOnScreen {
    
    if([self.workoutResults count] > 0) {
        RLMObject *workoutObject = [self.workoutResults firstObject];
        NSString *imageURLString = [workoutObject valueForKey:@"thumbnailImage"];
        [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:imageURLString] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        
        self.nameLbl.text = [workoutObject valueForKey:@"name"];
    
        NSError *err;
        NSString *descTextWithFont = [NSString stringWithFormat:@"<span style=\"font-family: HelveticaNeue; font-size: 12\">%@</span>", [workoutObject valueForKey:@"desc"]];
        
        NSMutableString *mutableStringWithExercises = [descTextWithFont mutableCopy];
        for (RLMObject *exercise in self.exerciseResults) {
            [mutableStringWithExercises appendString:[NSString stringWithFormat:@"%@<br />",[exercise valueForKey:@"name"]]];
        }
        
        [mutableStringWithExercises appendString:[NSString stringWithFormat:@"<br /><br /><br /><br />t"]];
        
        
    
        self.descLabel.attributedText = [[NSAttributedString alloc] initWithData: [mutableStringWithExercises dataUsingEncoding:NSUTF8StringEncoding] options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes: nil error: &err];
        
        
        
        if([workoutObject[@"workoutVideo"] hasPrefix:@"http"]){
            self.videoPlayBtn.hidden = NO;
            self.videoURL = [NSURL URLWithString:workoutObject[@"workoutVideo"]];
            
        } else {
            self.videoPlayBtn.hidden = YES;
        }

    }

}




-(UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}



- (IBAction)doneBtnTapped:(id)sender {

    if(self.isCurrentDay) {
        NSString *exerciseName;
        NSInteger exerciseType;
        if(self.warmUpCoolDownMode == 1) {
            exerciseName = @"warmUp";
            exerciseType = 1;
        } else if (self.warmUpCoolDownMode == 2) {
            exerciseName = @"coolDown";
            exerciseType = 2;
        } else {
            exerciseName = @"workOut";
            exerciseType = 3;
        }
        
        
        
        self.result = [Exercise objectsWhere:[NSString stringWithFormat:@"day = '%d' && exerciseName = '%@' && programID = '%@'",self.day, exerciseName, self.currentCourse.userProgramId]];
        if([self.result count]) {
            NSLog(@"No Insertion");
        } else {
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            [Exercise createOrUpdateInRealm:realm withValue:@{@"day": [NSString stringWithFormat:@"%d",self.day], @"exerciseName": exerciseName, @"exerciseType": [NSNumber numberWithInteger:exerciseType], @"programID": self.currentCourse.userProgramId, @"isSynced" : @NO}];
            
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




- (IBAction)playBtnTapped:(id)sender {
    
    [self performSegueWithIdentifier:@"gotoAVPlayer" sender:self];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[AVPlayerViewController class]] && [segue.identifier isEqualToString:@"gotoAVPlayer"])
    self.playerVC = segue.destinationViewController;
    NSLog(@"%@", self.videoURL);
    self.playerVC.player = [AVPlayer playerWithURL:self.videoURL];
    self.playerVC.showsPlaybackControls = YES;
    self.playerVC.view.frame = self.view.bounds;
    
    
}


@end
