//
//  C9FinalPopupViewController.m
//  FIT
//
//  Created by Hadi Roohian on 05/04/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "C9FinalPopupViewController.h"

@interface C9FinalPopupViewController ()

@end

@implementation C9FinalPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstText.text = [self localisedStringForSection:CONTENT_FIT_C9_DASHBOARD_SECTION andKey:CONTENT_DAY_9_MESSAGE_DESCRIPTION];
    self.titleSection.text = [self localisedStringForSection:CONTENT_FIT_C9_DASHBOARD_SECTION andKey:CONTENT_DAY_9_MESSAGE_HEADER];
    [self programButtonUpdate:self.okButton buttonMode:3 inSection:CONTENT_FIT_C9_DASHBOARD_SECTION forKey:CONTENT_BUTTON_OK];
    
    self.secondText.hidden = YES;
    
//    CONTENT_FIT_C9_DASHBOARD_SECTION
//    CONTENT_DAY_9_MESSAGE_DESCRIPTION
}



- (IBAction)okButtonTapped:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}
@end
