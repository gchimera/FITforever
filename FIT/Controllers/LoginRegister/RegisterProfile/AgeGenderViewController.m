//
//  AgeGenderViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 13/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "AgeGenderViewController.h"

@interface AgeGenderViewController ()
@property UIAlertController *alertController;

@end

int startAge;
NSMutableArray *rulerValues;
NSString *countLine =@"";

NSString *ageSelected =@"";
NSString *genderSelected =@"";

@implementation AgeGenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    startAge = 18;
    
    rulerValues = [[NSMutableArray alloc]init];
    
    [self languageAndButtonUIUpdate:self.nextButton buttonMode:3 inSection:CONTENT_REGISTER_SECTION forKey:CONTENT_BUTTON_NEXT backgroundColor:[THM C9Color]];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    [[self segueView] setAndDisplayNumItems:3 spacing:80];
    [[self segueView] setActiveItem:0];
    _age.dataSource = self;
    _age.delegate = self;
    _age.selectionAlignment = LAPickerSelectionAlignmentCenter;
    
    _ageValueLabel.text = [NSString stringWithFormat:@"- %@", [self localisedStringForSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE andKey:CONTENT_LABEL_YEARS]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)genderSelection:(UIButton *)sender {
    if(sender.tag == 1){
        [self.maleButton setImage:[UIImage imageNamed:@"malegenderselected"] forState:UIControlStateNormal];
        [self.maleButton setUserInteractionEnabled:NO];
        [self.femaleButton setUserInteractionEnabled:YES];
        [self.femaleButton setImage:[UIImage imageNamed:@"femalegender"] forState:UIControlStateNormal];
        
        [self.registrationProfileDetails setValue:@"m" forKey:@"gender"];
        [[NSUserDefaults standardUserDefaults] setObject:@"m" forKey:@"gender"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [self.maleButton setImage:[UIImage imageNamed:@"malegender"] forState:UIControlStateNormal];
        [self.femaleButton setImage:[UIImage imageNamed:@"femalegenderselected"] forState:UIControlStateNormal];
        [self.femaleButton setUserInteractionEnabled:NO];
        [self.maleButton setUserInteractionEnabled:YES];
        
        [self.registrationProfileDetails setValue:@"f" forKey:@"gender"];
        [[NSUserDefaults standardUserDefaults] setObject:@"f" forKey:@"gender"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    genderSelected = @"selected";
    
}


- (IBAction)nextBtnTapped:(id)sender {
    
    if([ageSelected isEqualToString:@""] || [genderSelected isEqualToString:@""]) {
        DLog(@"gender is not seleected");
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
//        self.alertController = [UIAlertController alertControllerWithTitle:@"" message:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_MANDATORY_DATA_MISSING] preferredStyle:UIAlertControllerStyleAlert];
//            [self.alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {    }]];
//            [self presentViewController:self.alertController animated:YES completion:nil];
            
            [[Utils sharedUtils] showAlertViewWithMessage:[self localisedStringForSection:CONTENT_LOGIN_EMAIL_SECTION andKey:CONTENT_LABEL_MANDATORY_DATA_MISSING] buttonTitle:@"OK"];
        });
    } else {
        [self performSegueWithIdentifier:@"FITCreateProfileHeightVC" sender:@""];
//        [[NSUserDefaults standardUserDefaults] setObject:self.profileDetails[@"gender"] forKey:@"gender"];
        //        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark PICKERVIEW

- (NSInteger)numberOfComponentsInPickerView:(LAPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(LAPickerView *)pickerView numberOfColumnsInComponent:(NSInteger)component {
    return 82;//to become 100
}

- (NSString *)pickerView:(LAPickerView *)pickerView titleForColumn:(NSInteger)column forComponent:(NSInteger)component {
    countLine = [NSString stringWithFormat:@"%ld",(long)column];
    return countLine;
}

- (void)pickerView:(LAPickerView *)pickerView didSelectColumn:(NSInteger)column inComponent:(NSInteger)component {
    DLog(@"Column:%ld",(long)column);
    _ageValueLabel.text = [NSString stringWithFormat:@"%@ %@",[rulerValues objectAtIndex:column], [self localisedStringForSection:CONTENT_FITAPP_LABELS_CREATE_PROFILE andKey:CONTENT_LABEL_YEARS]];
    NSNumberFormatter *ageFromString = [[NSNumberFormatter alloc] init];
    ageFromString.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *myNumber = [ageFromString numberFromString:[rulerValues objectAtIndex:column]];
    [self.registrationProfileDetails setValue:myNumber forKey:@"age"];
    [[NSUserDefaults standardUserDefaults] setObject:myNumber forKey:@"age"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
ageSelected = @"age selected";
    
    
}

- (UIView *)pickerView:(LAPickerView *)pickerView viewForColumn:(NSInteger)column forComponent:(NSInteger)component reusingView:(UIView *)view{
    FITRuler *aview = [[[NSBundle mainBundle] loadNibNamed:@"FITRuler" owner:self options:nil] objectAtIndex:0];
    
    // Resize uiview - because we haven't decimal values in this case
    CGRect newFrame = CGRectMake( self.view.frame.origin.x, self.view.frame.origin.y, 30, self.age.frame.size.height - 50);
    aview.frame = newFrame;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-20, 50, 50, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.text = [NSString stringWithFormat:@"%i",startAge++];
    [aview addSubview:label];
    
    [rulerValues addObject:label.text];
    return aview;
}


@end
