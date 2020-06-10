//
//  C9FinalPopupViewController.h
//  FIT
//
//  Created by Hadi Roohian on 05/04/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface C9FinalPopupViewController : ProgramBaseViewController
@property (weak, nonatomic) IBOutlet FITButton *okButton;
- (IBAction)okButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleSection;
@property (weak, nonatomic) IBOutlet UILabel *firstText;
@property (weak, nonatomic) IBOutlet UILabel *secondText;

@end
