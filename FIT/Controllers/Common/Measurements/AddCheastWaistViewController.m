//
//  AddCheastWaistViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 17/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "AddCheastWaistViewController.h"
#import "AddArmHipViewController.h"
#import "AppSettings.h"

@implementation AddCheastWaistViewController

@synthesize pp;
NSString* unitWaist;
NSString* unitChest;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settings = [AppSettings getAppSettings];

    if ([self.settings.lenghtType integerValue ] == METERS)
    {
        unitWaist = [MKLengthUnit centimeter].symbol;
        self.startWaist = 0;
        _lblWaist.text = [NSString stringWithFormat:@"0 %@", [MKLengthUnit centimeter].symbol];
        unitChest =[MKLengthUnit centimeter].symbol;
        self.startChest = 0;
        _lblChest.text = [NSString stringWithFormat:@"0 %@",[MKLengthUnit centimeter].symbol];
        
    }
    else if ([self.settings.lenghtType integerValue ] == INCHES)
    {
        unitWaist = [MKLengthUnit inch].symbol;
        self.startWaist = 0;
        _lblWaist.text = [NSString stringWithFormat:@"0 %@", [MKLengthUnit inch].symbol];
        unitChest =[MKLengthUnit inch].symbol;
        self.startChest = 0;
        _lblChest.text = [NSString stringWithFormat:@"0 %@",[MKLengthUnit inch].symbol];

        
    }

    
    [self programLabelColor:[self lblChest]];
      [self programLabelColor:[self lblWaist]];
    
    if([self.currentCourse.courseType integerValue] == C9){
        [self.chest setBackgroundColor:[THM C9Color]];
        [self.waist setBackgroundColor:[THM C9Color]];
        
    } else if ([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2){
        [self.chest setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
        [self.waist setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
        
    } else if ([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        [self.chest setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
        [self.waist setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
    } else if ([self.currentCourse.courseType integerValue] == F15Advance || [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2){
        [self.chest setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
        [self.waist setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
        
    }
    
    [self programButtonUpdate:self.nextBtn buttonMode:3 inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_BUTTON_NEXT];
    
    [self programLabelColor:self.youChestLabel inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_LABEL_CHEST_MEASUREMENT];
    [self programLabelColor:self.youWaist inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_LABEL_WAIST_MEASUREMENT];
    
    DLog(@"%@",self.measurementDictionary);
    [self.measurementDictionary setValue:@1 forKey:@"waist"];
    [self.measurementDictionary setValue:@1 forKey:@"chest"];
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"waist"];
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"chest"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.countChest = 80;
    self.interoChest= 0;
    self.decimChest = 50;
    
    self.countWaist = 80;
    self.interoWaist= 0;
    self.decimWaist = 50;
    
    self.chestArray = [[NSMutableArray alloc]init];
    self.waistArray = [[NSMutableArray alloc]init];
    
//    [self updateUI:self.nextBtn buttonMode:3];
    
    _chest.dataSource = self;
    _waist.dataSource = self;
    
    _chest.delegate = self;
    _waist.delegate = self;
    
    _chest.selectionAlignment = LAPickerSelectionAlignmentCenter;
    _waist.selectionAlignment = LAPickerSelectionAlignmentCenter;
    
    _chest.tag = 1;
    _waist.tag = 2;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    [[self segueView] setAndDisplayNumItems:4 spacing:70];
    [[self segueView] setActiveItem:0];
    [[self segueView] setActiveItem:1];


}

#pragma mark PICKERVIEW

- (NSInteger)numberOfComponentsInPickerView:(LAPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(LAPickerView *)pickerView numberOfColumnsInComponent:(NSInteger)component
{
    if (pickerView.tag == 1)
    {
        return self.countChest;
    }
    else
    {
        return self.countWaist;
    }
}

- (NSString *)pickerView:(LAPickerView *)pickerView titleForColumn:(NSInteger)column forComponent:(NSInteger)component
{
    pp = [NSString stringWithFormat:@"%ld",(long)column];
    
    return pp;
}

- (void)pickerView:(LAPickerView *)pickerView didSelectColumn:(NSInteger)column inComponent:(NSInteger)component
{
    if (pickerView.tag == 1)
    {
        
        NSNumberFormatter *weightFromString = [[NSNumberFormatter alloc] init];
        weightFromString.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *myNumber = [weightFromString numberFromString:[self.chestArray objectAtIndex:column]];
        
        
        NSNumber *centimeter;
        
        if ([self.settings.lenghtType integerValue ] == METERS){
            self.lblChest.text = [NSString stringWithFormat:@"%@ %@",[self.chestArray objectAtIndex:column], [MKLengthUnit centimeter].symbol];
            centimeter = myNumber;
        } else {
            
            MKQuantity* kg = [myNumber length_inch];
            centimeter = [NSNumber numberWithFloat:[[[kg convertTo:[MKLengthUnit centimeter]] amountWithPrecision:0] floatValue]];
            self.lblChest.text = [NSString stringWithFormat:@"%@ %@",[self.chestArray objectAtIndex:column], [MKLengthUnit inch].symbol];
        }
        
        
        [self.measurementDictionary setValue:centimeter forKey:@"chest"];
        [[NSUserDefaults standardUserDefaults] setObject:centimeter forKey:@"chest"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        NSNumberFormatter *weightFromString = [[NSNumberFormatter alloc] init];
        weightFromString.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *myNumber = [weightFromString numberFromString:[self.waistArray objectAtIndex:column]];
        
        NSNumber *centimeter;
        if ([self.settings.lenghtType integerValue ] == METERS){
            self.lblWaist.text = [NSString stringWithFormat:@"%@ %@",[self.chestArray objectAtIndex:column], [MKLengthUnit centimeter].symbol];
            centimeter = myNumber;
        } else {
            
            MKQuantity* kg = [myNumber length_inch];
            centimeter = [NSNumber numberWithFloat:[[[kg convertTo:[MKLengthUnit centimeter]] amountWithPrecision:0] floatValue]];   // lbs ?
            self.lblWaist.text = [NSString stringWithFormat:@"%@ %@",[self.chestArray objectAtIndex:column], [MKLengthUnit inch].symbol];
        }
        
        
        [self.measurementDictionary setValue:centimeter forKey:@"waist"];
        [[NSUserDefaults standardUserDefaults] setObject:centimeter forKey:@"waist"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}


- (UIView *)pickerView:(LAPickerView *)pickerView viewForColumn:(NSInteger)column forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (pickerView.tag == 1)
    {
        
        // interi
        
        FITRuler *aview = [[[NSBundle mainBundle] loadNibNamed:@"FITRuler" owner:self options:nil]objectAtIndex:0];
        //  aview.LB.text= [NSString stringWithFormat:@"%i",integ++];
        CGRect newFrame = CGRectMake( self.view.frame.origin.x, self.view.frame.origin.y, 30, self.chest.frame.size.height - 50);
        aview.frame = newFrame;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-20, 40, 50, 50)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.text = [NSString stringWithFormat:@"%li",(long)self.startChest++];
        [label setFont:[UIFont fontWithName:@"SanFranciscoText-Regular" size:14]];
        [aview addSubview:label];
        
        
        [self.chestArray addObject:label.text];
        
        
        self.interoChest+=1;
        self.decimChest=0;
        
        return aview;
        //        }
        //
        
        
        
        
        
        
        
    }
    else
    {
        FITRuler *aview = [[[NSBundle mainBundle] loadNibNamed:@"FITRuler" owner:self options:nil]objectAtIndex:0];
        //  aview.LB.text= [NSString stringWithFormat:@"%i",integ++];
        CGRect newFrame = CGRectMake( self.view.frame.origin.x, self.view.frame.origin.y, 30, self.waist.frame.size.height - 50);
        aview.frame = newFrame;
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-20, 40, 50, 50)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.text = [NSString stringWithFormat:@"%li",(long)self.startWaist++];
        [label setFont:[UIFont fontWithName:@"SanFranciscoText-Regular" size:14]];
        [aview addSubview:label];
        
        
        [self.waistArray addObject:label.text];
        
        
        self.interoWaist+=1;
        self.decimWaist=0;
        
        return aview;
    }
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

- (IBAction)nextButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"gotoArmHipVC" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AddArmHipViewController *armHipVC = [segue destinationViewController];
    armHipVC.measurementDictionary = self.measurementDictionary;
}

@end
