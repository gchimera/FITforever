//
//  WaterIntakeViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface WaterIntakeViewController : ProgramBaseViewController

@property (weak, nonatomic) IBOutlet FITButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *arrowBtn;
@property (weak, nonatomic) IBOutlet UIButton *arrowDown;
@property (weak, nonatomic) IBOutlet UIButton *increaseArrowInGlass;


@property (weak, nonatomic) IBOutlet UILabel *informationIncreasing;
@property (weak, nonatomic) IBOutlet UILabel *informationHowTo;
@property (weak, nonatomic) IBOutlet UILabel *titlePage;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UILabel *remainingWaterLbl;
@property (weak, nonatomic) IBOutlet UILabel *approxLbl;
@property (weak, nonatomic) IBOutlet UIImageView *glassTickCompleteImage;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *waterPart;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *approxBottomConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *glassImageView;


@end
