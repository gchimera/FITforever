//
//  ShareCodeViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 20/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface ShareCodeViewController : ProgramBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *shareCodeTitle;
@property (weak, nonatomic) IBOutlet UILabel *shareCodeDetail;
@property (weak, nonatomic) IBOutlet UILabel *yourShareCode;
@property (weak, nonatomic) IBOutlet UILabel *shareCode;
@property (weak, nonatomic) IBOutlet UILabel *GroupNameLabrl;
@property (weak, nonatomic) IBOutlet UITextField *groupName;

@property (weak, nonatomic) IBOutlet FITButton *sendInvite;
@property (weak, nonatomic) IBOutlet FITButton *startProgram;

@property (weak, nonatomic) IBOutlet UIImageView *topShapes;
@property (weak, nonatomic) IBOutlet UIImageView *bottomShapes;
@end
