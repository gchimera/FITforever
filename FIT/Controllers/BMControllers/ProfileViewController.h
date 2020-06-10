//
//  ProfileViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 13/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MenuBaseViewController.h"

@interface ProfileViewController : MenuBaseViewController

@property (weak, nonatomic) IBOutlet FITButton *completeProfileBtn;
@property (weak, nonatomic) IBOutlet UIImageView *genderPic;
@property (weak, nonatomic) IBOutlet UIImageView *genderCamera;
@property (weak, nonatomic) IBOutlet UILabel *termsLabel;
@property (weak, nonatomic) IBOutlet UITextView *termsTextView;

@property (strong, nonatomic) IBOutlet UIImageView *profilePicView;
@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (weak, nonatomic) IBOutlet UITextField *heightTextfield;
@property (weak, nonatomic) IBOutlet UITextField *weightTextfield;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *ageTextfield;
@property (weak, nonatomic) IBOutlet UITextField *genderTextfield;


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *xButtonsCollection;
- (IBAction)xBtnTapped:(UIButton *)sender;



@end
