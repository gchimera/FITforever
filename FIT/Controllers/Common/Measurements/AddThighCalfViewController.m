//
//  AddThighCalfViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 17/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "AddThighCalfViewController.h"
#import "Measurement.h"
#import "MeasurementsProgressViewController.h"

@implementation AddThighCalfViewController

@synthesize pp;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self programLabelColor:[self lblThigh] inSection:@"" forKey:@""];
    [self programLabelColor:[self lblKnee] inSection:@"" forKey:@""];
    [self programButtonUpdate:[self submitBtn] buttonMode:3 inSection:@"" forKey:@"" withColor:[UIColor blueColor]];
    [[self thigh] setBackgroundColor:[UIColor blueColor]];
    [[self knee] setBackgroundColor:[UIColor blueColor]];
    
    DLog(@"YUUUUUUP %@",self.measurementDictionary);
    [self.measurementDictionary setValue:@1 forKey:@"thigh"];
    [self.measurementDictionary setValue:@1 forKey:@"calf"];
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"thigh"];
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"calf"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.startThigh = 0;
    self.countThigh = 200;
    self.interoThigh = 0;
    self.decimThigh = 50;
    
    self.startKnee = 0;
    self.countKnee = 200;
    self.interoKnee = 0;
    self.decimKnee = 50;
    
    self.thighArray = [[NSMutableArray alloc]init];
    self.kneeArray = [[NSMutableArray alloc]init];
    
    
    self.settings = [AppSettings getAppSettings];
    
    if ([self.settings.lenghtType integerValue ] == METERS)
    {
        self.lblThigh.text = [NSString stringWithFormat:@"0 %@", [MKLengthUnit centimeter].symbol];
        self.lblKnee.text = [NSString stringWithFormat:@"0 %@",[MKLengthUnit centimeter].symbol];
        
    }
    else if ([self.settings.lenghtType integerValue ] == INCHES)
    {
        self.lblThigh.text = [NSString stringWithFormat:@"0 %@", [MKLengthUnit inch].symbol];
        self.lblKnee.text = [NSString stringWithFormat:@"0 %@",[MKLengthUnit inch].symbol];
        
        
    }
    
    [self programLabelColor:[self lblKnee]];
    [self programLabelColor:[self lblThigh]];
    
    if([self.currentCourse.courseType integerValue] == C9){
        [self.thigh setBackgroundColor:[THM C9Color]];
        [self.knee setBackgroundColor:[THM C9Color]];
        
    } else if ([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2){
        [self.thigh setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
        [self.knee setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
        
    } else if ([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        [self.thigh setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
        [self.knee setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
    } else if ([self.currentCourse.courseType integerValue] == F15Advance || [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2){
        [self.thigh setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
        [self.knee setBackgroundColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1] ];
        
    }
    
    [self programButtonUpdate:self.submitBtn buttonMode:3 inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_BUTTON_SUBMIT];
    
    [self programLabelColor:self.youThighLabel inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_LABEL_THIGH_MEASUREMENT];
    [self programLabelColor:self.youKneeLabel inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_LABEL_KNEE_MEASUREMENT];
    
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    DLog(@"%ld",(long)self.day);
    
    
//    [self updateUI:self.submitBtn buttonMode:3];
    
    _thigh.dataSource = self;
    _knee.dataSource = self;
    
    _thigh.delegate = self;
    _knee.delegate = self;
    
    _thigh.selectionAlignment = LAPickerSelectionAlignmentCenter;
    _knee.selectionAlignment = LAPickerSelectionAlignmentCenter;
    
    _thigh.tag = 1;
    _knee.tag = 2;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    [[self segueView] setAndDisplayNumItems:4 spacing:70];
    [[self segueView] setActiveItem:0];
    [[self segueView] setActiveItem:1];
    [[self segueView] setActiveItem:2];
    [[self segueView] setActiveItem:3];
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
        return self.countThigh;
    }
    else
    {
        return self.countKnee;
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
        NSNumber *myNumber = [weightFromString numberFromString:[self.thighArray objectAtIndex:column]];
        
        NSNumber *centimeter;
        if ([self.settings.lenghtType integerValue ] == METERS){
            self.lblThigh.text = [NSString stringWithFormat:@"%@ %@",[self.thighArray objectAtIndex:column], [MKLengthUnit centimeter].symbol];
            centimeter = myNumber;
        } else {
            
            MKQuantity* kg = [myNumber length_inch];
            centimeter = [NSNumber numberWithFloat:[[[kg convertTo:[MKLengthUnit centimeter]] amountWithPrecision:0] floatValue]];   // lbs ?
            self.lblThigh.text = [NSString stringWithFormat:@"%@ %@",[self.thighArray objectAtIndex:column], [MKLengthUnit inch].symbol];
        }
        
        [self.measurementDictionary setValue:centimeter forKey:@"thigh"];
        [[NSUserDefaults standardUserDefaults] setObject:centimeter forKey:@"thigh"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        
        NSNumberFormatter *weightFromString = [[NSNumberFormatter alloc] init];
        weightFromString.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *myNumber = [weightFromString numberFromString:[self.kneeArray objectAtIndex:column]];
        
        NSNumber *centimeter;
        if ([self.settings.lenghtType integerValue ] == METERS){
            self.lblKnee.text = [NSString stringWithFormat:@"%@ %@",[self.kneeArray objectAtIndex:column], [MKLengthUnit centimeter].symbol];
            centimeter = myNumber;
        } else {
            
            MKQuantity* kg = [myNumber length_inch];
            centimeter = [NSNumber numberWithFloat:[[[kg convertTo:[MKLengthUnit centimeter]] amountWithPrecision:0] floatValue]];   // lbs ?
            self.lblKnee.text = [NSString stringWithFormat:@"%@ %@",[self.kneeArray objectAtIndex:column], [MKLengthUnit inch].symbol];
        }
        
        [self.measurementDictionary setValue:centimeter forKey:@"calf"];
        [[NSUserDefaults standardUserDefaults] setObject:centimeter forKey:@"calf"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}


- (UIView *)pickerView:(LAPickerView *)pickerView viewForColumn:(NSInteger)column forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (pickerView.tag == 1)
    {
        // decimali
        
        //        if (column % 10 != 0) {
        //
        //            decimal *aview = [[[NSBundle mainBundle] loadNibNamed:@"decimal" owner:self options:nil]objectAtIndex:0];
        //            NSString *k = [NSString stringWithFormat:@"%d.%d",interoChest, decimChest+=10];
        //            // aview.LB.text = [self stringByFormattingString:k toPrecision:2];
        //            NSString* n = [self stringByFormattingString:k toPrecision:2];
        //
        //            [chestArray addObject:n];
        //
        //            return aview;
        //        }
        //        else
        //        {
        
        // interi
        
        FITRuler *aview = [[[NSBundle mainBundle] loadNibNamed:@"FITRuler" owner:self options:nil]objectAtIndex:0];
        //  aview.LB.text= [NSString stringWithFormat:@"%i",integ++];
        CGRect newFrame = CGRectMake( self.view.frame.origin.x, self.view.frame.origin.y, 30, self.thigh.frame.size.height - 50);
        aview.frame = newFrame;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-20, 40, 50, 50)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.text = [NSString stringWithFormat:@"%li",(long)self.startThigh++];
        [label setFont:[UIFont fontWithName:@"SanFranciscoText-Regular" size:14]];
        [aview addSubview:label];
        
        
        [self.thighArray addObject:label.text];
        
        
        self.interoThigh+=1;
        self.decimThigh=0;
        
        return aview;
    }
    else
    {
        
        FITRuler *aview = [[[NSBundle mainBundle] loadNibNamed:@"FITRuler" owner:self options:nil]objectAtIndex:0];
        //  aview.LB.text= [NSString stringWithFormat:@"%i",integ++];
        CGRect newFrame = CGRectMake( self.view.frame.origin.x, self.view.frame.origin.y, 30, self.knee.frame.size.height - 50);
        aview.frame = newFrame;
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-20, 40, 50, 50)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.text = [NSString stringWithFormat:@"%li",(long)self.startKnee++];
        [label setFont:[UIFont fontWithName:@"SanFranciscoText-Regular" size:14]];
        [aview addSubview:label];
        
        
        [self.kneeArray addObject:label.text];
        
        
        self.interoKnee+=1;
        self.decimKnee=0;
        
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


- (IBAction)submitBtnTapped:(id)sender
{
    
    
    [self saveMeasurementDictionaryIntoRealm];
    MeasurementsProgressViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MeasurementsProgressViewController"];
    [[self navigationController] pushViewController:vc animated:YES];
    
}


- (void)saveMeasurementDictionaryIntoRealm {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    int weightValue = [[defaults stringForKey:@"weight"] integerValue];
    int chest = [[defaults stringForKey:@"chest"] integerValue];
    int hip = [[defaults stringForKey:@"hip"] integerValue];
    int arm = [[defaults stringForKey:@"arm"] integerValue];
    int thigh = [[defaults stringForKey:@"thigh"] integerValue];
    int calf = [[defaults stringForKey:@"calf"] integerValue];
    int waist = [[defaults stringForKey:@"waist"] integerValue];
    
    [realm beginWriteTransaction];
    DLog(@"%@",self.measurementDictionary);
    [Measurement createOrUpdateInRealm:realm withValue:@{
                                                         @"measurementId": [NSString stringWithFormat:@"%@_%@",self.currentCourse.userProgramId,[NSString stringWithFormat:@"%d",self.day]],
                                                         @"day": [NSString stringWithFormat:@"%d",self.day],
                                                         @"programID" : self.currentCourse.userProgramId,
                                                         @"weight" :  @(weightValue),
                                                         @"chest" :  @(chest),
                                                         @"hip" :  @(hip),
                                                         @"arm" :  @(arm),
                                                         @"thigh" :  @(thigh),
                                                         @"calf" :  @(calf),
                                                         @"waist" :  @(waist),
                                                         @"totalMeasurements" : @(
                                                             chest + hip + arm + thigh + calf + waist
                                                             )
                                                         }];
    [CourseDay createOrUpdateInRealm:realm withValue:@{
                                                       @"dayId":[NSString stringWithFormat:@"%@_%@",self.currentCourse.userProgramId,[NSString stringWithFormat:@"%d",self.day]],
                                                       @"programID":[NSString stringWithFormat:@"%@",self.currentCourse.userProgramId],
                                                       @"day" : [NSString stringWithFormat:@"%d",self.day],
                                                       @"date": [NSDate date]
                                                       }];

    
    [realm commitWriteTransaction];
    
}



@end
