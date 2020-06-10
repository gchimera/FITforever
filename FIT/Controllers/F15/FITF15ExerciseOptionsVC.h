//
//  FITF15ExerciseOptionsVC.h
//  fitapp
//
//  Created by Hadi Roohian on 09/03/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FITBurgerMenu.h"
#import "Realm/Realm.h"
#import "Exercise.h"
#import "ProgramBaseViewController.h"

@interface FITF15ExerciseOptionsVC : ProgramBaseViewController
@property (weak, nonatomic) IBOutlet FITButton *warmUpBtn;
@property (weak, nonatomic) IBOutlet FITButton *workOutBtn;
@property (weak, nonatomic) IBOutlet FITButton *coolDownBtn;
@property (weak, nonatomic) IBOutlet UILabel *workOutBtnTitleLbl;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *topShapes;
- (IBAction)warmUpBtnTapped:(id)sender;
- (IBAction)workOutBtnTapped:(id)sender;
- (IBAction)coolDownBtnTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *tick1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tick2ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tick3ImageView;
@property NSString *exerciseName;
@property NSString *systemName;
@property NSNumber *workoutDisplayMode;
@property bool isCurrentDay;
@property (weak, nonatomic) IBOutlet UIImageView *tickImageCollection;

@end
