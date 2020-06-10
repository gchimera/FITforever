//
//  LearnMoreC9ViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 12/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "LearnMoreC9ViewController.h"
#import "InitialViewController.h"

@interface LearnMoreC9ViewController ()

@end

@implementation LearnMoreC9ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController presentTransparentNavigationBar];
    [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_LEARN_MORE_SECTION andKey:CONTENT_C9_PROGRAM_NAME]];
    
    [self languageAndButtonUIUpdate:self.moreInfobutton buttonMode:3 inSection:CONTENT_LEARN_MORE_SECTION forKey:CONTENT_BUTTON_MORE_INFORMATION backgroundColor:[THM WhiteColor]];
    [self languageAndButtonUIUpdate:self.proceedLoginButton buttonMode:3 inSection:CONTENT_LEARN_MORE_SECTION forKey:CONTENT_BUTTON_PROCEED_LOGIN backgroundColor:[THM C9Color]];
    
    [self languageAndLabelUIUpdate:self.learnMoreTagline inSection:CONTENT_LEARN_MORE_SECTION forKey:CONTENT_C9_PROGRAM_TAGLINE];
    [self languageHTMLLabelUIUpdate:self.learnMoreC9Description inSection:CONTENT_LEARN_MORE_SECTION forKey:CONTENT_C9_PROGRAM_DESCRIPTION];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController hideTransparentNavigationBar];
}

- (IBAction)proceedLoginBtn:(id)sender {
    InitialViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:INITIAL_SCREEN];
    
    [[self navigationController] pushViewController:vc animated:YES];
}

- (IBAction)moreinfoBtn:(id)sender
{
    //TODO here put different link base on program we are
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self localisedStringForSection:CONTENT_LEARN_MORE_SECTION andKey:CONTENT_C9_PROGRAM_MORE_INFO_LINK]]];
}
@end
