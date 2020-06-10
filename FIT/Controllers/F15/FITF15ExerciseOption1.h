//
//  FITF15ExerciseOption3.h
//  fitapp
//
//  Created by Hadi Roohian on 10/03/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AVPlayerVC.h"
#import "ProgramBaseViewController.h"

@interface FITF15ExerciseOption1 : ProgramBaseViewController

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet FITButton *doneBtn;
- (IBAction)doneBtnTapped:(id)sender;
@property (nonatomic, weak) AVPlayerVC *playerVC;
@property (weak, nonatomic) IBOutlet UIImageView *topShapes;


@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property RLMResults *workoutResults;
@property RLMResults *exerciseResults;
@property NSString *systemName;
@property bool isCurrentDay;

@property IBOutlet UIButton *videoPlayBtn;
@property NSInteger warmUpCoolDownMode;

- (IBAction)playBtnTapped:(id)sender;

@end
