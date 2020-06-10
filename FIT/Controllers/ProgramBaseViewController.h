//
//  ProgramBaseViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseViewController.h"
#import "FITGraphView.h"
#import "FITProgressSegueView.h"
#import "BottomMenuViewController.h"
#import "UserCourse.h"
#import "CourseDay.h"

@interface ProgramBaseViewController : BaseViewController<FITNavDrawerDelegate>

@property NSInteger dayProgram;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *topShapeView;
@property (strong, nonatomic) FITBurgerMenu *navigationMenu;
@property (strong, nonatomic) BottomMenuViewController *bottomMenu;
@property UserCourse *currentCourse;

@property UserCourseType *mainCourseSelected;
@property (weak, nonatomic) IBOutlet UIButton *blockBotoomMenuButton;

- (IBAction)drawerToggle:(id)sender;

@property long ThemeMode;
- (UIColor *)programColor;
- (void)programButtonUpdate:(UIButton *)button
                 buttonMode:(int)buttonMode
                  inSection:(NSString *)section
                     forKey:(NSString *)key
                  withColor:(UIColor *) color;

- (void)programButtonUpdate:(UIButton *)button
                 buttonMode:(int)buttonMode
                  inSection:(NSString *)section
                     forKey:(NSString *)key;

- (void)programImageUpdate:(UIImageView *)imageView
             withImageName:(NSString *)imageName;

- (void)programButtonImageUpdate:(UIButton *)buttonImage
             withImageName:(NSString *)imageName;

- (void)programLabelColor:(UILabel *)label;
- (void)programViewColor:(UIView *)view;

- (void)programLabelColor:(UILabel *)label
                inSection:(NSString *)section
                   forKey:(NSString *)key;

- (void)programButtonUpdateNotAchived:(UIButton *)button
                           buttonMode:(int)buttonMode
                            inSection:(NSString *)section
                               forKey:(NSString *)key;
@end






