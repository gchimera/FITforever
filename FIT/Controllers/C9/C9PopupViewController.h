//
//  C9PopupViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 04/04/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface C9PopupViewController : ProgramBaseViewController

@property NSString* sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *congratsLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet FITButton *LunchButton;

@property (weak, nonatomic) IBOutlet FITButton *dinnerButton;
@property (weak, nonatomic) IBOutlet FITButton *okButton;
@end
