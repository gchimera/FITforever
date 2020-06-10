//
//  BottomMenuViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 09/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseViewController.h"

@interface BottomMenuViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet FITButton *waterBtn;
@property (weak, nonatomic) IBOutlet FITButton *trophyBtn;
@property (weak, nonatomic) IBOutlet FITButton *homeBtn;
@property (weak, nonatomic) IBOutlet FITButton *weightBtn;
@property (weak, nonatomic) IBOutlet FITButton *exerciseBtn;
@property (weak, nonatomic) IBOutlet UIImageView *bottomShapeImageView;

@property UserCourse *selectedCourse;

@end
