//
//  FITProgressSegueView.h
//  FIT
//
//  Created by Bruce Cresanta on 3/19/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FITProgressSegueItem.h"
@interface FITProgressSegueView : UIView

@property (readonly) NSMutableArray* progressItems;
@property (readonly) int numItems;
@property (readonly) int currentMaxItems;
@property (readwrite,assign)  UIColor* progressStrokeLineColor;

-(void) drawRect:(CGRect)rect;
-(void) setAndDisplayNumItems:(int) numitems spacing:(CGFloat) spacebetween;
-(void) setActiveItem:(int) item;

@end
