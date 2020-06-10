//
//  FITProgressSequeItem.m
//  FIT
//
//  Created by Bruce Cresanta on 3/19/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "FITProgressSegueItem.h"

@implementation FITProgressSegueItem


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void) drawRect:(CGRect)rect
{
    RLMResults *currentProgram = [UserCourse objectsWhere:@"status = %d",1];
    
    if([currentProgram count] > 0){
        self.selectedCourse = [[UserCourse alloc] init];
        self.selectedCourse = [currentProgram objectAtIndex:0];
    }
    
    if (_showActive)
    {
        [self programButtonImageUpdate:self withImageName:@"hexagonon"];
    }
    else{
        [self programButtonImageUpdate:self withImageName:@"hexagonoff"];
        
    }
    [self setHidden:NO];
    [self setEnabled:YES];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setBounds:frame];
    [self addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    return self;
    
}

-(IBAction) btnClicked:(id) sender
{
    NSLog(@"CLICKED");
}


-(void) setActive:(BOOL) active
{
    _showActive = active;
    [self setNeedsDisplay];
}

- (void)programButtonImageUpdate:(UIButton *)buttonImage
                   withImageName:(NSString *)imageName{
    
    if([self.selectedCourse.courseType integerValue] == C9) {
        imageName = [NSString stringWithFormat:@"%@C9",imageName];
    } else if([self.selectedCourse.courseType integerValue] == F15Begginner || [self.selectedCourse.courseType integerValue] == F15Begginner1 || [self.selectedCourse.courseType integerValue] == F15Begginner2) {
        imageName = [NSString stringWithFormat:@"%@F15B",imageName];
    } else if([self.selectedCourse.courseType integerValue] == F15Intermidiate || [self.selectedCourse.courseType integerValue] == F15Intermidiate1 || [self.selectedCourse.courseType integerValue] == F15Intermidiate2){
        imageName = [NSString stringWithFormat:@"%@F15I",imageName];
    } else if([self.selectedCourse.courseType integerValue] == F15Advance|| [self.selectedCourse.courseType integerValue] == F15Advance1 || [self.selectedCourse.courseType integerValue] == F15Advance2) {
        imageName = [NSString stringWithFormat:@"%@F15A",imageName];
    } else if ([self.selectedCourse.courseType integerValue] == V5) {
        imageName = [NSString stringWithFormat:@"%@V5",imageName];
    }
    
    [buttonImage setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}


@end
