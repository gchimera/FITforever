//
//  UIColor+RGB.h
//  FIT
//
//  Created by Hamid Mehmood on 01/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor_RGB : NSObject

+ (UIColor *)colorWithDecimalRGB:(int16_t)red green:(int16_t)green blue:(int16_t)blue;
+ (UIColor *)colorWithDecimalRGBAndAlpha:(int16_t)red green:(int16_t)green blue:(int16_t)blue alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexRGB:(int32_t)rgbValue;
+ (UIColor *)colorWithHexRGBAndAlpha:(int32_t)rgbValue alpha:(CGFloat)alpha;

@end
