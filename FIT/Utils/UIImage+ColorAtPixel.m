//
//  UIImage+ColorAtPixel.m
//  FIT
//
//  Created by Hamid Mehmood on 02/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//


#import <CoreGraphics/CoreGraphics.h>
#import "UIImage+ColorAtPixel.h"

@implementation UIImage (ColorAtPixel)

/*
 Returns the color of the image pixel at point. Returns nil if point lies outside the image bounds.
 If the point coordinates contain decimal parts, they will be truncated.
 
 To get at the pixel data, this method must draw the image into a bitmap context.
 For minimal memory usage and optimum performance, only the specific requested
 pixel is drawn.
 If you need to query pixel colors for the same image repeatedly (e.g., in a loop),
 this approach is probably less efficient than drawing the entire image into memory
 once and caching it.
 */
- (UIColor *)colorAtPixel:(CGPoint)point
{
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)) {
        return nil;
    }
    
    // Create a 1x1 pixel byte array and bitmap context to draw the pixel into.
    // Reference: http://stackoverflow.com/questions/1042830/retrieving-a-pixel-alpha-value-for-a-uiimage
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.CGImage;
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (UIImage *)returnImageWithColor:(UIColor*)color andFrame:(CGRect)frame  rotate:(BOOL)rotate
{
    UIImage *img = [UIImage new];
    
    float offset = 1.0f;
    float hexWidth = frame.size.width - offset;
    float hexHeight = frame.size.height - offset;
    
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGMutablePathRef p = CGPathCreateMutable() ;
    
    if (!rotate)
    {
        CGPathMoveToPoint( p, NULL,  hexWidth * 0.5, 0.0 );
        CGPathAddLineToPoint( p, NULL, hexWidth, hexHeight * 0.25);
        CGPathAddLineToPoint( p, NULL, hexWidth, hexHeight * 0.75);
        CGPathAddLineToPoint( p, NULL, hexWidth * 0.5, hexHeight);
        CGPathAddLineToPoint( p, NULL, 0.0, hexHeight * 0.75);
        CGPathAddLineToPoint( p, NULL, 0.0, hexHeight * 0.25);
        CGPathCloseSubpath( p );
    }
    else
    {
        CGPathMoveToPoint( p, NULL,  hexWidth * 0.1, 0.0 ) ;
        CGPathAddLineToPoint( p, NULL, hexWidth * 0.9, 0.0);
        CGPathAddLineToPoint( p, NULL, hexWidth, hexHeight * 0.5);
        CGPathAddLineToPoint( p, NULL, hexWidth * 0.9, hexHeight);
        CGPathAddLineToPoint( p, NULL, hexWidth * 0.1, hexHeight);
        CGPathAddLineToPoint( p, NULL, 0.0, hexHeight * 0.5);
        CGPathCloseSubpath( p );
    }
    
    
    CGContextAddPath(context, p);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillPath(context);
    CGPathRelease( p ) ;
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
    
}



@end
