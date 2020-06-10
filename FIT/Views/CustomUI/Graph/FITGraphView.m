//
//  FITGraphView.m
//  FIT
//
//  Created by Hamid Mehmood on 16/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "FITGraphView.h"
#import "JYGraphPoint.h"

NSUInteger const kGapBetweenBackgroundVerticalBars = 4;
NSInteger const kPointLabelOffsetFromPointCenter = 20;
NSInteger const kBarLabelHeight = 20;
NSInteger const kPointLabelHeight = 20;

@interface FITGraphView ()

@property (nonatomic, strong) UIView *graphView;

@end

@implementation FITGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if ([self.graphData count] > 0 && newSuperview != nil) {
        [self plotGraphData];
    }
}

- (void)setDefaultValues
{
    // Set defaults values/options if none are set
    if (!_strokeColor) {
        _strokeColor = self.strokeColor;
    }
    if (!_pointFillColor) {
        _pointFillColor = self.pointFillColor;
    }
    if (!self.graphWidth) {
        self.graphWidth = self.frame.size.width * 2;
    }
    if (!self.backgroundViewColor) {
        self.backgroundViewColor = [UIColor whiteColor];
    }
    if (!self.barColor) {
        self.barColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"line.png"]]; //[UIColor whiteColor];// [UIColor colorWithRed:0.05f green:0.05f blue:0.05f alpha:1.0f];
    }
    if (!self.labelFont) {
        self.labelFont = [UIFont fontWithName:@"Futura-Medium" size:12];
    }
    if (!self.labelFontColor) {
        self.labelFontColor = [UIColor whiteColor];
    }
    if (!self.labelXFont) {
        self.labelXFont = self.labelFont;
    }
    if (!self.labelXFontColor) {
        self.labelXFontColor = self.labelFontColor;
    }
    if (!self.labelBackgroundColor) {
        self.labelBackgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.5f];
    }
    if (!self.strokeWidth) {
        self.strokeWidth = 1;
    }
}

#pragma mark - Graph plotting

- (void)plotGraphData
{
    self.userInteractionEnabled = YES;
    [self setDefaultValues];
    
    self.graphView = [[UIView alloc] initWithFrame:self.frame];
    self.backgroundColor = self.backgroundViewColor;
    [self setContentSize:CGSizeMake(self.graphWidth, self.frame.size.height)];
    [self addSubview:_graphView];
    
    NSInteger xCoordOffset = (self.graphWidth / [_graphData count]) / 2;
    [_graphView setFrame:CGRectMake(0 - xCoordOffset, 0, self.graphWidth, self.frame.size.height)];
    
    NSMutableArray *pointsCenterLocations = [[NSMutableArray alloc] init];
    
    NSDictionary *graphRange = [self workOutRangeFromArray:_graphData];
    NSInteger range = [[graphRange objectForKey:@"range"] integerValue];
    NSInteger lowest = [[graphRange objectForKey:@"lowest"] integerValue];
    NSInteger highest = [[graphRange objectForKey:@"highest"] integerValue];
    
    // in case all numbers are zero or all the same value
    if (range == 0) {
        lowest = 0;
        if (highest == 0) highest = 10; //arbitary number in case all numbers are 0
        range = highest * 2;
    }
    
    CGPoint lastPoint = CGPointMake(0, 0);
    
    for (NSUInteger counter = 1; counter <= [_graphData count]; counter++) {
        
        NSInteger xCoord = (self.graphWidth / [_graphData count]) * counter;
        
        NSInteger offsets = kPointLabelHeight + kPointLabelOffsetFromPointCenter;
        if (_hideLabels == NO && _graphDataLabels != nil) {
            offsets += kBarLabelHeight;
        }
        
        NSInteger offSetFromTop = 5;
        NSInteger offsetFromBottom = 5;
        float screenHeight = (self.frame.size.height - (offsets)) / (self.frame.size.height + offSetFromTop + offsetFromBottom+10);
        
        //        CGPoint point = CGPointMake(xCoord,
        //                                    self.frame.size.height - (([[_graphData objectAtIndex:counter - 1] integerValue] *
        //                                                               ((self.frame.size.height) / range)) -
        //                                                              (lowest * ((self.frame.size.height ) / range ))+
        //                                                              offsetFromBottom+10));
        
        CGPoint point = CGPointMake(xCoord,
                                    self.frame.size.height - (([[_graphData objectAtIndex:counter - 1] integerValue] *
                                                               ((self.frame.size.height * screenHeight) / range)) -
                                                              (lowest * ((self.frame.size.height * screenHeight) / range ))+
                                                              offsetFromBottom));
        
        [self createBackgroundVerticalBarWithXCoord:point withXAxisLabelIndex:counter-1];
        
        if (self.hideLabels == NO) {
            [self createPointLabelForPoint:point withLabelText:[NSString stringWithFormat:@"%@",[_graphData objectAtIndex:counter - 1]]];
        }
        
        if (self.useCurvedLine == NO) {
            // Check it's not the first item
            if (lastPoint.x != 0) {
                if (!self.hideLines) {
                    [self drawLineBetweenPoint:lastPoint andPoint:point withColour:_strokeColor];
                }
            }
        }
        
        NSValue *pointValue = [[NSValue alloc] init];
        pointValue = [NSValue valueWithCGPoint:point];
        [pointsCenterLocations addObject:pointValue];
        lastPoint = point;
    }
    
    
    
    // Now draw all the points
    if (self.hidePoints == NO) {
        [self drawPointswithStrokeColour:_strokeColor
                                 andFill:_pointFillColor
                               fromArray:pointsCenterLocations];
    }
    
}

- (NSDictionary *)workOutRangeFromArray:(NSArray *)array
{
    array = [array sortedArrayUsingSelector:@selector(compare:)];
    
    float lowest = [[array objectAtIndex:0] floatValue];
    
    float highest = [[array objectAtIndex:[array count] - 1] floatValue];
    
    float range = highest - lowest;
    
    NSDictionary *graphRange = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithFloat:lowest], @"lowest",
                                [NSNumber numberWithFloat:highest], @"highest",
                                [NSNumber numberWithFloat:range], @"range", nil];
    
    return graphRange;
}

#pragma mark - Drawing methods

- (void)createPointLabelForPoint:(CGPoint)point
                   withLabelText:(NSString *)string
{
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(point.x , point.y, 30, kPointLabelHeight)];
    tempLabel.textAlignment = NSTextAlignmentCenter;
    [tempLabel setTextColor:self.labelFontColor];
    [tempLabel setBackgroundColor:self.labelBackgroundColor];
    [tempLabel setFont:self.labelFont];
    [tempLabel setAdjustsFontSizeToFitWidth:YES];
    [tempLabel setMinimumScaleFactor:0.6];
    [_graphView addSubview:tempLabel];
    [tempLabel setCenter:CGPointMake(point.x, point.y - kPointLabelOffsetFromPointCenter)];
    [tempLabel setText:string];
}

- (void)createBackgroundVerticalBarWithXCoord:(CGPoint)xCoord
                          withXAxisLabelIndex:(NSInteger)indexNumber
{
    CGFloat x = self.graphWidth % _graphData.count;
    
    // Update the frame size for graphData.count results that don't fit into graphWidth
    [self setContentSize:CGSizeMake(self.graphWidth - x, self.frame.size.height)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0 , 0, (self.graphWidth / [_graphData count]) - kGapBetweenBackgroundVerticalBars, self.frame.size.height * 2)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [label setTextColor:self.labelXFontColor];
    [label setBackgroundColor:self.barColor];
    [label setAdjustsFontSizeToFitWidth:YES];
    [label setMinimumScaleFactor:0.6];
    [label setFont:self.labelXFont];
    [label setNumberOfLines:2];
    
    if (self.graphDataLabels) {
        label.text = [NSString stringWithFormat:@"%@",[self.graphDataLabels objectAtIndex:indexNumber]];
    }
    
    [_graphView addSubview:label];
    
    [label setCenter:CGPointMake(xCoord.x,16)];
}

- (void)drawLineBetweenPoint:(CGPoint)origin
                    andPoint:(CGPoint)destination
                  withColour:(UIColor *)colour
{
    CAShapeLayer *lineShape = nil;
    CGMutablePathRef linePath = nil;
    linePath = CGPathCreateMutable();
    lineShape = [CAShapeLayer layer];
    
    lineShape.lineWidth = self.strokeWidth;
    lineShape.lineCap = kCALineCapRound;;
    lineShape.lineJoin = kCALineJoinBevel;
    
    lineShape.strokeColor = [colour CGColor];
    
    NSInteger x = origin.x; NSInteger y = origin.y;
    NSInteger toX = destination.x; NSInteger toY = destination.y;
    CGPathMoveToPoint(linePath, NULL, x, y);
    CGPathAddLineToPoint(linePath, NULL, toX, toY);
    
    lineShape.path = linePath;
    CGPathRelease(linePath);
    
    [_graphView.layer addSublayer:lineShape];
    
    lineShape = nil;
}


- (CGPoint)pointAtIndex:(NSUInteger)index ofArray:(NSArray *)array
{
    NSValue *value = [array objectAtIndex:index];
    
    return [value CGPointValue];
}

- (void)drawPointswithStrokeColour:(UIColor *)stroke
                           andFill:(UIColor *)fill
                         fromArray:(NSMutableArray *)pointsArray
{
    NSMutableArray *pointCenterLocations = pointsArray;
    
    for (int i = 0; i < [pointCenterLocations count]; i++) {
        CGRect pointRect = CGRectMake(0, 0, 20, 20);
        
        JYGraphPoint *point = [[JYGraphPoint alloc] initWithFrame:pointRect];
        
        [point setStrokeColour:stroke];
        [point setFillColour:fill];
        
        [point setCenter:[[pointCenterLocations objectAtIndex:i] CGPointValue]];
        
        [point setBackgroundColor:[UIColor clearColor]];
        
        [_graphView addSubview:point];
    }
}


- (float) screenScale {
    if ([ [UIScreen mainScreen] respondsToSelector: @selector(scale)] == YES) {
        return [ [UIScreen mainScreen] scale];
    }
    return 1;
}

@end
