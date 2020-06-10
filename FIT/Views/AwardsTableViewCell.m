//
//  AwardsTableViewCell.m
//  FIT
//
//  Created by Hamid Mehmood on 16/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "AwardsTableViewCell.h"

@implementation AwardsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self programButtonUpdate:self.awardImage buttonMode:1 inSection:@"" forKey:@""];
    
    [self programLabelColor:self.awardTitle];
    [self programLabelColor:self.awardDesc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
