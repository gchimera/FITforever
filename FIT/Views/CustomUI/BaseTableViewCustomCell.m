//
//  BaseTableViewCell.m
//  FIT
//
//  Created by Bruce Cresanta on 3/19/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseTableViewCustomCell.h"

@implementation BaseTableViewCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)programButtonUpdate:(UIButton *)button
                 buttonMode:(int)buttonMode
                  inSection:(NSString *)section
                     forKey:(NSString *)key
                  withColor:(UIColor *) color {
    [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:color];
}

- (void)programImageUpdate:(UIImageView *)imageView
             withImageName:(NSString *)imageName {
    if([self.currentCourse.courseType integerValue] == C9) {
        imageName = [NSString stringWithFormat:@"%@C9",imageName];
        [imageView setImage:[UIImage imageNamed:imageName]];
    } else if([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2) {
        imageName = [NSString stringWithFormat:@"%@F15B",imageName];
        [imageView setImage:[UIImage imageNamed:imageName]];
    } else if([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        imageName = [NSString stringWithFormat:@"%@F15I",imageName];
        [imageView setImage:[UIImage imageNamed:imageName]];
    } else if([self.currentCourse.courseType integerValue] == F15Advance|| [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2) {
        imageName = [NSString stringWithFormat:@"%@F15A",imageName];
        [imageView setImage:[UIImage imageNamed:imageName]];
    } else if ([self.currentCourse.courseType integerValue] == V5) {
        imageName = [NSString stringWithFormat:@"%@V5",imageName];
        [imageView setImage:[UIImage imageNamed:imageName]];
    }
    
}

- (void)programButtonImageUpdate:(UIButton *)buttonImage
                   withImageName:(NSString *)imageName{
    if([self.currentCourse.courseType integerValue] == C9) {
        imageName = [NSString stringWithFormat:@"%@C9",imageName];
    } else if([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2) {
        imageName = [NSString stringWithFormat:@"%@F15B",imageName];
    } else if([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        imageName = [NSString stringWithFormat:@"%@F15I",imageName];
    } else if([self.currentCourse.courseType integerValue] == F15Advance|| [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2) {
        imageName = [NSString stringWithFormat:@"%@F15A",imageName];
    } else if ([self.currentCourse.courseType integerValue] == V5) {
        imageName = [NSString stringWithFormat:@"%@V5",imageName];
    }
    
    [buttonImage setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)programLabelColor:(UILabel *)label {
    
    if([self.currentCourse.courseType integerValue] == C9){
        [label setTextColor:[THM C9Color]];
    } else if([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2){
        [label setTextColor:[THM F15BeginnerColor]];
    } else if([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        [label setTextColor:[THM F15IntermidiateColor]];
    } else if([self.currentCourse.courseType integerValue] == F15Advance|| [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2) {
        [label setTextColor:[THM F15AdvanceColor]];
    } else if ([self.currentCourse.courseType integerValue] == V5) {
        [label setTextColor:[THM V5Color]];
    }
}

- (void)programLabelColor:(UILabel *)label
                inSection:(NSString *)section
                   forKey:(NSString *)key{
    [label setText:[self localisedStringForSection:section andKey:key]];
    if([self.currentCourse.courseType integerValue] == C9){
        [label setTextColor:[THM C9Color]];
    } else if([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2){
        [label setTextColor:[THM F15BeginnerColor]];
    } else if([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        [label setTextColor:[THM F15IntermidiateColor]];
    } else if([self.currentCourse.courseType integerValue] == F15Advance|| [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2) {
        [label setTextColor:[THM F15AdvanceColor]];
    } else if ([self.currentCourse.courseType integerValue] == V5) {
        [label setTextColor:[THM V5Color]];
    }
    
}

- (void)programButtonUpdate:(UIButton *)button
                 buttonMode:(int)buttonMode
                  inSection:(NSString *)section
                     forKey:(NSString *)key {
    if([self.currentCourse.courseType integerValue] == C9){
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[THM C9Color]];
    } else if([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2){
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[THM F15BeginnerColor]];
    } else if([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[THM F15IntermidiateColor]];
    } else if([self.currentCourse.courseType integerValue] == F15Advance || [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2) {
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[THM F15AdvanceColor]];
    } else if ([self.currentCourse.courseType integerValue] == V5) {
        [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:[THM V5Color]];
    }
}





@end
