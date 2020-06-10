//
//  FITAwardsItemVC.h
//  fitapp
//
//  Created by Hadi Roohian on 30/12/2016.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgramBaseViewController.h"

@interface FITAwardsItemVC : ProgramBaseViewController
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet FITButton *awardButton;
@property (weak, nonatomic) IBOutlet UILabel *awardTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *awardSubTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgShare;

@property NSDictionary *awardDetails;

@property (weak, nonatomic) NSString *achived;



- (IBAction)drawerToggle:(id)sender;
@end
