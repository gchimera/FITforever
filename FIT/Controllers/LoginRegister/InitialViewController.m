//
//  InitialViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 01/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "InitialViewController.h"
#import "Dashboard.h"
#import "CourseMealMap.h"

@interface InitialViewController ()

@property UIWebView *webView;
@property NSMutableDictionary *profileDetails;
@property UIAlertController *alertController;

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[FITAPIManager sharedManager] getContentsWithSuccess:^(RLMResults<Content *> *contents) {
        DLog(@"contents %@", contents);
        [self updateUIAfterDownloadContent];
    } failure:^(NSError *error) {
    }];
    
    self.profileDetails = [[NSMutableDictionary alloc] init];
    
#pragma mark here manage to call api to download
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType: SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setBackgroundColor:[THM C9Color]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [self updateUIAfterDownloadContent];
    
    [self populateCourseMap];

}

-(void) populateCourseMap {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    CourseMealMap *c9day1 = [[CourseMealMap alloc] init];
    CourseMealMap *c9day2 = [[CourseMealMap alloc] init];
    CourseMealMap *f15b1 = [[CourseMealMap alloc] init];
    CourseMealMap *f15b2 = [[CourseMealMap alloc] init];
    CourseMealMap *f15 = [[CourseMealMap alloc] init];
    
    c9day1.id = @1;
    c9day1.program = @0;
    c9day1.day = @1;
    c9day1.breakfast = @1;
    c9day1.morningSnack = @1;
    c9day1.lunch = @3;
    c9day1.dinner = @1;
    c9day1.eveningShake = @1;
    
    c9day2.id = @2;
    c9day2.program = @0;
    c9day2.day = @2;
    c9day2.breakfast = @3;
    c9day2.morningSnack = @1;
    c9day2.lunch = @0;
    c9day2.dinner = @0;
    c9day2.eveningShake = @0;
    
    f15b1.id = @3;
    f15b1.program = @(F15Begginner1);
    f15b1.day = @1;
    f15b1.breakfast = @3;
    f15b1.morningSnack = @2;
    f15b1.lunch = @2;
    f15b1.dinner = @2;
    f15b1.eveningShake = @0;
    
    f15b2.id = @4;
    f15b2.program = @(F15Begginner2);
    f15b2.day = @1;
    f15b2.breakfast = @2;
    f15b2.morningSnack = @1;
    f15b2.lunch = @2;
    f15b2.dinner = @2;
    f15b2.eveningShake = @4;
    
    f15.id = @5;
    f15.program = @(F15Advance);
    f15.day = @1;
    f15.breakfast = @2;
    f15.morningSnack = @2;
    f15.lunch = @2;
    f15.dinner = @2;
    f15.eveningShake = @4;
    
    [realm addOrUpdateObject:c9day1];
    [realm addOrUpdateObject:c9day2];
    [realm addOrUpdateObject:f15b1];
    [realm addOrUpdateObject:f15b2];
    [realm addOrUpdateObject:f15];
    [realm commitWriteTransaction];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUIAfterDownloadContent];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void) updateUIAfterDownloadContent{
    //Update Buttons Shape
    [self languageAndButtonUIUpdate:self.loginWithFLPButton buttonMode:3 inSection:CONTENT_LOGIN_SECTION forKey:LOGIN_FLP360 backgroundColor:[THM LoginFLP360ButtonColor]];
    [self languageAndButtonUIUpdate:self.loginFBButton buttonMode:3 inSection:CONTENT_LOGIN_SECTION forKey:LOGIN_FB backgroundColor:[THM LoginFBButtonColor]];
    [self languageAndButtonUIUpdate:self.learnMoreButton buttonMode:3 inSection:CONTENT_LOGIN_SECTION forKey:LOGIN_LEARN_MORE backgroundColor:[THM LearnMoreButtonColor]];
    [self languageAndButtonUIUpdate:self.loginEmailButton buttonMode:3 inSection:CONTENT_LOGIN_SECTION forKey:CONTENT_LOGIN_EMAIL backgroundColor:[THM LoginButtonColor]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (IBAction)loginWithEmail:(id)sender {
    [self performSegueWithIdentifier:LOGIN_PUSH sender:nil];
}

#pragma mark LOGIN WITH FACEBOOK

- (IBAction)loginWithFacebookBtnTapped:(id)sender
{
    NSString* savedUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    //new login
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends", @"user_hometown", @"user_birthday", @"read_custom_friendlists"]
                 fromViewController:self
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    DLog(@"Error:%@",error);
                                    DLog(@"Process error");
                                } else if (result.isCancelled) {
                                    DLog(@"Cancelled");
                                } else {
                                    [self.profileDetails setValue:result.token.tokenString forKey:@"facebook_token"];
                                    [self fetchUserInfo];
                                }
                            }];
}

-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setValue:@"id, name, email, birthday, gender, picture" forKey:@"fields"];
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                           parameters:parameters
                                          tokenString:[FBSDKAccessToken currentAccessToken].tokenString
                                              version:@"v2.3" HTTPMethod:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSString * email = result[@"email"];
                 NSString * name = result[@"name"];
                 NSString * facebook_id = result[@"id"];
                 NSString * birthday = result[@"birthday"];
                 NSString * gender = result[@"gender"];
                 NSString * picture = [[result[@"picture"] objectForKey:@"data"] valueForKey:@"url"];
                 
                 //create object of User Mantle here and call the register
                 [[FITAPIManager sharedManager] registerUserUsingMethod:Facebook
                                                                  email:email
                                                               password:nil username:name age:0 gender:gender height:0 weight:0 image:picture idFacebook:facebook_id idFLP360:nil success:^(User *user) {
                                                                   [self performSegueWithIdentifier:LOGIN_PUSH sender:nil];                                                               } failure:^(NSError *error) {
                                                                       if([[error localizedDescription] containsString:@"105"]){
                                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                                               InitialViewController* initialViewController = [[InitialViewController alloc]init];
                                                                               
                                                                               [self showAlertViewControllerWithChoose:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_CHANGED_DEVICE_MESSAGE] andEmail:email andPassword:@"" andFbId:facebook_id andFLP360:@"" succes:initialViewController];
                                                                           });
                                                                       }
                                                                   }];
                 
                 NSLog(@"result : %@",result);
             }
             else
             {
                 NSLog(@"ErrorFB:%@",error);
             }
         }];
        
    }
}

- (void)showAlertViewControllerWithChoose:(NSString*)message andEmail:(NSString*)email andPassword:(NSString *)password andFbId:(NSString *) fbId andFLP360:(NSString *) flp360Id succes:(InitialViewController *)sucess
{
    NSString *noString = [self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_NO];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* cancelAction= [UIAlertAction actionWithTitle:noString style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_YES]
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [[FITAPIManager sharedManager] confirmLoginUsingEmail:email
                                                                                 password:password
                                                                               idFacebook:fbId
                                                                                 idFLP360:flp360Id
                                                                                  success:^(User *user) {
                                                                                      [self performSegueWithIdentifier:LOGIN_PUSH sender:nil];
                                                                                  } failure:^(NSError *error) {
                                                                                      //                                                                                      [self handleLoginError:error];
                                                                                  }];
                                }];
    
    [alert addAction:yesButton];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark LOGIN WITH FLP

- (IBAction)loginWithFLPBtnTapped:(id)sender
{
    [self performSelector:@selector(getAuthenticationCode) withObject:nil afterDelay:0.25];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:LOGIN_PUSH]) {}
}

- (void)getAuthenticationCode
{
    self.webView =[[UIWebView alloc] initWithFrame:CGRectMake(0.0,60.0,self.view.frame.size.width,self.view.frame.size.height)];

    
    NSString *urlString = [NSString stringWithFormat:@"%@%@&response_type=code&redirect_uri=%@",FBO_URL,FBO_CLIENT_ID,FBO_REDIRECT_URL];
    
    NSURL *url = [NSURL URLWithString:urlString];
                  
    requestObj = [NSURLRequest requestWithURL:url];
    self.webView.delegate = self;
    self.webView.tag = 55;
    [self.webView loadRequest:requestObj];
    
    
    UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    navbar.tag = 66;
    [self.view addSubview:navbar];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [doneBtn addTarget:self action:@selector(DoneAction:) forControlEvents:UIControlEventTouchDown];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    doneBtn.frame = CGRectMake(0, 0, 80, 70);
    [doneBtn addTarget:self action:@selector(DoneAction:) forControlEvents:UIControlEventTouchUpInside];
    [navbar addSubview:doneBtn];
}

// Done button at top of flp360 login webview to close webview
- (IBAction)DoneAction:(id)sender {
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    
    self.webView =[[UIWebView alloc] init];
    [[self.view viewWithTag:55] removeFromSuperview];
    [[self.view viewWithTag:66] removeFromSuperview];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"host:%@",[[request URL]host]);
    
    if ([[[request URL] host] isEqualToString:@"localhost"]) {
        
        // Extract oauth_verifier from URL query
        NSString* verifier = nil;
        NSArray* urlParams = [[[request URL] query] componentsSeparatedByString:@"&"];
        
        for (NSString* param in urlParams) {
            NSArray* keyValue = [param componentsSeparatedByString:@"="];
            NSString* key = [keyValue objectAtIndex:0];
            if ([key isEqualToString:@"code"]) {
                verifier = [keyValue objectAtIndex:1];
                break;
            }
        }
        
        if (verifier)
        {
            FITAuthenticateCMS *loginChk=[[FITAuthenticateCMS alloc] init];
            loginChk.delegate=self;
            [loginChk getauthorizationCode:verifier];
            
            
        } else {
            // TODO :Check whether there is an error
//            [[FITSettings sharedSettings] showAlertViewWithMessage:@"Some Error ocured! Please try again" andTitle:@"FLP Error"];
        }
        
        webView.delegate = nil;
        [webView removeFromSuperview];
        return NO;
    } else {
        [self.view addSubview:self.webView];
    }
    
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
//    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:92 / 255.0f green:38 / 255.0f blue:132 / 255.0f alpha:1.0f]];
//    [SVProgressHUD showWithStatus:@"Loading..."];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
    NSString *currentURL = [self.webView stringByEvaluatingJavaScriptFromString:@"window.location.href"];
    NSLog(@"currentURL:%@",currentURL);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (error.code != NSURLErrorCancelled) {
//        [[FITSettings sharedSettings] showAlertViewWithMessage:@"There is a problem in login." andTitle:@"Error"];
    }
}

#pragma mark LOGIN METHODS

- (void)authenticationFailureWithError:(NSString*)errorMessage
{
    
    
    //    [[FITSettings sharedSettings] showAlertViewWithMessage:errorMessage andTitle:@"ERROR"];
    
}

- (void)successVerificationofUser
{
}

- (void)successVerificationofUserForCMS:(NSMutableDictionary *)responseDict
{
    NSLog(@"%@",responseDict);
    NSLog(@"%@",[responseDict[@"profile"] objectForKey:@"email"]);
    NSString *email = [responseDict[@"profile"] objectForKey:@"email"];
    NSString *name = [responseDict[@"profile"] objectForKey:@"username"];
    NSString *tokenFLP = [responseDict[@"profile"] objectForKey:@"user_id"];
    NSString *picture = [[responseDict[@"profile"] objectForKey:@"photos"] valueForKey:@"picture"];
    
    
    [[FITAPIManager sharedManager] registerUserUsingMethod:Facebook
                                                     email:email
                                                  password:nil username:name age:0 gender:@"m" height:0 weight:0 image:picture idFacebook:nil idFLP360:tokenFLP success:^(User *user) {
                                                      [self performSegueWithIdentifier:LOGIN_PUSH sender:nil];                                                               } failure:^(NSError *error) {
                                                          if([[error localizedDescription] containsString:@"105"]){
                                                              static dispatch_once_t onceToken;
                                                              dispatch_once(&onceToken, ^{
                                                                  InitialViewController* initialViewController = [[InitialViewController alloc]init];
                                                                  
                                                                  [self showAlertViewControllerWithChoose:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_CHANGED_DEVICE_MESSAGE] andEmail:email andPassword:@"" andFbId:@"" andFLP360:tokenFLP succes:initialViewController];
                                                              });
                                                          }
                                                      }];
    
    
}

-(void)errorVerificationOfUser
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
    self.alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Could not verify user. Please try logging in again" preferredStyle:UIAlertControllerStyleAlert];
    [self.alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {    }]];
        
        [self presentViewController:self.alertController animated:YES completion:nil];
    });
    
}

@end
