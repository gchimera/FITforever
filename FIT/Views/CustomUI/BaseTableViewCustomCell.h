//
//  BaseTableViewCell.h
//  FIT
//
//  Created by Bruce Cresanta on 3/19/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"


@interface BaseTableViewCustomCell : BaseTableViewCell

- (void)programButtonUpdate:(UIButton *)button
                 buttonMode:(int)buttonMode
                  inSection:(NSString *)section
                     forKey:(NSString *)key
                  withColor:(UIColor *) color;

- (void)programButtonUpdate:(UIButton *)button
                 buttonMode:(int)buttonMode
                  inSection:(NSString *)section
                     forKey:(NSString *)key;

- (void)programImageUpdate:(UIImageView *)imageView
             withImageName:(NSString *)imageName;

- (void)programButtonImageUpdate:(UIButton *)buttonImage
                   withImageName:(NSString *)imageName;

- (void)programLabelColor:(UILabel *)label;

- (void)programLabelColor:(UILabel *)label
                inSection:(NSString *)section
                   forKey:(NSString *)key;


@end
