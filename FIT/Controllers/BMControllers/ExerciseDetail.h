//
//  ExerciseDetail.h
//  FIT
//
//  Created by Guglielmo Chimera on 03/04/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//
#import "MenuBaseViewController.h"
#import <UIKit/UIKit.h>
#import "AVPlayerVC.h"

@interface ExerciseDetail : MenuBaseViewController

- (IBAction)doneBtnTapped:(id)sender;
@property (nonatomic, weak) AVPlayerVC *playerVC;
@property (weak, nonatomic) IBOutlet UILabel *mainWorkoutLB;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet FITButton *doneBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *ingredientsLbl;
@property NSString* descExercise;
@property NSString *videoURL;
@property NSString *imglink;
@property NSString *name;



@property long indexPassed;
@property bool isCustomMeal;



@property IBOutlet UIButton *videoPlayBtn;

@property NSString* mealSelected;
@property NSInteger courseMapNumber;
//@property NSString *foodDisplayMode;



@end
