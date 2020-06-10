//
//  ProfileViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 13/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProfileViewController.h"
#import "Dashboard.h"
#import "FITManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

@interface ProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property NSString *imageString;
@property User *user;
@property NSString *imageType;
@property bool isEditingMode;
@property bool isCameraEditingMode;
@end

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isEditingMode = NO;
    self.isCameraEditingMode = NO;
    
    UITapGestureRecognizer *newTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnCameraAction:)];
    
    
    for (UIButton *btn in self.xButtonsCollection) {
        btn.layer.cornerRadius = btn.frame.size.width / 2;
        [btn setHidden:YES];
    }
    
    //
    //    // Round image
    //    self.profilePicView.layer.cornerRadius = self.profilePicView.frame.size.width / 2;
    //    self.profilePicView.clipsToBounds = YES;
    //    // Border image
    //    self.profilePicView.layer.borderWidth = 3.0f;
    //    self.profilePicView.layer.borderColor = [UIColor grayColor].CGColor;
    //    [self.profilePicView.layer setMasksToBounds:YES];
    
    
    self.user = [User userInDB];
    
    self.nameTextfield.text = self.user.username;
    self.ageTextfield.text = [NSString stringWithFormat:@"%@ %@",self.user.age, [self localisedStringForSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE andKey:CONTENT_LABEL_YEARS]] ;
    
    
    //check default value
    self.settings = [AppSettings getAppSettings];
    
    if ([self.settings.lenghtType integerValue ] == METERS) {
        
        self.heightTextfield.text = [NSString stringWithFormat:@"%@ %@",self.user.height,[MKLengthUnit centimeter].symbol];
    } else if ([self.settings.lenghtType integerValue ] == INCHES) {
        self.heightTextfield.text = [NSString stringWithFormat:@"%@ %@",self.user.height,[MKLengthUnit inch].symbol];
    }
    
    
    if ([self.settings.wightType integerValue] == LIBRA) {
        self.weightTextfield.text = [NSString stringWithFormat:@"%@ %@",self.user.weight,[MKMassUnit pound].symbol];
    } else if ([self.settings.wightType integerValue] == GRAMS) {
        self.weightTextfield.text = [NSString stringWithFormat:@"%@ %@",self.user.weight,[MKMassUnit kilogram].symbol];
    }
    
    
    
    
    
    
    
    self.cameraView.hidden = YES;
    NSString *gender = self.user.gender;
    if([gender isEqualToString:@"f"]) {
        self.genderPic.image = [UIImage imageNamed:@"femalegender"];
        self.genderCamera.image = [UIImage imageNamed:@"femalecamera"];
        self.genderTextfield.text = @"Female";
    } else {
        self.genderPic.image = [UIImage imageNamed:@"malegenderselected"];
        self.genderCamera.image = [UIImage imageNamed:@"malecamera"];
        self.genderTextfield.text = @"Male";
    }
    
    self.cameraView.layer.cornerRadius = 10;
    self.cameraView.clipsToBounds = YES;
    [self.profilePicView setUserInteractionEnabled:YES];
    [self.profilePicView addGestureRecognizer:newTap];
    
    self.imageString = @"";
    
    if([self.user.imageType isEqualToString:@"imageURL"]) {
        self.imageString = self.user.image;
        self.profilePicView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageString]]];
        self.imageType = @"imageURL";
    } else {
        self.imageString = self.user.image;
        self.profilePicView.image = [[Utils sharedUtils] decodeBase64ToImage:self.imageString];
        self.imageType = @"Base64";
        
    }
    
    //    self.profilePicView.layer.cornerRadius = self.profilePicView.frame.size.height / 2;
    //    // Border image
    //    self.profilePicView.layer.borderWidth = 3.0f;
    //    self.profilePicView.layer.borderColor = [UIColor grayColor].CGColor;
    //    [self.profilePicView.layer setMasksToBounds:YES];
    //    self.profilePicView.clipsToBounds = YES;
    
    if(!([self.imageString isEqualToString:@""])) {
        self.genderPic.hidden = YES;
        self.genderCamera.hidden = YES;
        self.cameraView.hidden = NO;
    }
    
    
    
    
    [self languageAndButtonUIUpdate:self.completeProfileBtn buttonMode:3 inSection:CONTENT_FITAPP_LABELS_PROFILE_SECTION forKey:CONTENT_BUTTON_EDIT_PROFILE backgroundColor:[THM BMColor]];
    
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.profilePicView.layer.cornerRadius = self.profilePicView.frame.size.width / 2.0;
    self.profilePicView.layer.borderWidth = 2.0;
    self.profilePicView.layer.borderColor = [UIColor grayColor].CGColor;
    self.profilePicView.layer.masksToBounds = YES;
    self.profilePicView.clipsToBounds = YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)updateProfile:(id)sender{
    
    if(self.isEditingMode) {
        if(![self.nameTextfield hasText] || ![self.ageTextfield hasText] || ![self.weightTextfield hasText] || ![self.heightTextfield hasText])
            return;
        self.isCameraEditingMode = NO;
        NSString *idFLP360 = self.user.idFLP360;
        NSString *idFacebook = self.user.idFacebook;
        NSString *gender = [self.genderTextfield.text lowercaseString];
        NSString *cmsGender;
        bool isBreak;
        if([gender isEqualToString:@"male"]) {
            cmsGender = @"m";
            isBreak = NO;
        } else if([gender isEqualToString:@"female"]) {
            cmsGender = @"f";
            isBreak = NO;
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please type a valid value in gender field \n Ex. Male - Female" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            isBreak = YES;
            return;
        }
        if(isBreak) {
            return;
        } else {
            __weak __typeof__(self) weakSelf = self;
            [[FITAPIManager sharedManager] updateProfile:self.user.email
                                                password:self.user.password
                                                username:self.nameTextfield.text
                                                     age:[self.ageTextfield.text intValue]
                                                  gender:self.genderTextfield.text
                                                  height:[self.heightTextfield.text intValue]
                                                  weight:[self.weightTextfield.text intValue]
                                                   image:self.imageString
                                               imageType:self.imageType
                                              idFacebook:idFacebook ? idFacebook : @""
                                                idFLP360:idFLP360 ? idFLP360 : @""
                                                 success:^(User *user) {
                                                         NSLog(@"%@", user);
                                                         [weakSelf languageAndButtonUIUpdate:weakSelf.completeProfileBtn buttonMode:3 inSection:CONTENT_FITAPP_LABELS_PROFILE_SECTION forKey:CONTENT_BUTTON_EDIT_PROFILE backgroundColor:[THM BMColor]];
                                                         for ( UIButton *btn in weakSelf.xButtonsCollection) {
                                                             [btn setHidden:YES];
                                                             
                                                         }
                                                         weakSelf.user = user;
                                                         weakSelf.isEditingMode = NO;
                                                         weakSelf.nameTextfield.userInteractionEnabled = NO;
                                                         weakSelf.heightTextfield.userInteractionEnabled = NO;
                                                         weakSelf.weightTextfield.userInteractionEnabled = NO;
                                                         weakSelf.ageTextfield.userInteractionEnabled = NO;
                                                         weakSelf.genderTextfield.userInteractionEnabled = NO;
                                                     
                                                     
                                                 } failure:^(NSError *error) {
                                                     NSLog(@"%@", error);
                                                     
                                                 }];
            
        }
    } else {
        
        self.nameTextfield.userInteractionEnabled = YES;
        self.heightTextfield.userInteractionEnabled = YES;
        self.weightTextfield.userInteractionEnabled = YES;
        self.ageTextfield.userInteractionEnabled = YES;
        self.genderTextfield.userInteractionEnabled = YES;
        
        
        [self languageAndButtonUIUpdate:self.completeProfileBtn buttonMode:3 inSection:CONTENT_FITAPP_LABELS_PROFILE_SECTION forKey:CONTENT_BUTTON_FINISH_EDITING backgroundColor:[THM BMColor]];
        for ( UIButton *btn in self.xButtonsCollection) {
            [btn setHidden:NO];
        }
        self.isEditingMode = YES;
        self.isCameraEditingMode = YES;
    }
    
}

#pragma mark - Image Capture
- (IBAction)btnCameraAction:(id)sender {
    NSLog(@"btnCameraAction called!");
    if(self.isCameraEditingMode) {
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
    
    self.imageString = [UIImagePNGRepresentation(resizedImage) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    self.profilePicView.image = resizedImage;
    self.imageType = @"Base64";
    
    self.genderPic.hidden = YES;
    self.genderCamera.hidden = YES;
    self.cameraView.hidden = NO;
    
    self.profilePicView.layer.cornerRadius = self.profilePicView.frame.size.width / 2;
    self.profilePicView.clipsToBounds = YES;
    // Border image
    self.profilePicView.layer.borderWidth = 3.0f;
    self.profilePicView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.profilePicView.layer setMasksToBounds:YES];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)btnPhotoPickerDoneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)xBtnTapped:(UIButton *)sender {
    switch (sender.tag) {
        case 10:
            self.nameTextfield.text = @"";
            break;
        case 11:
            self.heightTextfield.text = @"";
            break;
        case 12:
            self.weightTextfield.text = @"";
            break;
        case 13:
            self.ageTextfield.text = @"";
            break;
        case 14:
            self.genderTextfield.text = @"";
            break;
            
        default:
            break;
    }
}
@end
