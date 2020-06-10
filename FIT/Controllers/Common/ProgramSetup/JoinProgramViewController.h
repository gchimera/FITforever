//
//  JoinProgramViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 20/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface JoinProgramViewController : ProgramBaseViewController
@property UserCourseType *courseSelected;

@property (weak, nonatomic) IBOutlet UILabel *titleJoinProgram;
@property (weak, nonatomic) IBOutlet UILabel *descriptionJoinProgam;
@property (weak, nonatomic) IBOutlet UILabel *yourShareCode;
@property (weak, nonatomic) IBOutlet UITextField *shareCode;
@property (weak, nonatomic) IBOutlet FITButton *joinProgram;

@property (weak, nonatomic) IBOutlet UIImageView *topShapes;
@property (weak, nonatomic) IBOutlet UIImageView *bottomShapes;

@property RLMResults *activeProgram;
@end
