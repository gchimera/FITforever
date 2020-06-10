//
//  C9ExercisesDetailViewController.h
//  FIT
//
//  Created by Bruce Cresanta on 3/17/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"


@interface C9ExercisesDetailViewController : ProgramBaseViewController

@property int day;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *descriptLB;
@property (weak, nonatomic) IBOutlet FITButton *doneBtn;

@property RLMResults *result;

@end
