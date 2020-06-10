//
//  FITProgramsListViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 16/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MenuBaseViewController.h"

@interface FITProgramsListViewController : MenuBaseViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet FITButton *closeBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollViewView;
@property float screenWidth;
@property RLMResults *programResults;
@property UIColor *comingColor;
@property bool isSwitched;

@property (weak, nonatomic) IBOutlet UILabel *currentProgramLabel;
@property (weak, nonatomic) IBOutlet UILabel *completeProgramLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *completeScrollView;

@end
