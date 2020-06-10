//
//  FITButton.m
//  FIT
//
//  Created by Hamid Mehmood on 01/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "FITButton.h"

@interface FITButton ()

@property (nonatomic, assign) CGPoint previousTouchPoint;
@property (nonatomic, assign) BOOL previousTouchHitTestResponse;
@property (nonatomic, strong) UIImage *buttonImage;
@property (nonatomic, strong) UIImage *buttonBackground;

- (void)updateImageCacheForCurrentState;
- (void)resetHitTestCache;

@end

@implementation FITButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
}

- (void)setup
{
    [self updateImageCacheForCurrentState];
    [self resetHitTestCache];
}

#pragma mark - Hit testing

- (BOOL)isAlphaVisibleAtPoint:(CGPoint)point forImage:(UIImage *)image
{
    // Correct point to take into account that the image does not have to be the same size
    // as the button. See https://github.com/ole/OBShapedButton/issues/1
    CGSize iSize = image.size;
    CGSize bSize = self.bounds.size;
    point.x *= (bSize.width != 0) ? (iSize.width / bSize.width) : 1;
    point.y *= (bSize.height != 0) ? (iSize.height / bSize.height) : 1;
    
    UIColor *pixelColor = [image colorAtPixel:point];
    CGFloat alpha = 0.0;
    
    if ([pixelColor respondsToSelector:@selector(getRed:green:blue:alpha:)])
    {
        // available from iOS 5.0
        [pixelColor getRed:NULL green:NULL blue:NULL alpha:&alpha];
    }
    else
    {
        // for iOS < 5.0
        // In iOS 6.1 this code is not working in release mode, it works only in debug
        // CGColorGetAlpha always return 0.
        CGColorRef cgPixelColor = [pixelColor CGColor];
        alpha = CGColorGetAlpha(cgPixelColor);
    }
    return alpha >= kAlphaVisibleThreshold;
}


// UIView uses this method in hitTest:withEvent: to determine which subview should receive a touch event.
// If pointInside:withEvent: returns YES, then the subview’s hierarchy is traversed; otherwise, its branch
// of the view hierarchy is ignored.
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // Return NO if even super returns NO (i.e., if point lies outside our bounds)
    BOOL superResult = [super pointInside:point withEvent:event];
    if (!superResult) {
        return superResult;
    }
    
    // Don't check again if we just queried the same point
    // (because pointInside:withEvent: gets often called multiple times)
    if (CGPointEqualToPoint(point, self.previousTouchPoint)) {
        return self.previousTouchHitTestResponse;
    } else {
        self.previousTouchPoint = point;
    }
    
    BOOL response = NO;
    
    if (self.buttonImage == nil && self.buttonBackground == nil) {
        response = YES;
    }
    else if (self.buttonImage != nil && self.buttonBackground == nil) {
        response = [self isAlphaVisibleAtPoint:point forImage:self.buttonImage];
    }
    else if (self.buttonImage == nil && self.buttonBackground != nil) {
        response = [self isAlphaVisibleAtPoint:point forImage:self.buttonBackground];
    }
    else {
        if ([self isAlphaVisibleAtPoint:point forImage:self.buttonImage]) {
            response = YES;
        } else {
            response = [self isAlphaVisibleAtPoint:point forImage:self.buttonBackground];
        }
    }
    
    self.previousTouchHitTestResponse = response;
    return response;
}


#pragma mark - Accessors

// Reset the Hit Test Cache when a new image is assigned to the button
- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self updateImageCacheForCurrentState];
    [self resetHitTestCache];
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state
{
    [super setBackgroundImage:image forState:state];
    [self updateImageCacheForCurrentState];
    [self resetHitTestCache];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self updateImageCacheForCurrentState];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self updateImageCacheForCurrentState];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self updateImageCacheForCurrentState];
}


#pragma mark - Helper methods

- (void)updateImageCacheForCurrentState
{
    _buttonBackground = [self currentBackgroundImage];
    _buttonImage = [self currentImage];
}

- (void)resetHitTestCache
{
    self.previousTouchPoint = CGPointMake(CGFLOAT_MIN, CGFLOAT_MIN);
    self.previousTouchHitTestResponse = NO;
}

+ (UIImage *)returnImageWithColor:(UIColor*)color andFrame:(CGRect)frame  buttonMode:(int)modeNumber
{
    UIImage *img = [UIImage new];
    
    float offset = 1.0f;
    float hexWidth = frame.size.width - offset;
    float hexHeight = frame.size.height - offset;
    
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGMutablePathRef p = CGPathCreateMutable() ;
    
    
    switch (modeNumber) {
        case 1:
            CGPathMoveToPoint( p, NULL,  hexWidth * 0.5, 0.0 );
            CGPathAddLineToPoint( p, NULL, hexWidth, hexHeight * 0.25);
            CGPathAddLineToPoint( p, NULL, hexWidth, hexHeight * 0.75);
            CGPathAddLineToPoint( p, NULL, hexWidth * 0.5, hexHeight);
            CGPathAddLineToPoint( p, NULL, 0.0, hexHeight * 0.75);
            CGPathAddLineToPoint( p, NULL, 0.0, hexHeight * 0.25);
            CGPathCloseSubpath( p );
            break;
        case 2:
            CGPathMoveToPoint( p, NULL,  hexWidth * 0.25, 0.0 );
            CGPathMoveToPoint( p, NULL,  hexWidth * 0.75, 0.0 );
            CGPathAddLineToPoint( p, NULL, hexWidth, hexHeight * 0.50);
            CGPathAddLineToPoint( p, NULL, hexWidth * 0.75, hexHeight);
            CGPathAddLineToPoint( p, NULL, hexWidth * 0.25, hexHeight);
            CGPathAddLineToPoint( p, NULL, 0.0, hexHeight * 0.50);
            CGPathAddLineToPoint( p, NULL, hexWidth * 0.25, 0.0);
            CGPathCloseSubpath( p );
            break;
            
        case 3:
            CGPathMoveToPoint( p, NULL,  hexWidth * 0.03, 0.0 ) ;
            CGPathAddLineToPoint( p, NULL, hexWidth * 0.97, 0.0);
            CGPathAddLineToPoint( p, NULL, hexWidth, hexHeight * 0.5);
            CGPathAddLineToPoint( p, NULL, hexWidth * 0.97, hexHeight);
            CGPathAddLineToPoint( p, NULL, hexWidth * 0.03, hexHeight);
            CGPathAddLineToPoint( p, NULL, 0.0, hexHeight * 0.5);
            CGPathCloseSubpath( p );
            break;
        case 5:
            CGPathMoveToPoint( p, NULL,  hexWidth * 0.5, 0.0 );
            CGPathAddLineToPoint( p, NULL, hexWidth, hexHeight * 0.25);
            CGPathAddLineToPoint( p, NULL, hexWidth, hexHeight * 0.75);
            CGPathAddLineToPoint( p, NULL, hexWidth * 0.5, hexHeight);
            CGPathAddLineToPoint( p, NULL, 0.0, hexHeight * 0.75);
            CGPathAddLineToPoint( p, NULL, 0.0, hexHeight * 0.25);
            CGPathCloseSubpath( p );
            break;
            
        default:
            CGPathMoveToPoint( p, NULL,  0.0, 0.0 ) ;
            CGPathAddLineToPoint( p, NULL, (hexWidth - 17.0), 0.0);
            CGPathAddLineToPoint( p, NULL, hexWidth, hexHeight * 0.5);
            CGPathAddLineToPoint( p, NULL, (hexWidth - 17.0), hexHeight);
            CGPathAddLineToPoint( p, NULL, 0.0, hexHeight);
            CGPathCloseSubpath( p );
            break;
    }
    
    if(modeNumber == 5) {
        CGContextAddPath(context, p);
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextSetLineWidth(context, 1.0);
        CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:(221.0/255.0) green:(221.0/255.0) blue:(221.0/255.0) alpha:1] CGColor]);
        CGContextDrawPath(context, kCGPathFillStroke);
        CGContextFillPath(context);
    } else {
        CGContextAddPath(context, p);
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillPath(context);
    }
    
    
    
    
    CGPathRelease( p ) ;
    
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    
    return img;
    
}


+ (UIImage *)returnImageWithColor:(UIColor*)color andFrame:(CGRect)frame sizeNumber:(float)sizeNumber
{
    UIImage *img = [UIImage new];
    
    float offset = 1.0f;
    float hexWidth = frame.size.width - offset;
    float hexHeight = frame.size.height - offset;
    
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGMutablePathRef p = CGPathCreateMutable() ;
    
    //    if(sizeNumber <= 0.23) {
    //        CGPathMoveToPoint( p, NULL,  0.0, 0.0 ) ;
    //        CGPathAddLineToPoint( p, NULL, ((hexWidth * 0.05) + (hexWidth * 0.23) - 17.0), 0.0);
    //        CGPathAddLineToPoint( p, NULL, (hexWidth * 0.05) + hexWidth * 0.23, hexHeight * 0.5);
    //        CGPathAddLineToPoint( p, NULL, ((hexWidth * 0.05) + (hexWidth * 0.23) - 17.0), hexHeight);
    //        CGPathAddLineToPoint( p, NULL, 0.0, hexHeight);
    //        CGPathCloseSubpath( p );
    //    } else
    if(sizeNumber >= 1) {
        CGPathMoveToPoint( p, NULL,  0.0, 0.0 ) ;
        CGPathAddLineToPoint( p, NULL, ((hexWidth * 1.5) - 17.0), 0.0);
        CGPathAddLineToPoint( p, NULL, hexWidth * 1.5, hexHeight * 0.5);
        CGPathAddLineToPoint( p, NULL, ((hexWidth * 1.5) - 17.0), hexHeight);
        CGPathAddLineToPoint( p, NULL, 0.0, hexHeight);
        CGPathCloseSubpath( p );
    } else {
        CGPathMoveToPoint( p, NULL,  0.0, 0.0 ) ;
        CGPathAddLineToPoint( p, NULL, ((hexWidth * 0.15) + (hexWidth * sizeNumber) - 17.0), 0.0);
        CGPathAddLineToPoint( p, NULL, (hexWidth * 0.15) + (hexWidth * sizeNumber), hexHeight * 0.5);
        CGPathAddLineToPoint( p, NULL, ((hexWidth * 0.15) + (hexWidth * sizeNumber) - 17.0), hexHeight);
        CGPathAddLineToPoint( p, NULL, 0.0, hexHeight);
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
