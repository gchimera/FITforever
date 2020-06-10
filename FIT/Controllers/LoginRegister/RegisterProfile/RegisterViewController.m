//
//  RegisterViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 12/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property UIAlertController *alertController;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    
    _scroll.scrollEnabled = FALSE;
    [_scroll layoutIfNeeded];
    
    [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_REGISTER_SECTION andKey:CONTENT_PAGE_TITLE_REGISTER_ACCOUNT]];
    
    [self languageAndButtonUIUpdate:self.nextButton buttonMode:3 inSection:CONTENT_REGISTER_SECTION forKey:CONTENT_BUTTON_NEXT backgroundColor:[THM C9Color]];
    
    [self.nameLabel setText:[self localisedStringForSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE andKey:CONTENT_LABEL_NAME]];
    [self.emailLabel setText:[self localisedStringForSection:CONTENT_REGISTER_SECTION andKey:CONTENT_LABEL_EMAIL_ADDRESS]];
    [self.passwordLabel setText:[self localisedStringForSection:CONTENT_REGISTER_SECTION andKey:CONTENT_LABEL_PASSWORD_REGISTER]];
    [self.confirmPasswordLabel setText:[self localisedStringForSection:CONTENT_REGISTER_SECTION andKey:CONTENT_LABEL_CONFIRM_PASSWORD]];
    
    [self.email setPlaceholder:[self localisedStringForSection:CONTENT_REGISTER_SECTION andKey:CONTENT_LABEL_EMAIL_ADDRESS]];
    [self.name setPlaceholder:[self localisedStringForSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE andKey:CONTENT_LABEL_NAME]];
    [self.password setPlaceholder:[self localisedStringForSection:CONTENT_REGISTER_SECTION andKey:CONTENT_LABEL_PASSWORD_REGISTER]];
    [self.confirmPassword setPlaceholder:[self localisedStringForSection:CONTENT_REGISTER_SECTION andKey:CONTENT_LABEL_CONFIRM_PASSWORD]];
    
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(didTapAnywhere:)];
    
    
    self.registrationProfileDetails = [[NSMutableDictionary alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerBtnTapped:(id)sender {
    
    //control here email and password valid
    if(!([self.email hasText] && [self.password hasText])) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
        self.alertController = [UIAlertController alertControllerWithTitle:@"" message:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_MANDATORY_DATA_MISSING] preferredStyle:UIAlertControllerStyleAlert];
        [self.alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {    }]];
            
            [self presentViewController:self.alertController animated:YES completion:nil];
        });
        
        return;
    } else if(!([[Utils sharedUtils] validateEmail:self.email.text])) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
        self.alertController = [UIAlertController alertControllerWithTitle:@"" message:[self localisedStringForSection:CONTENT_REGISTER_SECTION andKey:CONTENT_LABEL_INVALID_EMAIL] preferredStyle:UIAlertControllerStyleAlert];
        [self.alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {    }]];
            
            [self presentViewController:self.alertController animated:YES completion:nil];
        });
        return;
    } else if (![[Utils sharedUtils] validatePassword:self.password.text]){
        dispatch_async(dispatch_get_main_queue(), ^{
        self.alertController = [UIAlertController alertControllerWithTitle:@"" message:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_PASSWORD_POLICY_ERROR] preferredStyle:UIAlertControllerStyleAlert];
        [self.alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {    }]];
            
            [self presentViewController:self.alertController animated:YES completion:nil];
        });
        return;
    } else if (![self.password.text isEqualToString:self.confirmPassword.text]){
        
        dispatch_async(dispatch_get_main_queue(), ^{
        self.alertController = [UIAlertController alertControllerWithTitle:@"" message:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_PASSWORD_POLICY_ERROR] preferredStyle:UIAlertControllerStyleAlert];
        [self.alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {    }]];
            
            [self presentViewController:self.alertController animated:YES completion:nil];
        });

        return;
    }
    self.passwordSHA1 = [[Utils sharedUtils] generateSHA1WithString:self.password.text];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.name.text forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setObject:self.email.text forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setObject:self.passwordSHA1 forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[FITAPIManager sharedManager] checkEmail:self.email.text success:^(int *response) {
        
        if(response == MT_CODE_SUCCESS){
            [self switchToControllerInSameStoryBoard:AGE_GENDER_PROFILE inStoryboard:LOGIN_STORYBOARD];
        } else {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                
                NSString *noString = [self localisedStringForSection:CONTENT_FORGOTPASSWORD_SECTION andKey:CONTENT_BUTTON_OK];
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message:[self localisedStringForSection:CONTENT_REGISTER_SECTION andKey:CONTENT_LABEL_EMAIL_ALREADY_REGISTERED] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* cancelAction= [UIAlertAction actionWithTitle:noString style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){
                    [alert dismissViewControllerAnimated:YES completion:nil];
                }];
                
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            });
        }
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark KEYBOARD ACTION
- (void) keyboardWillShow:(NSNotification *) note {
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)didTapAnywhere: (UITapGestureRecognizer*) recognizer
{
    [_name resignFirstResponder];
    [_email resignFirstResponder];
    [_password resignFirstResponder];
    [_confirmPassword resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    _scroll.scrollEnabled = TRUE;
    _bottom.constant = 230;
    [_scroll setNeedsLayout];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [_scroll setContentOffset: CGPointMake(0, _scroll.frame.origin.x) animated:YES];
    _scroll.scrollEnabled = FALSE;
    [_scroll setNeedsLayout];
}

@end
