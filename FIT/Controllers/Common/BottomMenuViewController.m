//
//  BottomMenuViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 09/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BottomMenuViewController.h"

@interface BottomMenuViewController()
@property NSInteger oneOfWeightViews;
@end

@implementation BottomMenuViewController



-(void) viewDidLoad {
    self.oneOfWeightViews = 0;
    
    RLMResults *currentProgram = [UserCourse objectsWhere:@"status = %d",1];
    
    if([currentProgram count] > 0){
        self.selectedCourse = [[UserCourse alloc] init];
        self.selectedCourse = [currentProgram objectAtIndex:0];
    }
    if([self.selectedCourse.courseType integerValue] == C9){
        self.oneOfWeightViews = 1;
    } else {
        self.oneOfWeightViews = 2;
    }
    
    if ([self.selectedCourse.courseType integerValue] == C9) {
        [self ifCurrentMenu:WATER_INTAKE_SCREEN MenuNumber:1];
        [self ifCurrentMenu:AWARDS_SCREEN MenuNumber:2];
        [self ifCurrentMenu:PROGRAM_DASHBOARD MenuNumber:3];
        [self ifCurrentMenu:MEASUREMENTS_SCREEN MenuNumber:4];
        [self ifCurrentMenu:C9_EXERCISES MenuNumber:5];
        
        //Measurement other views
//        [self ifCurrentMenu:@"FITAddWeightVC" MenuNumber:4];
//        [self ifCurrentMenu:@"FITAddChestWaistVC" MenuNumber:4];
//        [self ifCurrentMenu:@"FITAddArmHipVC" MenuNumber:4];
//        [self ifCurrentMenu:@"FITAddThighKneeVC" MenuNumber:4];
        
    } else {
        [self ifCurrentMenu:WATER_INTAKE_SCREEN MenuNumber:1];
        [self ifCurrentMenu:AWARDS_SCREEN MenuNumber:2];
        [self ifCurrentMenu:PROGRAM_DASHBOARD MenuNumber:3];
        [self ifCurrentMenu:MEASUREMENTS_SCREEN MenuNumber:4];
        [self ifCurrentMenu:F15_EXERCISES MenuNumber:5];
    }
    [self programButtonUpdate:self.waterBtn buttonMode:1 inSection:@"" forKey:@""];
    [self programButtonUpdate:self.trophyBtn buttonMode:1 inSection:@"" forKey:@""];
    [self programButtonUpdate:self.homeBtn buttonMode:1 inSection:@"" forKey:@"" ];
    [self programButtonUpdate:self.weightBtn buttonMode:1 inSection:@"" forKey:@"" ];
    [self programButtonUpdate:self.exerciseBtn buttonMode:1 inSection:@"" forKey:@""];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)programButtonUpdate:(UIButton *)button
                 buttonMode:(int)buttonMode
                  inSection:(NSString *)section
                     forKey:(NSString *)key {
    
    if([self.selectedCourse.courseType integerValue] == C9){
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[THM C9Color]];
    } else if([self.selectedCourse.courseType integerValue] == F15Begginner || [self.selectedCourse.courseType integerValue] == F15Begginner1 || [self.selectedCourse.courseType integerValue] == F15Begginner2){
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[THM F15BeginnerColor]];
    } else if([self.selectedCourse.courseType integerValue] == F15Intermidiate || [self.selectedCourse.courseType integerValue] == F15Intermidiate1 || [self.selectedCourse.courseType integerValue] == F15Intermidiate2){
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[THM F15IntermidiateColor]];
    } else if([self.selectedCourse.courseType integerValue] == F15Advance || [self.selectedCourse.courseType integerValue] == F15Advance1 || [self.selectedCourse.courseType integerValue] == F15Advance2) {
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[THM F15AdvanceColor]];
    } else if ([self.selectedCourse.courseType integerValue] == V5) {
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[THM V5Color]];
    }
}

- (IBAction)waterBtnTapped:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Program" bundle:nil];
    UIViewController *water  = [sb instantiateViewControllerWithIdentifier:WATER_INTAKE_SCREEN];
    [self.navigationController pushViewController:water animated:YES];
}

- (IBAction)trophyBtnTapped:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Program" bundle:nil];

    UIViewController *awards = [sb instantiateViewControllerWithIdentifier:AWARDS_SCREEN];
    [self.navigationController pushViewController:awards animated:YES];
}

- (IBAction)homeBtnTapped:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Program" bundle:nil];

    UIViewController *home = [sb instantiateViewControllerWithIdentifier:PROGRAM_DASHBOARD];
    [self.navigationController pushViewController:home animated:YES];
}

- (IBAction)weightBtnTapped:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Program" bundle:nil];

    UIViewController *weight = [sb instantiateViewControllerWithIdentifier:MEASUREMENTS_SCREEN];
    [self.navigationController pushViewController:weight animated:YES];
}

- (IBAction)exerciseBtnTapped:(id)sender {
    UIViewController *exercise;

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Exercises" bundle:nil];

    if ([self.selectedCourse.courseType integerValue] == C9) {
        exercise = [sb instantiateViewControllerWithIdentifier:C9_EXERCISES];
    } else {
        exercise = [sb instantiateViewControllerWithIdentifier:F15_EXERCISES];
    }
    [self.navigationController pushViewController:exercise animated:YES];
}


- (BOOL)ifCurrentMenu:(NSString *)viewControllerID MenuNumber:(int)menuNumber {
    
    UIViewController *vc = [self.navigationController.viewControllers lastObject];
    //TODO Check here how to check if already here
    if(![vc.restorationIdentifier isEqualToString:[NSString stringWithFormat:@"%@",viewControllerID]]){
        
        switch (menuNumber) {
            case 1:
                self.waterBtn.alpha = 1;
                self.waterBtn.userInteractionEnabled = YES;
                break;
            case 2:
                self.trophyBtn.alpha = 1;
                self.trophyBtn.userInteractionEnabled = YES;
                break;
            case 3:
                self.homeBtn.alpha = 0.8;
                self.homeBtn.userInteractionEnabled = YES;
                break;
            case 4 :
                if(self.oneOfWeightViews == 0) {
                    self.weightBtn.alpha = 1;
                    self.weightBtn.userInteractionEnabled = YES;
                }
                break;
            case 5:
                self.exerciseBtn.alpha = 1;
                self.exerciseBtn.userInteractionEnabled = YES;
                break;
                
        }
        
        return YES;
    } else {
        switch (menuNumber) {
            case 1:
                self.waterBtn.alpha = 0.8;
                self.waterBtn.userInteractionEnabled = NO;
                break;
            case 2:
                self.trophyBtn.alpha = 0.8;
                self.trophyBtn.userInteractionEnabled = NO;
                break;
            case 3:
                self.homeBtn.alpha = 0.8;
                self.homeBtn.userInteractionEnabled = NO;
                break;
            case 4 :
                self.weightBtn.alpha = 0.8;
                self.weightBtn.userInteractionEnabled = NO;
                self.oneOfWeightViews = 1;
                break;
            case 5:
                self.exerciseBtn.alpha = 0.8;
                self.exerciseBtn.userInteractionEnabled = NO;
                break;
                
        }
        return false;
    }
}

@end

