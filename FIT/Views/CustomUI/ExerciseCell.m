//
//  ExerciseCell.m
//  FIT
//
//  Created by Bruce Cresanta on 3/20/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ExerciseCell.h"

@implementation ExerciseCell



@synthesize excerciseImageView;
@synthesize excerciseLabel;



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //    [self updateUI:self.awardImage buttonMode:1];
    
    [self programImageUpdate:[self excerciseImageView] withImageName:@""];
    
    
    
//    [self programLabelColor:[self excerciseLabel]];
 
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
