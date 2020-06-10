//
//  ForgetPasswordSuccessViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 12/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseViewController.h"

@interface ForgetPasswordSuccessViewController : BaseViewController
@property (weak, nonatomic) IBOutlet FITButton *letterBtn;
@property (weak, nonatomic) IBOutlet FITButton *okBtn;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
- (IBAction)okBtnTapped:(id)sender;

@end
