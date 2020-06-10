//
//  LearnMoreViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 02/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "LearnMoreViewController.h"

@interface LearnMoreViewController ()

@end

@implementation LearnMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController presentTransparentNavigationBar];
    
    [self.navigationController.navigationItem setTitle:[self localisedStringForSection:CONTENT_LEARN_MORE_SECTION andKey:CONTENT_PAGE_TITLE_LEARN_MORE]];
    
    [self languageAndButtonUIUpdate:self.cnineBtn buttonMode:2 inSection:CONTENT_LEARN_MORE_SECTION forKey:CONTENT_C9_PROGRAM_NAME  backgroundColor:[THM C9Color]];
    [self languageAndButtonUIUpdate:self.ffifteenBtn buttonMode:2 inSection:CONTENT_LEARN_MORE_SECTION forKey:CONTENT_F15_PROGRAM_NAME backgroundColor:[THM F15BeginnerColor]];
    [self languageAndButtonUIUpdate:self.vfiveBtn buttonMode:2 inSection:CONTENT_LEARN_MORE_SECTION forKey:CONTENT_V5_PROGRAM_NAME backgroundColor:[THM V5Color]];
    
    [self languageAndLabelUIUpdate:self.headingParagraph inSection:CONTENT_LEARN_MORE_SECTION forKey:CONTENT_LEARN_MORE_HEADING];
    [self languageAndLabelUIUpdate:self.descriptionParagraph inSection:CONTENT_LEARN_MORE_SECTION forKey:CONTENT_LEARN_MORE_DESCRIPTION];
    [self languageAndLabelUIUpdate:self.taglineParagraph inSection:CONTENT_LEARN_MORE_SECTION forKey:CONTENT_LEARN_MORE_TAGLINE];
    [self languageHTMLLabelUIUpdate:self.findOurMoreParagrph inSection:CONTENT_LEARN_MORE_SECTION forKey:CONTENT_FIND_OUT_MORE];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController hideTransparentNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)learnMoreAction:(id)sender {
    //learnMoreDetail
}

@end
