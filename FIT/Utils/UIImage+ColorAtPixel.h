//
//  UIImage+ColorAtPixel.h
//  FIT
//
//  Created by Hamid Mehmood on 02/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 A category on UIImage that enables you to query the color value of arbitrary
 pixels of the image.
 */

@interface UIImage (ColorAtPixel)

- (UIColor *)colorAtPixel:(CGPoint)point;

/*!
 * @discussion Generate Hexagon Image for the app buttons
 * @param color UIColor to fill the shape
 * @param frame CGRect for the image size
 * @param rotate BOOL to change between square buttons and long rectangle buttons (rotate = YES)
 * @return UIImage with the hexagon filled with the passed color
 */
- (UIImage *)returnImageWithColor:(UIColor*)color andFrame:(CGRect)frame rotate:(BOOL)rotate;

@end
