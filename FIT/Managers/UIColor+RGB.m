//
//  UIColor+RGB.m
//  FIT
//
//  Created by Hamid Mehmood on 01/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "UIColor+RGB.h"

@implementation UIColor_RGB


+ (UIColor *)colorWithDecimalRGB:(int16_t)red green:(int16_t)green blue:(int16_t)blue {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}


+ (UIColor *)colorWithDecimalRGBAndAlpha:(int16_t)red green:(int16_t)green blue:(int16_t)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (UIColor *)colorWithHexRGB:(int32_t)rgbValue {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                            blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

+ (UIColor *)colorWithHexRGBAndAlpha:(int32_t)rgbValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                            blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha];
}

@end
