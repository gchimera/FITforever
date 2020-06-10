//
//  FreeFoodViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface FreeFoodViewController : ProgramBaseViewController
@property (weak, nonatomic) IBOutlet FITButton *freeFoodsBtn;
@property (weak, nonatomic) IBOutlet FITButton *oneServingBtn;
@property (weak, nonatomic) IBOutlet FITButton *twoServingBtn;
@property (weak, nonatomic) IBOutlet UILabel *categoryDescriptionLbl;


@end
