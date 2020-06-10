//
//  AddArmHipViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 17/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "AddArmHipViewController.h"
//#import "AddThighCalfViewController.m"

@implementation AddArmHipViewController
@synthesize pp;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self arm] setBackgroundColor:[UIColor blueColor]];
    [[self hip] setBackgroundColor:[UIColor blueColor]];
    
    [self programLabelColor:[self lblArm]];
    [self programLabelColor:[self lblHip]];
    
    self.settings = [AppSettings getAppSettings];
    
    if ([self.settings.lenghtType integerValue ] == METERS)
    {
        self.lblArm.text = [NSString stringWithFormat:@"0 %@", [MKLengthUnit centimeter].symbol];
        self.lblHip.text = [NSString stringWithFormat:@"0 %@",[MKLengthUnit centimeter].symbol];
        
    }
    else if ([self.settings.lenghtType integerValue ] == INCHES)
    {
        self.lblArm.text = [NSString stringWithFormat:@"0 %@", [MKLengthUnit inch].symbol];
        self.lblHip.text = [NSString stringWithFormat:@"0 %@",[MKLengthUnit inch].symbol];
        
        
    }
    
    if([self.currentCourse.courseType integerValue] == C9){
        [self.arm setBackgroundColor:[THM C9Color]];
        [self.hip setBackgroundColor:[THM C9Color]];
        
    } else if ([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2){
        [self.arm setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
        [self.hip setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
        
    } else if ([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        [self.arm setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
        [self.hip setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
    } else if ([self.currentCourse.courseType integerValue] == F15Advance || [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2){
        [self.arm setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
        [self.hip setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
        
    }
    
    [self programButtonUpdate:self.nextBtn buttonMode:3 inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_BUTTON_NEXT];
    
    [self programLabelColor:self.yourArmLabel inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_LABEL_ARM_MEASUREMENT];
    [self programLabelColor:self.yourHipLabel inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_LABEL_HIP_MEASUREMENT];
    
    
    DLog(@"%@",self.measurementDictionary);
    [self.measurementDictionary setValue:@1 forKey:@"arm"];
    [self.measurementDictionary setValue:@1 forKey:@"hip"];
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"arm"];
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"hip"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.startArm = 1;
    self.countArm = 200;
    self.interoArm= 0;
    self.decimArm = 50;
    
    self.startHip = 1;
    self.countHip = 200;
    self.interoHip= 0;
    self.decimHip = 50;
    
    self.armArray = [[NSMutableArray alloc]init];
    self.hipArray = [[NSMutableArray alloc]init];
    
//    [self updateUI:self.nextBtn buttonMode:3];
    
    _arm.dataSource = self;
    _hip.dataSource = self;
    
    _arm.delegate = self;
    _hip.delegate = self;
    
    _arm.selectionAlignment = LAPickerSelectionAlignmentCenter;
    _hip.selectionAlignment = LAPickerSelectionAlignmentCenter;
    
    _arm.tag = 1;
    _hip.tag = 2;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    [[self segueView] setAndDisplayNumItems:4 spacing:70];
    [[self segueView] setActiveItem:0];
    [[self segueView] setActiveItem:1];
    [[self segueView] setActiveItem:2];
 

    
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
        return self.countArm;
    }
    else
    {
        return self.countHip;
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
        NSNumber *myNumber = [weightFromString numberFromString:[self.armArray objectAtIndex:column]];
        
        NSNumber *centimeter;
        if ([self.settings.lenghtType integerValue ] == METERS){
            self.lblArm.text = [NSString stringWithFormat:@"%@ %@",[self.armArray objectAtIndex:column], [MKLengthUnit centimeter].symbol];
            centimeter = myNumber;
        } else {
            
            MKQuantity* kg = [myNumber length_inch];
            centimeter = [NSNumber numberWithFloat:[[[kg convertTo:[MKLengthUnit centimeter]] amountWithPrecision:0] floatValue]];   // lbs ?
            self.lblArm.text = [NSString stringWithFormat:@"%@ %@",[self.armArray objectAtIndex:column], [MKLengthUnit inch].symbol];
        }
        
        [self.measurementDictionary setValue:centimeter forKey:@"arm"];
        [[NSUserDefaults standardUserDefaults] setObject:centimeter forKey:@"arm"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        
        NSNumberFormatter *weightFromString = [[NSNumberFormatter alloc] init];
        weightFromString.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *myNumber = [weightFromString numberFromString:[self.hipArray objectAtIndex:column]];
        
        NSNumber *centimeter;
        if ([self.settings.lenghtType integerValue ] == METERS){
            self.lblHip.text = [NSString stringWithFormat:@"%@ %@",[self.hipArray objectAtIndex:column], [MKLengthUnit centimeter].symbol];
            centimeter = myNumber;
        } else {
            
            MKQuantity* kg = [myNumber length_inch];
            centimeter = [NSNumber numberWithFloat:[[[kg convertTo:[MKLengthUnit centimeter]] amountWithPrecision:0] floatValue]];   // lbs ?
            self.lblHip.text = [NSString stringWithFormat:@"%@ %@",[self.hipArray objectAtIndex:column], [MKLengthUnit inch].symbol];
        }
        
        [self.measurementDictionary setValue:centimeter forKey:@"hip"];
        [[NSUserDefaults standardUserDefaults] setObject:centimeter forKey:@"hip"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}


- (UIView *)pickerView:(LAPickerView *)pickerView viewForColumn:(NSInteger)column forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (pickerView.tag == 1)
    {
        
        FITRuler *aview = [[[NSBundle mainBundle] loadNibNamed:@"FITRuler" owner:self options:nil]objectAtIndex:0];
        //  aview.LB.text= [NSString stringWithFormat:@"%i",integ++];
        CGRect newFrame = CGRectMake( self.view.frame.origin.x, self.view.frame.origin.y, 30, self.arm.frame.size.height - 50);
        aview.frame = newFrame;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-20, 40, 50, 50)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.text = [NSString stringWithFormat:@"%li",(long)self.startArm++];
        [label setFont:[UIFont fontWithName:@"SanFranciscoText-Regular" size:14]];
        [aview addSubview:label];
        
        
        [self.armArray addObject:label.text];
        
        
        self.interoArm+=1;
        self.decimArm=0;
        
        return aview;
    }
    else
    {
        
        FITRuler *aview = [[[NSBundle mainBundle] loadNibNamed:@"FITRuler" owner:self options:nil]objectAtIndex:0];
        //  aview.LB.text= [NSString stringWithFormat:@"%i",integ++];
        CGRect newFrame = CGRectMake( self.view.frame.origin.x, self.view.frame.origin.y, 30, self.hip.frame.size.height - 50);
        aview.frame = newFrame;
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-20, 40, 50, 50)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.text = [NSString stringWithFormat:@"%li",(long)self.startHip++];
        [label setFont:[UIFont fontWithName:@"SanFranciscoText-Regular" size:14]];
        [aview addSubview:label];
        
        
        [self.hipArray addObject:label.text];
        
        
        self.interoHip+=1;
        self.decimHip=0;
        
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
    [self performSegueWithIdentifier:@"gotoThighCalfVC" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    AddThighCalfViewController *thighCalfVC = [segue destinationViewController];
//    thighCalfVC.measurementDictionary = self.measurementDictionary;
}

@end
