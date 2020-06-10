//
//  LoginEmailViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 08/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "LoginEmailViewController.h"
#import "Dashboard.h"

@interface LoginEmailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property UIAlertController *alertController;

@end

@implementation LoginEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *userLoged = [User userInDB];
    if(userLoged != nil){
        if(userLoged.isProfileCompleted){ // user profile is completed :) go to dashboard
            [self takeUserToDashBoard];
        } else { // profile need to complete go to create profile
            [self takeUserToProfileRegistration];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _scroll.scrollEnabled = FALSE;
    [_scroll layoutIfNeeded];
    
    [self loadContentUI];
}

- (void) loadContentUI{
    
    self.navigationController.navigationBar.barTintColor = [THM C9Color];
    
    [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_PAGE_TITLE_LOGIN]];
    self.navigationController.navigationBar.tintColor = [THM WhiteColor];
    
    [self languageAndButtonUIUpdate:self.loginBtn buttonMode:3 inSection:CONTENT_LOGIN_EMAIL_SECTION forKey:CONTENT_BUTTON_LOGIN backgroundColor:[THM C9Color]];
    
    [self.forgetPasswordButton setTitle:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_FORGOTTEN_PASSWORD] forState:UIControlStateNormal];
    [self.registerAccountButton setTitle:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_REGISTER_ACCOUNT] forState:UIControlStateNormal];
    
    [self.emailLabel setText:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_EMAIL_ADDRESS]];
    [self.passwordLabel setText:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_PASSWORD]];
    
    [self.email setPlaceholder:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_EMAIL_ADDRESS]];
    [self.password setPlaceholder:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_PASSWORD]];
    
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    
    [notification addObserver:self selector:@selector(keyboardWillShow:) name: UIKeyboardWillShowNotification object:nil];
    [notification addObserver:self selector:@selector(keyboardWillHide:) name: UIKeyboardWillHideNotification object:nil];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
}

- (void) takeUserToDashBoard {
    [[FITAPIManager sharedManager] userProgramsWithSuccess:^(NSDictionary *programs) {} failure:^(NSError *error) {}];
    
    [[FITAPIManager sharedManager] userRecipes:@{} success:^(NSDictionary *programs) {} failure:^(NSError *error) {}];
    
    Dashboard *dashboard = [[UIStoryboard storyboardWithName:PROGRAM_STORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:NAVIGATION_CONTROLLER]; //or the homeController
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:dashboard animated:YES completion:nil];
    });
}

- (void) takeUserToProfileRegistration {
    [self switchToControllerInSameStoryBoard:AGE_GENDER_PROFILE inStoryboard:LOGIN_STORYBOARD];
}

#pragma mark LOGIN ACTION
- (IBAction)loginBtnTapped:(id)sender
{
    if(!([self.email hasText] && [self.password hasText])) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.alertController = [UIAlertController alertControllerWithTitle:@"" message:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_MANDATORY_DATA_MISSING] preferredStyle:UIAlertControllerStyleAlert];
//            [self.alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {    }]];
//            [self presentViewController:self.alertController animated:YES completion:nil];
            
            [[Utils sharedUtils] showAlertViewWithMessage:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_MANDATORY_DATA_MISSING] buttonTitle:@"OK"];
        });
        return;
    } else if(!([[Utils sharedUtils] validateEmail:self.email.text])) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.alertController = [UIAlertController alertControllerWithTitle:@"" message:[self localisedStringForSection:CONTENT_REGISTER_SECTION andKey:CONTENT_LABEL_INVALID_EMAIL] preferredStyle:UIAlertControllerStyleAlert];
//            [self.alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {    }]];
//            [self presentViewController:self.alertController animated:YES completion:nil];
            [[Utils sharedUtils] showAlertViewWithMessage:[self localisedStringForSection:CONTENT_REGISTER_SECTION andKey:CONTENT_LABEL_INVALID_EMAIL] buttonTitle:@"OK"];
        });
        return;
    }
    self.passwordSHA1 = [[Utils sharedUtils] generateSHA1WithString:self.password.text];
    
    [[FITAPIManager sharedManager] loginUsingEmail:self.email.text
                                          password:self.passwordSHA1
                                           success:^(User *user) {
                                               User  *u = [User userInDB];
                                               if(user.isProfileCompleted){ // user profile is completed :) go to dashboard
                                                   [self takeUserToDashBoard];
                                               } else { // profile need to complete go to create profile
                                                   [self takeUserToProfileRegistration];
                                               }
                                           } failure:^(NSError *error) {
                                               [self handleLoginError:error];
                                           }];
}
-(void) getMatchListWS {
    //Get Match List here
    
}
- (void)showAlertViewControllerWithChoose:(NSString*)message andTitle:(NSString*)title succes:(LoginEmailViewController *)sucess
{
    NSString *noString = [self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_NO];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* cancelAction= [UIAlertAction actionWithTitle:noString style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_YES]
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [[FITAPIManager sharedManager] confirmLoginUsingEmail:self.email.text
                                                                                 password:self.passwordSHA1
                                                                               idFacebook:@""
                                                                                 idFLP360:@""
                                                                                  success:^(User *user) {
                                                                                      if(user.isProfileCompleted){ // user profile is completed :) go to dashboard
                                                                                          [self takeUserToDashBoard];
                                                                                      } else { // profile need to complete go to create profile
                                                                                          [self takeUserToProfileRegistration];
                                                                                      }
                                                                                  } failure:^(NSError *error) {
                                                                                      //  [self handleLoginError:error];
                                                                                  }];
                                }];
    
    [alert addAction:yesButton];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)handleLoginError:(NSError *)error {
    if ([error.domain isEqualToString:MTAPIErrorDomain]) {
        switch (error.code) {
            case MT_CODE_AUTHFAIL: {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                               message:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_INVALID_CREDENTIALS]
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil]];
                [self presentViewController:alert animated:true completion:nil];
                break;
            }
            case MT_CODE_NEWDEVICE:{
                LoginEmailViewController *login = [[LoginEmailViewController alloc] init];
                [self showAlertViewControllerWithChoose:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_CHANGED_DEVICE_MESSAGE] andTitle:@"" succes:login];
                
//                [[Utils sharedUtils] showAlertViewWithMessage:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_CHANGED_DEVICE_MESSAGE] buttonTitle:@"OK"];
            }
            default:
                DLog(@"Login error: %@", error);
                break;
        }
    }
}

- (IBAction)goMainScreen:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark LOGIN METHODS

- (void)authenticationFailureWithError:(NSString*)errorMessage
{
    //    [[Utils sharedUtils] showAlertView:errorMessage andTitle:@""];
    //    [[FITSettings sharedSettings] showAlertViewWithMessage:errorMessage andTitle:@"ERROR"];
}

#pragma mark KEYBOARD ACTION

- (void) keyboardWillShow:(NSNotification *) note {
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void) keyboardWillHide:(NSNotification *) note
{
    [self.view removeGestureRecognizer:tapRecognizer];
}

- (void)didTapAnywhere: (UITapGestureRecognizer*) recognizer
{
    [_email resignFirstResponder];
    [_password resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    _scroll.scrollEnabled = TRUE;
    _bottom.constant = 210;
    [_scroll setNeedsLayout];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [_scroll setContentOffset: CGPointMake(0, _scroll.contentInset.top) animated:YES];
    _scroll.scrollEnabled = FALSE;
    [_scroll setNeedsLayout];
}

@end
