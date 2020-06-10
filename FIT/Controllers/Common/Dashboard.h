//
//  Dashboard.h
//  FIT
//
//  Created by Hamid Mehmood on 08/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface Dashboard : ProgramBaseViewController <UIGestureRecognizerDelegate>{
    UIPanGestureRecognizer *swipeRecognizer;
}

@property (strong, nonatomic) IBOutletCollection(FITButton) NSArray *grayBtn;

@property (weak, nonatomic) IBOutlet FITButton *cnineBtn;
@property (weak, nonatomic) IBOutlet FITButton *vfiveBtn;
@property (weak, nonatomic) IBOutlet FITButton *fFifteenOneBtn;
@property (weak, nonatomic) IBOutlet FITButton *fFifteenTwoBtn;
@property (weak, nonatomic) IBOutlet FITButton *fFifteenThreeBtn;
@property (weak, nonatomic) IBOutlet FITButton *fFifteenDynamicBtn1;
@property (weak, nonatomic) IBOutlet FITButton *fFifteenDynamicBtn2;
@property (weak, nonatomic) IBOutlet FITButton *startBtn;
@property (strong, nonatomic) IBOutletCollection(FITButton) NSArray *buttons;

@property bool isCreateNewProgram;

@property (weak, nonatomic) IBOutlet UIImageView *fFifteenDynamicImg1;
@property (weak, nonatomic) IBOutlet UIImageView *fFifteenDynamicImg2;
@property (weak, nonatomic) IBOutlet UILabel *fFifteenDynamicLbl1;
@property (weak, nonatomic) IBOutlet UILabel *fFifteenDynamicLbl2;

@end
