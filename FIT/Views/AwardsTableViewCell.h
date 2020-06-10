//
//  AwardsTableViewCell.h
//  FIT
//
//  Created by Hamid Mehmood on 16/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCustomCell.h"

@interface AwardsTableViewCell : BaseTableViewCustomCell
@property (weak, nonatomic) IBOutlet FITButton *awardImage;
@property (weak, nonatomic) IBOutlet UILabel *awardTitle;
@property (weak, nonatomic) IBOutlet UILabel *awardDesc;

@property NSString *awardImageName;
@property NSString *awardTitleModel;
@property NSString *awardDescModel;

@end
