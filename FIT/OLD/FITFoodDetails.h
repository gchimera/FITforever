//
//  FITFoodDetails.h
//  fitapp
//
//  Created by Guglielmo Chimera on 09/01/17.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ProgramBaseViewController.h"
#import "AVPlayerVC.h"

@interface FITFoodDetails : ProgramBaseViewController
@property (weak, nonatomic) IBOutlet FITButton *doneBtn;
- (IBAction)doneBtnTapped:(id)sender;
@property (nonatomic, weak) AVPlayerVC *playerVC;
@property (weak, nonatomic) IBOutlet FITButton *caloriesHexBtn;

@property long indexPassed;
@property bool isCustomMeal;

@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *ingredientsSectionTitle;
@property IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *ingredientsLbl;

@property IBOutlet UIButton *videoPlayBtn;

@property NSString* mealSelected;
@property NSInteger courseMapNumber;
//@property NSString *foodDisplayMode;
//@property NSURL *videoURL;


- (IBAction)playBtnTapped:(id)sender;

@end
