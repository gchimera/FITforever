//
//  PortionSizeViewController.h
//  FIT
//
//  Created by Hadi Roohian on 28/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface PortionSizeViewController : ProgramBaseViewController


@property (weak, nonatomic) IBOutlet FITButton *closeBtn;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet FITButton *backgroundHexBtn1;
@property (weak, nonatomic) IBOutlet FITButton *backgroundHexBtn2;
@property (weak, nonatomic) IBOutlet FITButton *backgroundHexBtn3;
@property (weak, nonatomic) IBOutlet FITButton *backgroundHexBtn4;

- (IBAction)closeBtnTapped:(id)sender;
- (IBAction)drawerToggle:(id)sender;



@end
