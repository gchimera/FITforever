//
//  ThemeManager.m
//  FIT
//
//  Created by Hamid Mehmood on 01/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager

static ThemeManager *sharedInstance;

+ (instancetype)getInstance {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [ThemeManager new];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    return self;
}

-(UIColor *)C9Color{
    return  [UIColor_RGB colorWithHexRGB:0x5c2684];
}

-(UIColor *)C9ColorFreeFoodSelected{
    return  [UIColor_RGB colorWithHexRGB:0x89528a];
}

-(UIColor *)F15BeginnerColor{
    return  [UIColor_RGB colorWithHexRGB:0x89bd24];
}

-(UIColor *)F15BeginnerColorWithSixtyPercentAlpha{
    return  [UIColor_RGB colorWithHexRGBAndAlpha:0x89bd24 alpha:0.6];
}

-(UIColor *)F15BeginnerColorWithThirtyPercentAlpha{
    return  [UIColor_RGB colorWithHexRGBAndAlpha:0x89bd24 alpha:0.3];
}

-(UIColor *)F15IntermidiateColor{
    return  [UIColor_RGB colorWithHexRGB:0xf6a400];
}


-(UIColor *)F15IntermidiateColorWithSixtyPercentAlpha{
    return  [UIColor_RGB colorWithHexRGBAndAlpha:0xf6a400 alpha:0.6];
}

-(UIColor *)F15IntermidiateColorWithThirtyPercentAlpha{
    return  [UIColor_RGB colorWithHexRGBAndAlpha:0xf6a400 alpha:0.3];

}

-(UIColor *)F15AdvanceColor{
    return  [UIColor_RGB colorWithHexRGB:0xcc2e25];
}


-(UIColor *)F15AdvanceColorWithSixtyPercentAlpha{
    return  [UIColor_RGB colorWithHexRGBAndAlpha:0xcc2e25 alpha:0.6];
}

-(UIColor *)F15AdvanceColorWithThirtyPercentAlpha{
    return  [UIColor_RGB colorWithHexRGBAndAlpha:0xcc2e25 alpha:0.3];
    
}

-(UIColor *)V5Color{
    return  [UIColor_RGB colorWithHexRGB:0x009eb4];
}

-(UIColor *)BMColor{
    return  [UIColor_RGB colorWithHexRGB:0x57585a];
}

-(UIColor *)LoginFLP360ButtonColor{
    return  [UIColor_RGB colorWithHexRGB:0x89BD23];
}

-(UIColor *)LoginFBButtonColor{
    return  [UIColor_RGB colorWithHexRGB:0x009EB5];
}

-(UIColor *)LearnMoreButtonColor{
    return  [UIColor_RGB colorWithHexRGB:0x838383];
}

-(UIColor *)LoginButtonColor{
    return  [UIColor_RGB colorWithHexRGB:0x5C208A];
}

-(UIColor *)WhiteColor{
    return  [UIColor_RGB colorWithHexRGB:0xFFFFFF];
}

-(UIColor *)F15Beginner1Color{
    return  [UIColor_RGB colorWithHexRGB:0x89bd24];
}

-(UIColor *)F15Beginner2Color{
    return  [UIColor_RGB colorWithHexRGB:0xb288bd23];
}

-(UIColor *)F15Intermidiate1Color{
    return  [UIColor_RGB colorWithHexRGB:0xf9a31a];
}

-(UIColor *)F15Intermidiate2Color{
    return  [UIColor_RGB colorWithHexRGB:0xfbb44c];
}

-(UIColor *)F15Advance1Color{
    return  [UIColor_RGB colorWithHexRGB:0xce362f];
}

-(UIColor *)F15Advance2Color{
    return  [UIColor_RGB colorWithHexRGB:0xd6604c];
}

-(UIColor *)GreyColor{
    return  [UIColor_RGB colorWithHexRGB:0xD7D7D7];
}

-(UIColor *)F15BegginerColorDisable{
    return  [UIColor_RGB colorWithHexRGB:0xB2D06B];
}

-(UIColor *)F15IntermidiateColorDisable{
    return  [UIColor_RGB colorWithHexRGB:0xF4E3CD];
}

-(UIColor *)F15AdvanceColorDisable{
    return  [UIColor_RGB colorWithHexRGB:0xCD362E];
}

-(UIColor *)F15ExercisesNextDayColor{
    return  [UIColor_RGB colorWithHexRGB:0x57585a];
}

-(UIColor *)F15ExercisesTodayDayColor{
    return  [UIColor_RGB colorWithHexRGB:0x9989bd22];
}

-(UIColor *)F15ExercisesPastDayColor{
    return  [UIColor_RGB colorWithHexRGB:0x4c89bd22];
}

@end
