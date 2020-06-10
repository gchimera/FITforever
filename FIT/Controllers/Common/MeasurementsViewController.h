//
//  MeasurementsViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface MeasurementsViewController : ProgramBaseViewController

@property (weak, nonatomic) IBOutlet FITButton *measurementBtn;
@property (weak, nonatomic) IBOutlet FITButton *enterTodayBtn;
@property (weak, nonatomic) IBOutlet FITButton *reviewBrogressBtn;
@property (weak, nonatomic) IBOutlet UIImageView *personImgView;
@property (weak, nonatomic) IBOutlet FITButton *lbBtn;
@property (weak, nonatomic) IBOutlet FITButton *inBtn;

@property int day;
@property RLMResults *result;
@end
