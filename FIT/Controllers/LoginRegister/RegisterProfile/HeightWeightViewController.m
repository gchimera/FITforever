//
//  HeightWeightViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 13/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "HeightWeightViewController.h"

@interface HeightWeightViewController ()

@end

NSString* pp=@"";
int height;
NSMutableArray *heightArray;

int integWeight;
int interoWeight;
int decimWeight;
NSMutableArray *weightArray;
NSString* unitHeight;
NSString* unitWeight;

@implementation HeightWeightViewController

@synthesize scrollView1;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self languageAndButtonUIUpdate:self.nextBtn buttonMode:3 inSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE forKey:CONTENT_BUTTON_NEXT backgroundColor:[THM C9Color]];
    
    
    self.settings = [AppSettings getAppSettings];
    
    if ([self.settings.lenghtType integerValue ] == METERS) {
        unitHeight = [MKLengthUnit centimeter].symbol;
        lblHeight.text = [NSString stringWithFormat:@"- %@", [MKLengthUnit centimeter].symbol];
    } else if ([self.settings.lenghtType integerValue ] == INCHES) {
        unitHeight = [MKLengthUnit inch].symbol;
        lblHeight.text = [NSString stringWithFormat:@"- %@", [MKLengthUnit inch].symbol];
    }
    
    
    if ([self.settings.wightType integerValue] == LIBRA) {
        unitWeight = [MKMassUnit pound].symbol;
        lblWeight.text = [NSString stringWithFormat:@"- %@", [MKMassUnit pound].symbol];
    } else if ([self.settings.wightType integerValue] == GRAMS) {
        unitWeight = [MKMassUnit kilogram].symbol;
        lblWeight.text = [NSString stringWithFormat:@"- %@", [MKMassUnit kilogram].symbol];
        
    }
    
    heightArray = [[NSMutableArray alloc]init];
    weightArray = [[NSMutableArray alloc]init];
    interoWeight = 74;
    integWeight = 74;
    decimWeight = 0;
    height = 0;
    
    NSLog(@"Dicts object coming from first page: %@",self.registrationProfileDetails);
    
//    [self.registrationProfileDetails setValue:@140 forKey:@"height"];
//    [self.registrationProfileDetails setValue:@75 forKey:@"weight"];
//    [[NSUserDefaults standardUserDefaults] setObject:@140 forKey:@"height"];
//    [[NSUserDefaults standardUserDefaults] setObject:@75 forKey:@"weight"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    _height.dataSource = self;
    _weight.dataSource = self;
    
    _height.delegate = self;
    _weight.delegate = self;
    
    _height.selectionAlignment = LAPickerSelectionAlignmentCenter;
    _weight.selectionAlignment = LAPickerSelectionAlignmentCenter;
    
    _height.tag = 1;
    _weight.tag = 2;
    
    [[self segueView] setAndDisplayNumItems:3 spacing:80];
    [[self segueView] setActiveItem:0];
    [[self segueView] setActiveItem:1];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    interoWeight = 74;
    integWeight = 74;
    height = 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)nextBtnTapped:(id)sender {
    [self performSegueWithIdentifier:@"FITCreateProfileCompleteVC" sender:self.registrationProfileDetails];
}


#pragma mark PICKERVIEW HEIGHT


// Hide lines selection LAPickerView
- (NSInteger)numberOfComponentsInPickerView:(LAPickerView *)pickerView
{
    
    [pickerView.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        
        subview.hidden = (CGRectGetHeight(subview.frame) == 0.5);
    }];
    
    
    return 1;
}



-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if ([self.settings.lenghtType integerValue ] == METERS)
    {
        return 300;
    } else {
        return 150;
    }
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    //  Hide lines selection UIPickerView
    for(UIView *single in pickerView.subviews)
    {
        if (single.frame.size.height < 1)
        {
            single.backgroundColor = [UIColor clearColor];
        }
    }
    
    RulerPicker *aview = [[[NSBundle mainBundle] loadNibNamed:@"VerticalRuler" owner:self options:nil]objectAtIndex:0];
    [heightArray addObject:[NSString stringWithFormat:@"%d", height++]];
    aview.heightLB.text = [NSString stringWithFormat:@"%@ %@",[heightArray objectAtIndex:row],unitHeight] ;
    return aview;
}


// Picker cell Row Height

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {

    return 97;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSNumber *myNumber;
    
    NSNumberFormatter *heightFromString = [[NSNumberFormatter alloc] init];
    heightFromString.numberStyle = NSNumberFormatterDecimalStyle;
    myNumber = [heightFromString numberFromString:[heightArray objectAtIndex:row]];
    
    
    NSNumber *centimeter;
    
    if ([self.settings.lenghtType integerValue ] == METERS){
        lblHeight.text = [NSString stringWithFormat:@"%@ %@",myNumber, [MKLengthUnit centimeter].symbol];
        centimeter = myNumber;
    } else {
        
        MKQuantity* kg = [myNumber length_inch];
        centimeter = [NSNumber numberWithFloat:[[[kg convertTo:[MKLengthUnit centimeter]] amountWithPrecision:0] floatValue]];
        lblHeight.text = [NSString stringWithFormat:@"%@ %@",myNumber, [MKLengthUnit inch].symbol];
    }
    
    [self.registrationProfileDetails setValue:centimeter forKey:@"height"];
    [[NSUserDefaults standardUserDefaults] setObject:centimeter forKey:@"height"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


#pragma mark PICKERVIEW WEIGHT

- (NSInteger)pickerView:(LAPickerView *)pickerView numberOfColumnsInComponent:(NSInteger)component
{
    if ([self.settings.wightType integerValue] == GRAMS) {
        return 200;
    } else {
        return 325;
    }
}

- (NSString *)pickerView:(LAPickerView *)pickerView titleForColumn:(NSInteger)column forComponent:(NSInteger)component
{
    return @"";
}

- (void)pickerView:(LAPickerView *)pickerView didSelectColumn:(NSInteger)column inComponent:(NSInteger)component
{
    NSLog(@"Column:%ld",(long)column);
    
    NSNumber *myNumber;
    
    NSNumberFormatter *weightFromString = [[NSNumberFormatter alloc] init];
    weightFromString.numberStyle = NSNumberFormatterDecimalStyle;
    myNumber = [weightFromString numberFromString:[weightArray objectAtIndex:column]];
    NSNumber *lbs;
    
    if ([self.settings.wightType integerValue] == LIBRA)
    {
        MKQuantity* kg = [myNumber mass_pound];
        
        lbs = [NSNumber numberWithFloat:[[[kg convertTo:[MKMassUnit kilogram]] amountWithPrecision:0] floatValue]];   // lbs ?
        lblWeight.text = [NSString stringWithFormat:@"%@ %@",myNumber, [MKMassUnit pound].symbol];
        
    } else {
        
        lblWeight.text = [NSString stringWithFormat:@"%@ %@",myNumber, [MKMassUnit kilogram].symbol];
        lbs = myNumber;
    }
    
    [self.registrationProfileDetails setValue:lbs forKey:@"weight"];
    [[NSUserDefaults standardUserDefaults] setObject:lbs forKey:@"weight"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (UIView *)pickerView:(LAPickerView *)pickerView viewForColumn:(NSInteger)column forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    FITRuler *aview = [[[NSBundle mainBundle] loadNibNamed:@"FITRuler" owner:self options:nil]objectAtIndex:0];
    
    CGRect newFrame = CGRectMake( self.view.frame.origin.x , self.view.frame.origin.y, 30, self.weight.frame.size.height - 50);
    aview.frame = newFrame;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-20, 50, 50, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.text = [NSString stringWithFormat:@"%i",integWeight++];
    [label setFont:[UIFont fontWithName:@"SanFranciscoText-Regular" size:14]];
    [aview addSubview:label];
    
    [weightArray addObject:label.text];
    
    interoWeight+=1;
    decimWeight=0;
    
    return aview;
}


@end
