//
//  LoginEmailViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 08/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginEmailViewController : BaseViewController
{
    UITapGestureRecognizer *tapRecognizer;
}
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property NSString *passwordSHA1;
@property (weak, nonatomic) IBOutlet FITButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UIButton *registerAccountButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordButton;

#pragma mark KEYBOARD
-(void) keyboardWillHide:(NSNotification *) note;
- (void) keyboardWillShow:(NSNotification *) note;
-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer;

@end
