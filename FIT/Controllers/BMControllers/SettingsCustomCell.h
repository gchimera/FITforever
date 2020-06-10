//
//  SettingsCustomCell.h
//  FIT
//
//  Created by Guglielmo Chimera on 20/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cityLB;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property IBOutlet UIImageView *tick2;

@end
