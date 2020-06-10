//
//  FITProgressSegueView.m
//  FIT
//
//  Created by Bruce Cresanta on 3/19/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "FITProgressSegueView.h"

@implementation FITProgressSegueView
@synthesize progressStrokeLineColor;

-(id) initWithFrame:(CGRect) frame {
    self = [super initWithFrame:frame];
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self setUserInteractionEnabled:YES];
    
    
    _progressItems = [[NSMutableArray alloc] init];
    NSLog(@"Bounds %f %f %f %f",self.bounds.origin.x,self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
    [self setNeedsDisplay];
}



-(void) setAndDisplayNumItems:(int) numitems spacing:(CGFloat) spacebetween {
    _numItems = numitems;
    for (int i = 0; i < _progressItems.count;i++){
        [[_progressItems objectAtIndex:i] removeFromSuperview];
    }
    
    //        FITProgressSegueItem* thisitem;
    //        CGFloat thisItemLeft = 0;
    //        for (int i = 0; i < numitems;i++)
    //        {
    //            thisitem = [[FITProgressSegueItem alloc] initWithFrame:CGRectMake(0,0,24, 28)];
    //            [_progressItems addObject:thisitem];
    //            CGRect itemRect = [thisitem bounds];
    //            CGFloat totalItemWidth = itemRect.size.width * numitems;
    //            CGFloat totalSpacing = spacebetween * (numitems - 1);
    //            CGFloat startLayout = ([self bounds].size.width - (totalItemWidth + totalSpacing))/2 ;
    //            CGFloat verticalPosition = self.bounds.size.height/2 - itemRect.size.height/2;
    //            thisItemLeft = (startLayout) + (spacebetween+itemRect.size.width) *i;
    //            [thisitem setFrame:CGRectMake(thisItemLeft, verticalPosition, [thisitem bounds].size.width, [thisitem bounds].size.height)];
    //            [thisitem setUserInteractionEnabled:YES];
    //            [self addSubview:thisitem];
    //
    //        }
    
    //
    CGRect theFrame = CGRectMake(0,0,24, 28);
    
    float y = 0;
    
    float width = theFrame.size.width;
    
    float gap = ([self bounds].size.width - (numitems * width)) / (numitems + 1);
    
    float height = theFrame.size.height;
    
    for (int n = 0; n < _numItems; n++) {
        FITProgressSegueItem* thisitem = [[FITProgressSegueItem alloc] init];
        
        float x = spacebetween * (n+1) + width * n;
        [thisitem setFrame:CGRectMake(x,y,width,height)];
        [thisitem setUserInteractionEnabled:YES];
        [_progressItems addObject:thisitem];
        [self addSubview:thisitem];
    }
}

-(void) setActiveItem:(int) itemnum {
    FITProgressSegueItem* it = [_progressItems objectAtIndex:itemnum];
    [it setActive:YES];
}

- (void)drawRect:(CGRect)rect {
    CGFloat verticaloffset = [self bounds].size.height / 2;
    CGFloat width = [self bounds].size.width;
    
    UIColor *color = [THM C9Color];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UserCourse* course = [UserCourse currentProgram];
    if([course courseType] == C9) {
        color = [THM C9Color];
    } else if ([[course courseType] unsignedIntegerValue] == F15Begginner || [[course courseType] unsignedIntegerValue] == F15Begginner1 || [[course courseType] unsignedIntegerValue]  == F15Begginner2) {
        color = [THM F15BeginnerColor];
    } else if ([[course courseType] unsignedIntegerValue]  == F15Intermidiate ||[[course courseType] unsignedIntegerValue]  == F15Intermidiate1 || [[course courseType] unsignedIntegerValue]  == F15Intermidiate2) {
        color = [THM F15IntermidiateColor];
    } else if ([[course courseType] unsignedIntegerValue]  == F15Advance ||  [[course courseType] unsignedIntegerValue]  == F15Advance1 || [[course courseType] unsignedIntegerValue]  == F15Advance2) {
        color = [THM F15AdvanceColor];
    }
    
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context,1.0);
    CGContextMoveToPoint(context,0, verticaloffset);
    CGContextAddLineToPoint(context, width, verticaloffset);
    CGContextStrokePath(context);
    
}

@end
