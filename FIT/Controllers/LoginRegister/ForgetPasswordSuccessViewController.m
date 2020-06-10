//
//  ForgetPasswordSuccessViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 12/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ForgetPasswordSuccessViewController.h"
#import "InitialViewController.h"

@interface ForgetPasswordSuccessViewController ()

@end

@implementation ForgetPasswordSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_FORGOTPASSWORD_SECTION andKey:CONTENT_PAGE_TITLE_FORGOTTEN_PASSWORD]];
    
    [self languageAndButtonUIUpdate:self.letterBtn buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM BMColor]];
    
    [self languageAndButtonUIUpdate:self.okBtn buttonMode:3 inSection:CONTENT_FORGOTPASSWORD_SECTION forKey:CONTENT_BUTTON_OK backgroundColor:[THM C9Color]];
    
    [self.instructionLabel setText:[self localisedStringForSection:CONTENT_FORGOTPASSWORD_SECTION andKey:CONTENT_LABEL_RESET_PASSWORD_CONFIRMATION]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)okBtnTapped:(id)sender {
    InitialViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:INITIAL_SCREEN];
    
    [[self navigationController] pushViewController:vc animated:YES];
    
}


@end
