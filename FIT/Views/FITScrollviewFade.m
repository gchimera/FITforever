//
//  FITScrollviewFade.m
//  FIT
//
//  Created by Hamid Mehmood on 16/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "FITScrollviewFade.h"
#import <QuartzCore/QuartzCore.h>

static float const fadePercentage = 0.4;

@implementation FITScrollviewFade

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

// ...

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSObject * transparent = (NSObject *) [[UIColor colorWithWhite:0 alpha:0] CGColor];
    NSObject * opaque = (NSObject *) [[UIColor colorWithWhite:0 alpha:1] CGColor];
    
    CALayer * maskLayer = [CALayer layer];
    maskLayer.frame = self.bounds;
    
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(self.bounds.origin.x, 0,
                                     self.bounds.size.width, self.bounds.size.height);
    
    //    gradientLayer.colors = [NSArray arrayWithObjects: transparent, opaque,
    //                            opaque, transparent, nil];
    //
    //    // Set percentage of scrollview that fades at top & bottom
    //    gradientLayer.locations = [NSArray arrayWithObjects:
    //                               [NSNumber numberWithFloat:0],
    //                               [NSNumber numberWithFloat:fadePercentage],
    //                               [NSNumber numberWithFloat:1.0 - fadePercentage],
    //                               [NSNumber numberWithFloat:1], nil];
    
    // Fade bottom of scrollview only
    gradientLayer.colors = [NSArray arrayWithObjects: opaque, transparent, nil];
    
    gradientLayer.locations = [NSArray arrayWithObjects: [NSNumber numberWithFloat:1.0 - fadePercentage],
                               [NSNumber numberWithFloat:1], nil];
    
    
    [maskLayer addSublayer:gradientLayer];
    self.layer.mask = maskLayer;
}

@end
