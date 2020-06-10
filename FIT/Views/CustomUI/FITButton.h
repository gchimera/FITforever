//
//  FITButton.h
//  FIT
//
//  Created by Hamid Mehmood on 01/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+ColorAtPixel.h"

/*
 OBShapedButton is a UIButton subclass optimized for non-rectangular button shapes.
 Instances of OBShapedButton respond to touches only in areas where the image that is
 assigned to the button for UIControlStateNormal is non-transparent.
 */

// -[UIView hitTest:withEvent: ignores views that an alpha level less than 0.1.
// So we will do the same and treat pixels with alpha < 0.1 as transparent.
#define kAlphaVisibleThreshold (0.1f)

@interface FITButton : UIButton

+ (UIImage *)returnImageWithColor:(UIColor*)color andFrame:(CGRect)frame  buttonMode:(int)modeNumber;
+ (UIImage *)returnImageWithColor:(UIColor*)color andFrame:(CGRect)frame sizeNumber:(float)sizeNumber;

// Class interface is empty. OBShapedButton does not add new public methods.
@end
