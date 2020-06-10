//
//  ForgetPasswordViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 08/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property UIAlertController *alertController;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:
     UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    
    _scroll.scrollEnabled = FALSE;
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(didTapAnywhere:)];
    
    [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_FORGOTPASSWORD_SECTION andKey:CONTENT_PAGE_TITLE_FORGOTTEN_PASSWORD]];
    
    [self languageAndButtonUIUpdate:self.nextBtn buttonMode:3 inSection:CONTENT_FORGOTPASSWORD_SECTION forKey:CONTENT_BUTTON_SEND backgroundColor:[THM C9Color]];
    
    [self.emailLabel setText:[self localisedStringForSection:CONTENT_FORGOTPASSWORD_SECTION andKey:CONTENT_LABEL_EMAIL_ADDRESS]];
    [self.forgetPasswordDescription setText:[self localisedStringForSection:CONTENT_FORGOTPASSWORD_SECTION andKey:CONTENT_LABEL_RESET_PASSWORD_INSTRUCTION]];
    
    [self.emailTxtField setPlaceholder:[self localisedStringForSection:CONTENT_FORGOTPASSWORD_SECTION andKey:CONTENT_LABEL_EMAIL_ADDRESS]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark KEYBOARD ACTION
- (void) keyboardWillShow:(NSNotification *) note {
    [self.view addGestureRecognizer:tapRecognizer];
    
    _scroll.scrollEnabled = TRUE;
    
    if (IS_IPHONE_5) {
        
        _bottom.constant = 200;
        
    }
    else if (IS_IPHONE_6){
        
        _bottom.constant = 210;
        
    }
}

- (void) keyboardWillHide:(NSNotification *) note
{
    [self.view removeGestureRecognizer:tapRecognizer];
}
- (void)didTapAnywhere: (UITapGestureRecognizer*) recognizer
{
    [_emailTxtField resignFirstResponder];
    
    _scroll.scrollEnabled = FALSE;
    
    // Autoscroll UIScrollview on the top
    [_scroll setContentOffset: CGPointMake(0, _scroll.contentInset.top) animated:YES];
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}


- (IBAction)sendButtonTapped:(id)sender
{
    if(!([_emailTxtField hasText]))
    {
        dispatch_async(dispatch_get_main_queue(), ^{
        
        self.alertController = [UIAlertController alertControllerWithTitle:@"" message:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_MANDATORY_DATA_MISSING] preferredStyle:UIAlertControllerStyleAlert];
        [self.alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {    }]];
            
            [self presentViewController:self.alertController animated:YES completion:nil];
        });
        return;
    } else if (!([[Utils sharedUtils] validateEmail:_emailTxtField.text])) {
        dispatch_async(dispatch_get_main_queue(), ^{
        
        self.alertController = [UIAlertController alertControllerWithTitle:@"" message:[self localisedStringForSection:CONTENT_REGISTER_SECTION andKey:CONTENT_LABEL_INVALID_EMAIL] preferredStyle:UIAlertControllerStyleAlert];
        [self.alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {    }]];
            
            [self presentViewController:self.alertController animated:YES completion:nil];
        });
        return;
    } else {
        [[FITAPIManager sharedManager]passwordResetUsingEmail:_emailTxtField.text success:^(int *status) {
            
            [self performSegueWithIdentifier:@"FITForgotPasswordSentVC" sender:nil];
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    
}

@end
