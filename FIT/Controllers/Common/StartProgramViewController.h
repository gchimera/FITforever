//
//  StartProgramViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface StartProgramViewController : ProgramBaseViewController

@property UserCourseType *courseSelected;
@property (weak, nonatomic) IBOutlet UIImageView *topShapes;
@property (weak, nonatomic) IBOutlet UIImageView *bottomShapes;

@property (weak, nonatomic) IBOutlet FITButton *startNowBtn;
@property (weak, nonatomic) IBOutlet FITButton *setStartDateBtn;
@property (weak, nonatomic) IBOutlet FITButton *joinExistingProgram;

@property RLMResults *activeProgram;
@property (weak, nonatomic) IBOutlet UIImageView *mainProgramImage;
@property NSString *databaseProgramName;


@end
