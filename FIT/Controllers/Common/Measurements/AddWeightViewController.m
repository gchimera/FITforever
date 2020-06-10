//
//  AddWeightViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 17/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "AddWeightViewController.h"
#import "AddCheastWaistViewController.h"
#import "mkunits.h"
#import "AppSettings.h"


@implementation AddWeightViewController
@synthesize pp;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settings = [AppSettings getAppSettings];
    
    self.valuesArray = [[NSMutableArray alloc] init];
    self.measurementDictionary = [[NSMutableDictionary alloc] init];
    [self.measurementDictionary setValue:@75 forKey:@"weight"];
    [[NSUserDefaults standardUserDefaults] setObject:@75 forKey:@"weight"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.count = 330;
    self.intero = 0;
    self.decim = 0;
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    [[self segueView] setAndDisplayNumItems:4 spacing:70];
    [[self segueView] setActiveItem:0];
    
    
    _weight.dataSource = self;
    _weight.delegate = self;
    _weight.selectionAlignment = LAPickerSelectionAlignmentCenter;
    _weight.tag = 2;
    
    
    if([self.currentCourse.courseType integerValue] == C9){
        [self.weight setBackgroundColor:[THM C9Color]];
        
    } else if ([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2){
        [self.weight setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
        
    } else if ([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        [self.weight setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
    } else if ([self.currentCourse.courseType integerValue] == F15Advance || [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2){
        [self.weight setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
        
    }
    
    [self programButtonUpdate:self.nextBtn buttonMode:3 inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_BUTTON_NEXT];
    [self programLabelColor:[self lblWeight]];
    [self programLabelColor:self.yourWeightLabel inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_LABEL_YOUR_WEIGHT];
    
    User *user = [User userInDB];
    
    if ([self.settings.wightType isEqual: @(LIBRA)])
    {
        MKQuantity* kg = [user.weight mass_pound];
        
        NSNumber *poundNumber = [NSNumber numberWithFloat:[[[kg convertTo:[MKMassUnit kilogram]] amountWithPrecision:0] floatValue]];
        
        self.integ = 75;
        _lblWeight.text = [NSString stringWithFormat:@"75 %@", [MKMassUnit pound].symbol];
        [_weight selectColumn:poundNumber.intValue inComponent:0 animated:YES];
        
    }
    else if ([self.settings.wightType isEqual: @(GRAMS)])
    {
        self.integ = 50;
        _lblWeight.text = [NSString stringWithFormat:@"50 %@", [MKMassUnit kilogram].symbol];
        [_weight selectColumn:user.weight.intValue inComponent:0 animated:YES];
        
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (IBAction)nextButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"gotoChestWaistVC" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AddCheastWaistViewController *chestWaistVC = [segue destinationViewController];
    chestWaistVC.measurementDictionary = self.measurementDictionary;
}

#pragma mark PICKERVIEW
- (NSInteger)numberOfComponentsInPickerView:(LAPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(LAPickerView *)pickerView numberOfColumnsInComponent:(NSInteger)component {
    return _count;
}

- (NSString *)pickerView:(LAPickerView *)pickerView titleForColumn:(NSInteger)column forComponent:(NSInteger)component {
    pp = [NSString stringWithFormat:@"%ld",(long)column];
    return pp;
}

- (void)pickerView:(LAPickerView *)pickerView didSelectColumn:(NSInteger)column inComponent:(NSInteger)component {
    DLog(@"Column:%ld",(long)column);
    NSUserDefaults* defaults= [NSUserDefaults standardUserDefaults];
    
    NSNumber *myNumber;
    NSString* unit;
    
    
    NSNumberFormatter *weightFromString = [[NSNumberFormatter alloc] init];
    weightFromString.numberStyle = NSNumberFormatterDecimalStyle;
    myNumber = [weightFromString numberFromString:[self.valuesArray objectAtIndex:column]];
    NSNumber *lbs;
    
    if ([self.settings.wightType integerValue] == LIBRA)
    {
        unit = @"gr";
        
        MKQuantity* kg = [myNumber mass_pound];
        
        lbs = [NSNumber numberWithFloat:[[[kg convertTo:[MKMassUnit kilogram]] amountWithPrecision:0] floatValue]];
        self.lblWeight.text = [NSString stringWithFormat:@"%@ %@",[self.valuesArray objectAtIndex:column],[MKMassUnit pound].symbol];
        
    } else {
        
        self.lblWeight.text = [NSString stringWithFormat:@"%@ %@",[self.valuesArray objectAtIndex:column],[MKMassUnit kilogram].symbol];
    }
    
    
    [self.measurementDictionary setValue:lbs forKey:@"weight"];
    [[NSUserDefaults standardUserDefaults] setObject:lbs forKey:@"weight"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [defaults setObject:lbs forKey:@"weight"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (UIView *)pickerView:(LAPickerView *)pickerView viewForColumn:(NSInteger)column forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    // interi
    
    FITRuler *aview = [[[NSBundle mainBundle] loadNibNamed:@"FITRuler" owner:self options:nil]objectAtIndex:0];
    //  aview.LB.text= [NSString stringWithFormat:@"%i",integ++];
    
    CGRect newFrame = CGRectMake( self.view.frame.origin.x, self.view.frame.origin.y, 30, self.weight.frame.size.height - 50);
    aview.frame = newFrame;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-20, 50, 50, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont fontWithName:@"SanFranciscoText-Regular" size:14]];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.text = [NSString stringWithFormat:@"%li",(long)self.integ++];
    [aview addSubview:label];
    
    
    [self.valuesArray addObject:label.text];
    
    self.intero+=1;
    self.decim=0;
    
    return aview;
}

-(NSNumber *)numberFromString:(NSString *)string
{
    if (string.length) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        return [f numberFromString:string];
    } else {
        return nil;
    }
}

-(NSString *)stringByFormattingString:(NSString *)string toPrecision:(NSInteger)precision
{
    NSNumber *numberValue = [self numberFromString:string];
    
    if (numberValue) {
        NSString *formatString = [NSString stringWithFormat:@"%%.%ldf", (long)precision];
        return [NSString stringWithFormat:formatString, numberValue.floatValue];
    } else {
        /* return original string */
        return string;
    }
}

-(UILabel*)label:(LAPickerView *)pickerView viewForColumn:(NSInteger)column forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    return nil;
}


@end
