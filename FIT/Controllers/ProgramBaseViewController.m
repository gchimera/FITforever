//
//  ProgramBaseViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"
#import "LAPickerView.h"
#import "ConversationListViewController.h"

@implementation ProgramBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Update program status
    [[Utils sharedUtils] updateProgramStatus];
    [self updateUIAndData];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Update program status
    [[Utils sharedUtils] updateProgramStatus];
    [self updateUIAndData];
}

- (void) updateUIAndData {
    
    RLMResults *currentProgram = [UserCourse objectsWhere:@"status = %d",1];
    
    if([currentProgram count] > 0){
        self.currentCourse = [[UserCourse alloc] init];
        self.currentCourse = [currentProgram objectAtIndex:0];
        self.dayProgram = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
        if(self.dayProgram > 0) {
            self.blockBotoomMenuButton.hidden = YES;
        }
    }
    
    // Load Bottom Bar Menu Programmatically
    self.bottomMenu = [self.storyboard instantiateViewControllerWithIdentifier:BOTTON_MENU];
    self.bottomMenu.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    self.bottomMenu.bottomShapeImageView.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    
    [self.containerView addSubview:self.bottomMenu.view];
    [self addChildViewController:self.bottomMenu];
    [self.bottomMenu didMoveToParentViewController:self];
    
    self.navigationMenu = (FITBurgerMenu *)self.navigationController;
    [self.navigationMenu setFITNavDrawerDelegate:self];
    
    [self programImageUpdate:self.bottomMenu.bottomShapeImageView withImageName:@"bottomshapes"];
    
    if(self.topShapeView != nil){
        [self programImageUpdate:self.topShapeView withImageName:@"topshapes"];
    }
    
    //navigation color change
    if(self.currentCourse != nil){
        if([self.currentCourse.courseType integerValue] == C9){
            [self.navigationController.navigationBar setBarTintColor:[THM C9Color]];
        } else if([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2){
            [self.navigationController.navigationBar setBarTintColor:[THM F15BeginnerColor]];
        } else if([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
            [self.navigationController.navigationBar setBarTintColor:[THM F15IntermidiateColor]];
        } else if([self.currentCourse.courseType integerValue] == F15Advance || [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2) {
            [self.navigationController.navigationBar setBarTintColor:[THM F15AdvanceColor]];
        } else if ([self.currentCourse.courseType integerValue] == V5) {
            [self.navigationController.navigationBar setBarTintColor:[THM V5Color]];
        }
    }
    
}

- (void)programButtonUpdate:(UIButton *)button
                 buttonMode:(int)buttonMode
                  inSection:(NSString *)section
                     forKey:(NSString *)key
                  withColor:(UIColor *) color {
    [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:color];
}

- (void)programImageUpdate:(UIImageView *)imageView
             withImageName:(NSString *)imageName {
    
    if([self.currentCourse.courseType integerValue] == C9) {
        imageName = [NSString stringWithFormat:@"%@C9",imageName];
        [imageView setImage:[UIImage imageNamed:imageName]];
    } else if([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2) {
        imageName = [NSString stringWithFormat:@"%@F15B",imageName];
        [imageView setImage:[UIImage imageNamed:imageName]];
    } else if([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        imageName = [NSString stringWithFormat:@"%@F15I",imageName];
        [imageView setImage:[UIImage imageNamed:imageName]];
    } else if([self.currentCourse.courseType integerValue] == F15Advance|| [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2) {
        imageName = [NSString stringWithFormat:@"%@F15A",imageName];
        [imageView setImage:[UIImage imageNamed:imageName]];
    } else if ([self.currentCourse.courseType integerValue] == V5) {
        imageName = [NSString stringWithFormat:@"%@V5",imageName];
        [imageView setImage:[UIImage imageNamed:imageName]];
    }
    
}

- (void)programButtonImageUpdate:(UIButton *)buttonImage
                   withImageName:(NSString *)imageName{
    
    if([self.currentCourse.courseType integerValue] == C9) {
        imageName = [NSString stringWithFormat:@"%@C9",imageName];
    } else if([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2) {
        imageName = [NSString stringWithFormat:@"%@F15B",imageName];
    } else if([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        imageName = [NSString stringWithFormat:@"%@F15I",imageName];
    } else if([self.currentCourse.courseType integerValue] == F15Advance|| [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2) {
        imageName = [NSString stringWithFormat:@"%@F15A",imageName];
    } else if ([self.currentCourse.courseType integerValue] == V5) {
        imageName = [NSString stringWithFormat:@"%@V5",imageName];
    }
    
    [buttonImage setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)programLabelColor:(UILabel *)label {
    if([self.currentCourse.courseType integerValue] == C9) {
        [label setTextColor:[THM C9Color]];
    } else if([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2) {
        [label setTextColor:[THM F15BeginnerColor]];
    } else if([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        [label setTextColor:[THM F15IntermidiateColor]];
    } else if([self.currentCourse.courseType integerValue] == F15Advance|| [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2) {
        [label setTextColor:[THM F15AdvanceColor]];
    } else if ([self.currentCourse.courseType integerValue] == V5) {
        [label setTextColor:[THM V5Color]];
    }
}



- (UIColor *)programColor {
    if([self.currentCourse.courseType integerValue] == C9) {
       return [THM C9Color];
    } else if([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2) {
        return [THM F15BeginnerColor];
    } else if([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        return [THM F15IntermidiateColor];
    } else if([self.currentCourse.courseType integerValue] == F15Advance|| [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2) {
        return [THM F15AdvanceColor];
    } else {
        return [THM V5Color];
    }
}

- (void)programViewColor:(UIView *)view {
    if([self.currentCourse.courseType integerValue] == C9) {
        [view setBackgroundColor:[THM C9Color]];
    } else if([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2) {
        [view setBackgroundColor:[THM F15BeginnerColor]];
    } else if([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        [view setBackgroundColor:[THM F15IntermidiateColor]];
    } else if([self.currentCourse.courseType integerValue] == F15Advance|| [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2) {
        [view setBackgroundColor:[THM F15AdvanceColor]];
    } else if ([self.currentCourse.courseType integerValue] == V5) {
        [view setBackgroundColor:[THM V5Color]];
    }
    
}

- (void)programLabelColor:(UILabel *)label
                inSection:(NSString *)section
                   forKey:(NSString *)key{
    [label setText:[self localisedStringForSection:section andKey:key]];
    if([self.currentCourse.courseType integerValue] == C9) {
        [label setTextColor:[THM C9Color]];
    } else if([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2) {
        [label setTextColor:[THM F15BeginnerColor]];
    } else if([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        [label setTextColor:[THM F15IntermidiateColor]];
    } else if([self.currentCourse.courseType integerValue] == F15Advance|| [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2) {
        [label setTextColor:[THM F15AdvanceColor]];
    } else if ([self.currentCourse.courseType integerValue] == V5) {
        [label setTextColor:[THM V5Color]];
    }
    
}

- (void)programButtonUpdate:(UIButton *)button
                 buttonMode:(int)buttonMode
                  inSection:(NSString *)section
                     forKey:(NSString *)key {
    
    if([self.currentCourse.courseType integerValue] == C9){
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[THM C9Color]];
    } else if([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2) {
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[THM F15BeginnerColor]];
    } else if([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[THM F15IntermidiateColor]];
    } else if([self.currentCourse.courseType integerValue] == F15Advance|| [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2) {
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[THM F15AdvanceColor]];
    } else if ([self.currentCourse.courseType integerValue] == V5) {
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[THM V5Color]];
    }
}


- (void)programButtonUpdateNotAchived:(UIButton *)button
                 buttonMode:(int)buttonMode
                  inSection:(NSString *)section
                     forKey:(NSString *)key {
    
    if([self.currentCourse.courseType integerValue] == C9){
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[UIColor colorWithRed:0.91 green:0.85 blue:0.91 alpha:1.00]];
    } else if([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2) {
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[UIColor colorWithRed:0.93 green:0.97 blue:0.88 alpha:1.00]];
    } else if([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[UIColor colorWithRed:1.00 green:0.93 blue:0.80 alpha:1.00]];
    } else if([self.currentCourse.courseType integerValue] == F15Advance|| [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2) {
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[UIColor colorWithRed:0.97 green:0.80 blue:0.81 alpha:1.00]];
    } else if ([self.currentCourse.courseType integerValue] == V5) {
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[UIColor colorWithRed:0.74 green:0.92 blue:0.94 alpha:1.00]];
    }
}



#pragma mark - burger Menu delegate
-(void)FITNavDrawerSelection:(NSInteger)selectionIndex
{
    NSLog(@"FITNavDrawerSelection = %li", (long)selectionIndex);
}

- (IBAction)drawerToggle:(id)sender {
    [self.navigationMenu drawerToggle];
}

- (IBAction)openMessages:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MESSAGE_STORYBOARD bundle:nil];
    ConversationListViewController *groupsVC = (ConversationListViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ConversationListViewController"];
    [self.navigationController pushViewController:groupsVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)blockBotoomMenuButtonTapped:(id)sender {
    
    if(self.dayProgram > 0) {
        self.blockBotoomMenuButton.hidden = YES;
    } else {
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"This course hasn't started yet"
                                     message:@"This course hasn't started yet please wait and you will be notified when the course is ready to start"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    
}

@end
