//
//  ProgramDashboardViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 09/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface ProgramDashboardViewController : ProgramBaseViewController

@property (weak, nonatomic) IBOutlet FITButton *checkList;
@property (weak, nonatomic) IBOutlet FITButton *progress;
@property (weak, nonatomic) IBOutlet FITButton *option1Button;
@property (weak, nonatomic) IBOutlet FITButton *option2Button;
@property (weak, nonatomic) IBOutlet FITButton *option3Button;
@property (weak, nonatomic) IBOutlet FITButton *option4Button;
@property (weak, nonatomic) IBOutlet FITButton *option5Button;
@property (weak, nonatomic) IBOutlet FITButton *option6Button;
@property (weak, nonatomic) IBOutlet UIImageView *programImage;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
- (IBAction)blockBotoomMenuButtonTapped:(id)sender;

@property (strong, nonatomic) IBOutletCollection(FITButton) NSArray *mealsMainButtons;

- (IBAction)foodBtnTapped:(id)sender;
- (IBAction)freeFoodsBtnTapped:(id)sender;
- (IBAction)progressBtnTapped:(id)sender;


@end
