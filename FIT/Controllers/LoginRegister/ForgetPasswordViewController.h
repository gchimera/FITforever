//
//  ForgetPasswordViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 08/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseViewController.h"

@interface ForgetPasswordViewController : BaseViewController
{
    UITapGestureRecognizer *tapRecognizer;
}

@property (weak, nonatomic) IBOutlet FITButton *nextBtn;
@property (weak, nonatomic) IBOutlet UITextField *emailTxtField;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *forgetPasswordDescription;

- (IBAction)sendButtonTapped:(id)sender;

#pragma mark KEYBOARD
-(void) keyboardWillHide:(NSNotification *) note;
- (void) keyboardWillShow:(NSNotification *) note;
-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer;

@end
