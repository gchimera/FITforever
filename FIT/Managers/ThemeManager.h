//
//  ThemeManager.h
//  FIT
//
//  Created by Hamid Mehmood on 01/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "UIColor+RGB.h"
#import "ColorConstants.h"
#define THM [ThemeManager getInstance]

@interface ThemeManager : NSObject

@property (nonatomic, strong) UIColor *C9Color;
@property (nonatomic, strong) UIColor *C9ColorFreeFoodSelected;
@property (nonatomic, strong) UIColor *F15BeginnerColor;
@property (nonatomic, strong) UIColor *F15IntermidiateColor;
@property (nonatomic, strong) UIColor *F15AdvanceColor;
@property (nonatomic, strong) UIColor *V5Color;
@property (nonatomic, strong) UIColor *BMColor;
@property (nonatomic, strong) UIColor *LoginFLP360ButtonColor;
@property (nonatomic, strong) UIColor *LoginFBButtonColor;
@property (nonatomic, strong) UIColor *LearnMoreButtonColor;
@property (nonatomic, strong) UIColor *LoginButtonColor;
@property (nonatomic, strong) UIColor *WhiteColor;
@property (nonatomic, strong) UIColor *F15Beginner1Color;
@property (nonatomic, strong) UIColor *F15Beginner2Color;
@property (nonatomic, strong) UIColor *F15Intermidiate1Color;
@property (nonatomic, strong) UIColor *F15Intermidiate2Color;
@property (nonatomic, strong) UIColor *F15Advance1Color;
@property (nonatomic, strong) UIColor *F15Advance2Color;
@property (nonatomic, strong) UIColor *GreyColor;

@property (nonatomic, strong) UIColor *F15BegginerColorDisable;
@property (nonatomic, strong) UIColor *F15IntermidiateColorDisable;
@property (nonatomic, strong) UIColor *F15AdvanceColorDisable;

@property (nonatomic, strong) UIColor *F15ExercisesNextDayColor; 
@property (nonatomic, strong) UIColor *F15ExercisesTodayDayColor;
@property (nonatomic, strong) UIColor *F15ExercisesPastDayColor;


-(UIColor *)F15BeginnerColorWithSixtyPercentAlpha;
-(UIColor *)F15BeginnerColorWithThirtyPercentAlpha;
-(UIColor *)F15IntermidiateColorWithSixtyPercentAlpha;
-(UIColor *)F15IntermidiateColorWithThirtyPercentAlpha;
-(UIColor *)F15AdvanceColorWithSixtyPercentAlpha;
-(UIColor *)F15AdvanceColorWithThirtyPercentAlpha;





+ (instancetype)getInstance;

@end
