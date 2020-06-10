//
//  JYGraphPoint.m
//  FIT
//
//  Created by Hamid Mehmood on 16/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "JYGraphPoint.h"

#import "JYGraphPoint.h"

@implementation JYGraphPoint

@synthesize strokeColour, fillColour;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    const CGFloat radius = 0.1;
    const CGFloat lineWidth = 8;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, lineWidth / 2, lineWidth / 2)
                                                    cornerRadius:radius];
    
    //    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    //    path.lineWidth = lineWidth;
    //    [path stroke];
    
    CGContextSetFillColorWithColor(context, fillColour.CGColor);
    [path fill];
    
}

//- (void) drawRect:(CGRect)rect
//{
//
//    //// Color Declarations
//    UIColor* stroke = strokeColour;
//    UIColor* fill = fillColour;
//
//    //// Oval 2 Drawing
//    UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(2, 2, 16, 16)];
//    [fill setFill];
//    [oval2Path fill];
//    [stroke setStroke];
//    oval2Path.lineWidth = 2.5;
//    [oval2Path stroke];
//}


@end
