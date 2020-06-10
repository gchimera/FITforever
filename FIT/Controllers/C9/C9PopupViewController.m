//
//  C9PopupViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 04/04/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "C9PopupViewController.h"

@interface C9PopupViewController ()
@property NSNumber *selectedMeal;
@end

@implementation C9PopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.okButton setEnabled:NO];
    
    [self programButtonUpdate:self.dinnerButton buttonMode:1 inSection:CONTENT_FIT_C9_DASHBOARD_SECTION forKey:CONTENT_BUTTON_DINNER];
    [self programButtonUpdate:self.LunchButton buttonMode:1 inSection:CONTENT_FIT_C9_DASHBOARD_SECTION forKey:CONTENT_BUTTON_LUNCH];
    [self programButtonUpdate:self.okButton buttonMode:3 inSection:CONTENT_FIT_C9_DASHBOARD_SECTION forKey:CONTENT_BUTTON_OK];
    
    self.titleLabel.text = [self localisedStringForSection:CONTENT_FIT_C9_DASHBOARD_SECTION andKey:CONTENT_DAY_3_MESSAGE_1];
    self.congratsLabel.text = [self localisedStringForSection:CONTENT_FIT_C9_DASHBOARD_SECTION andKey:CONTENT_DAY_3_QUESTION];
    self.detailLabel.text = [self localisedStringForSection:CONTENT_FIT_C9_DASHBOARD_SECTION andKey:CONTENT_DAY_3_MESSAGE_2];
    
}


- (IBAction)buttonClick:(UIButton *)sender {
    
        if(sender.tag == 1) {
            // Lunch Selected
            self.selectedMeal = @1;
            
            [self programButtonUpdate:self.dinnerButton buttonMode:1 inSection:CONTENT_FIT_C9_DASHBOARD_SECTION forKey:CONTENT_BUTTON_DINNER withColor:[THM C9Color]];
            [self programButtonUpdate:self.LunchButton buttonMode:1 inSection:CONTENT_FIT_C9_DASHBOARD_SECTION forKey:CONTENT_BUTTON_LUNCH withColor:[THM C9ColorFreeFoodSelected]];

        } else if(sender.tag == 2) {
//             Dinner Selected
            self.selectedMeal = @2;
            [self programButtonUpdate:self.dinnerButton buttonMode:1 inSection:CONTENT_FIT_C9_DASHBOARD_SECTION forKey:CONTENT_BUTTON_DINNER withColor:[THM C9ColorFreeFoodSelected]];
            [self programButtonUpdate:self.LunchButton buttonMode:1 inSection:CONTENT_FIT_C9_DASHBOARD_SECTION forKey:CONTENT_BUTTON_LUNCH withColor:[THM C9Color]];
        }

        self.okButton.enabled = YES;

}
- (IBAction)okButtonClick:(UIButton *)sender {
    
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
         [UserCourse createOrUpdateInRealm:realm withValue:@{ @"userProgramId" : self.currentCourse.userProgramId, @"thirdDayChoose" : self.selectedMeal}];
          [realm commitWriteTransaction];


        UIViewController *home = [self.storyboard instantiateViewControllerWithIdentifier:PROGRAM_DASHBOARD];
        [self.navigationController pushViewController:home animated:YES];
}


@end
