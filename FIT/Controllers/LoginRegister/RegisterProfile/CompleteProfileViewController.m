//
//  CompleteProfileViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 13/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "CompleteProfileViewController.h"
#import "Dashboard.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

@interface CompleteProfileViewController (){
    User *userFromSocial;
}
@property NSString *base64ImageString;
@property NSData *base64ImageData;
@end
@implementation CompleteProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self languageAndButtonUIUpdate:self.completeProfileBtn buttonMode:3 inSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE forKey:CONTENT_BUTTON_COMPLETE_PROFILE backgroundColor:[THM C9Color]];
    
    UITapGestureRecognizer *newTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnCameraAction:)];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    self.termsTextView.delegate = self;
    
    userFromSocial = [User userInDB];
    if(userFromSocial != nil){
        self.nameTextfield.text = userFromSocial.username;
    } else {
        self.nameTextfield.text = [defaults objectForKey:@"name"];
    }
    self.ageTextfield.text = [NSString stringWithFormat:@"%@",[defaults objectForKey:@"age"]];
    
    self.yearLabel.text = [self localisedStringForSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE andKey:CONTENT_LABEL_YEARS];
    
    //check default value
    self.settings = [AppSettings getAppSettings];
    
    //here convert the value from default to the option selected TODO HAMID
    if ([self.settings.lenghtType integerValue ] == METERS) {
        self.heightTextfield.text = [NSString stringWithFormat:@"%@",[defaults objectForKey:@"height"]];
        self.lenghUnitLabel.text = [MKLengthUnit centimeter].symbol;
    } else if ([self.settings.lenghtType integerValue ] == INCHES) {
        NSNumber *length_meter =[defaults objectForKey:@"height"];
        MKQuantity* inch = [length_meter length_centimeter];
        NSNumber *inches = [NSNumber numberWithFloat:[[[inch convertTo:[MKLengthUnit inch]] amountWithPrecision:0] floatValue]];
        self.heightTextfield.text = [NSString stringWithFormat:@"%@",inches];
        self.lenghUnitLabel.text = [MKLengthUnit inch].symbol;
    }
    
    
    if ([self.settings.wightType integerValue] == LIBRA) {
        NSNumber *weight_lbs =[defaults objectForKey:@"weight"];
        MKQuantity* kg = [weight_lbs mass_kilogram];
        NSNumber *weight = [NSNumber numberWithFloat:[[[kg convertTo:[MKMassUnit pound]] amountWithPrecision:0] floatValue]];
        self.weightTextfield.text = [NSString stringWithFormat:@"%@",weight];
        self.massUnitLabel.text = [MKMassUnit pound].symbol;
    } else if ([self.settings.wightType integerValue] == GRAMS) {
        self.weightTextfield.text = [NSString stringWithFormat:@"%@",[defaults objectForKey:@"weight"]];
        self.massUnitLabel.text = [MKMassUnit kilogram].symbol;
    }
    
    
    self.cameraView.hidden = YES;
    NSString *gender = [defaults stringForKey:@"gender"];
    if([gender isEqualToString:@"f"]) {
        self.genderPic.image = [UIImage imageNamed:@"femalegender"];
        self.genderCamera.image = [UIImage imageNamed:@"femalecamera"];
    } else {
        self.genderPic.image = [UIImage imageNamed:@"malegenderselected"];
        self.genderCamera.image = [UIImage imageNamed:@"malecamera"];
    }
    
    self.cameraView.layer.cornerRadius = 10;
    self.cameraView.clipsToBounds = YES;
    [self.profilePicView setUserInteractionEnabled:YES];
    [self.profilePicView addGestureRecognizer:newTap];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self localisedStringForSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE andKey:CONTENT_TERMS_OF_SERVICE]]];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    [[self segueView] setAndDisplayNumItems:3 spacing:80];
    [[self segueView] setActiveItem:0];
    [[self segueView] setActiveItem:1];
    [[self segueView] setActiveItem:2];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(userFromSocial != nil) {
        self.profilePicView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userFromSocial.image]]];
    }
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.profilePicView.layer.cornerRadius = self.profilePicView.bounds.size.width / 2;
    self.profilePicView.clipsToBounds = YES;
}

-(void)profilePictureTapped
{
    DLog(@"imageviewyapped");
}


- (IBAction)completeProfileBtnTapped:(id)sender {
    //control here email and password valid
    if(![self.nameTextfield hasText] || ![self.heightTextfield hasText] || ![self.weightTextfield hasText] || ![self.ageTextfield hasText]) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_MANDATORY_DATA_MISSING] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {    }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        });
        
        return;
    }
    BOOL isUpdate = [[NSUserDefaults standardUserDefaults] boolForKey:@"isUpdate"];
    
    //if user is not null is becom from register so call register otherwise call update
    
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    
    NSString *email = [defaults stringForKey:@"email"];
    NSString *password = [defaults stringForKey:@"password"];
    NSString *username = self.nameTextfield.text;
    int age = [[defaults stringForKey:@"age"] intValue];
    NSString *gender = [defaults stringForKey:@"gender"];
    int height = [[defaults stringForKey:@"height"] intValue];
    int weight = [[defaults stringForKey:@"weight"] intValue];
    //    [_ageTextfield setText:[NSString stringWithFormat:@"%d Years",age]];
    //    [_heightTextfield setText:[NSString stringWithFormat:@"%d cm",height]];
    //    [_weightTextfield setText:[NSString stringWithFormat:@"%d lbs",weight]];
    
    if(userFromSocial != nil){
        
        [[FITAPIManager sharedManager] updateProfile:userFromSocial.email
                                            password:userFromSocial.password
                                            username:username
                                                 age:age
                                              gender:gender
                                              height:height
                                              weight:weight
                                               image:userFromSocial.image
                                           imageType:userFromSocial.imageType
                                          idFacebook:userFromSocial.idFacebook
                                            idFLP360:userFromSocial.idFLP360
                                             success:^(User *user) {
                                                 [[FITAPIManager sharedManager] userProgramsWithSuccess:^(NSDictionary *programs) {} failure:^(NSError *error) {}];
                                                 
                                                 [[FITAPIManager sharedManager] userRecipes:@{} success:^(NSDictionary *programs) {} failure:^(NSError *error) {}];
                                                 
                                                 Dashboard *dashboard = [[UIStoryboard storyboardWithName:PROGRAM_STORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:NAVIGATION_CONTROLLER]; //or the homeController
                                                 [self presentViewController:dashboard animated:YES completion:nil];
                                             } failure:^(NSError *error) {
                                             }];
    } else {
        
        [[FITAPIManager sharedManager] registerUserUsingMethod:Email
                                                         email:email
                                                      password:password
                                                      username:username
                                                           age:age
                                                        gender:gender
                                                        height:height
                                                        weight:weight
                                                         image:self.base64ImageString
                                                    idFacebook:@""
                                                      idFLP360:@"" success:^(User *user) {
                                                          
                                                          [[FITAPIManager sharedManager] userProgramsWithSuccess:^(NSDictionary *programs) {} failure:^(NSError *error) {}];
                                                          
                                                          [[FITAPIManager sharedManager] userRecipes:@{} success:^(NSDictionary *programs) {} failure:^(NSError *error) {}];
                                                          
                                                          Dashboard *dashboard = [[UIStoryboard storyboardWithName:PROGRAM_STORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:NAVIGATION_CONTROLLER]; //or the homeController
                                                          [self presentViewController:dashboard animated:YES completion:nil];
                                                          
                                                      } failure:^(NSError *error) {
                                                          
                                                      }];
    }
    
    
}

#pragma mark - Image Capture
- (IBAction)btnCameraAction:(id)sender {
    DLog(@"btnCameraAction called!");
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if(authStatus == AVAuthorizationStatusNotDetermined || status == ALAuthorizationStatusNotDetermined){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Add Photo" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            
            [ac addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [ac dismissViewControllerAnimated:YES completion:nil];
                [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
            }]];
            
            [ac addAction:[UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [ac dismissViewControllerAnimated:YES completion:nil];
                [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                
            }]];
            
            [ac addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [ac dismissViewControllerAnimated:YES completion:nil];
            }]];
            
            [self presentViewController:ac animated:YES completion:nil];
        } else {
            [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
    }
    
    //check Permission
    if(authStatus == AVAuthorizationStatusDenied        ||
       authStatus == AVAuthorizationStatusRestricted    ||
       authStatus == AVAuthorizationStatusNotDetermined ) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Forever FIT is unable to access to access the camera" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: UIApplicationOpenSettingsURLString]];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {    }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    if (status != ALAuthorizationStatusAuthorized) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Forever FIT is unable to access the Photo Library." preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: UIApplicationOpenSettingsURLString]];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {    }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}
- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    UIImage *resizedImage = [[Utils sharedUtils] scaleImage:image toSize:CGSizeMake(100, 100)];
    
    self.base64ImageString = [UIImagePNGRepresentation(resizedImage) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    self.profilePicView.image = resizedImage;
    
    self.genderPic.hidden = YES;
    self.genderCamera.hidden = YES;
    self.cameraView.hidden = NO;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)btnPhotoPickerDoneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)termsBtnTapped:(id)sender {
    NSString *url = [self localisedStringForSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE andKey:CONTENT_PRIVACY_POLICY_LINK];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end
