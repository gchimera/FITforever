//
//  MeasurementsProgressViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 18/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MeasurementsProgressViewController.h"
#import "ProgramDashboardViewController.h"

@interface MeasurementsProgressViewController ()

@end

@implementation MeasurementsProgressViewController

# pragma mark DEFAULT METHODS
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.settings = [AppSettings getAppSettings];
    
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    NSLog(@"%ld",(long)self.day);
    
    self.isDisplayMeasurement = NO;
    
    self.curvedLine.on = NO;
    
    self.pointColour = self.navigationController.navigationBar.barTintColor;
    self.graphBackgroundColour = [UIColor whiteColor];
    self.barColour = self.navigationController.navigationBar.barTintColor;
    self.fontColour = [UIColor grayColor];
    self.labelColour = [UIColor colorWithRed:60.0f/255 green:60.0f/255 blue:60.0f/255 alpha:0];
    
    [self.fontPicker selectRow:5 inComponent:0 animated:NO];
    
    if([self.currentCourse.courseType integerValue] == C9) {
        [self programButtonUpdate:self.switchProgressBtn buttonMode:3 inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_BUTTON_REVIEW_PROGRESS withColor:[THM BMColor]];
    } else {
        [self programButtonUpdate:self.switchProgressBtn buttonMode:3 inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_BUTTON_REVIEW_PROGRESS withColor:[THM GreyColor]];
    }
    [self programButtonUpdate:self.closeBtn buttonMode:3 inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_BUTTON_CLOSE];
    
    if(self.isDisplayMeasurement) {
        [self programButtonUpdate:self.switchProgressBtn buttonMode:3 inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_BUTTON_REVIEW_PROGRESS withColor:[THM BMColor]];
        [self.switchProgressBtn setTitle:@"Weights Progress" forState:UIControlStateNormal];
        [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_PROGRESS_SCREEN andKey:CONTENT_BUTTON_REVIEW_PROGRESS]];
        [self loadCurrentDayNumbers];
        
    } else {
        [self programButtonUpdate:self.switchProgressBtn buttonMode:3 inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_BUTTON_MEASUREMENT_PROGRESS withColor:[THM BMColor]];
        [self.switchProgressBtn setTitle:@"Measurements Progress" forState:UIControlStateNormal];
        [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_PROGRESS_SCREEN andKey:CONTENT_BUTTON_MEASUREMENT_PROGRESS]];
        [self loadCurrentDayNumbers];
    }
    
    
    
    [self programViewColor:self.separatorView];
    
    
    switch ([self.currentCourse.courseType integerValue]) {
        case C9:
            self.graphWeightsValues = [[NSArray arrayWithObjects:@0,@0,@0,@0,@0,@0,@0,@0,@0, nil] mutableCopy];
            self.graphMeasurementsValues = [[NSArray arrayWithObjects:@0,@0,@0,@0,@0,@0,@0,@0,@0, nil] mutableCopy];
            break;
            
        default:
            self.graphWeightsValues = [[NSArray arrayWithObjects:@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0, nil] mutableCopy];
            self.graphMeasurementsValues = [[NSArray arrayWithObjects:@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0, nil] mutableCopy];
            break;
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadCurrentDayNumbers];
    //    [self showGraph:nil];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showGraph:nil];
}

#pragma mark COLLECTIONVIEW

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.graphWeightsValues count];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MeasurementCollectionViewCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [formatter stringFromDate:self.currentCourse.startDate];
    
    collectionViewCell.dayLabel.text = [NSString stringWithFormat:@"Day %ld (%@)",indexPath.row + 1, [self setDateFormatOnNSString:dateString dayIndex:indexPath.row]];
    
    [self fetchMeasurementDataFromRealm:indexPath.row];
    if ([self.measurementData count] > 0) {
        
        
        
        RLMResults *firstDayResults = [Measurement objectsWhere:[NSString stringWithFormat:@"programID = '%@' AND day = '1'", self.currentCourse.userProgramId]];
        NSNumber *firstDayMeasurement = [firstDayResults firstObject][@"totalMeasurements"];
        NSNumber *currentDayMeasurement = [self.measurementData firstObject][@"totalMeasurements"];

        
        NSNumber *totalCurrentDayLength = currentDayMeasurement;
        if ([self.settings.lenghtType integerValue ] == METERS){
            
        } else {
            
            MKQuantity* centimeter = [currentDayMeasurement length_centimeter];
            totalCurrentDayLength = [NSNumber numberWithFloat:[[[centimeter convertTo:[MKLengthUnit inch]] amountWithPrecision:0] floatValue]];   // lbs ?
        }
        
        int lossMeasurement = [firstDayMeasurement intValue] - [currentDayMeasurement intValue];
        [self.graphMeasurementsValues replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInt:lossMeasurement]];
        
        
        
        User *userDetail = [User userInDB];
        NSString *weightStartingNumber = [NSString stringWithFormat:@"%@",userDetail.weight];
        NSNumber *currentWeight = [self.measurementData firstObject][@"weight"];

        NSNumber *weight = currentWeight;
        if ([self.settings.wightType integerValue ] == GRAMS){
            
            
        } else {
            
            MKQuantity* kg = [currentWeight mass_kilogram];
            weight = [NSNumber numberWithFloat:[[[kg convertTo:[MKMassUnit pound]] amountWithPrecision:0] floatValue]];   // lbs ?
            
        }
        
        int displayWeight = [weightStartingNumber intValue] - [weight intValue];
        
        
        if(self.isDisplayMeasurement) {
            
            if(lossMeasurement > 0) {
                collectionViewCell.amountLabel.text = [NSString stringWithFormat:@"%d %@",lossMeasurement, [MKLengthUnit.inch symbol]];
                [self.graphWeightsValues replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInt:lossMeasurement]];
            } else {
                collectionViewCell.amountLabel.text = [NSString stringWithFormat:@"0 %@", [MKLengthUnit.inch symbol]];
                [self.graphWeightsValues replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInt:0]];
            }
            
            
            
            
        } else {
            
            if (displayWeight > 0) {
                [self.graphWeightsValues replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInt:displayWeight]];
                collectionViewCell.amountLabel.text = [NSString stringWithFormat:@"%d %@",displayWeight, [MKMassUnit.pound symbol]];
            } else {
                [self.graphWeightsValues replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInt:0]];
                collectionViewCell.amountLabel.text = [NSString stringWithFormat:@"0 %@", [MKMassUnit.pound symbol]];
            }
            
            
        }
        
    } else {
        
        if(self.isDisplayMeasurement) {
            collectionViewCell.amountLabel.text = [NSString stringWithFormat:@"0 %@", [MKLengthUnit.inch symbol]];
        } else {
            collectionViewCell.amountLabel.text = [NSString stringWithFormat:@"0 %@", [MKMassUnit.pound symbol]];
        }
        
        
        
    }
    //
    //    [self loadCurrentDayNumbers];
    //    [self showGraph:nil];
    return collectionViewCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat screenWidth = self.view.frame.size.width;
    CGFloat collectionViewHeight = self.collectionView.frame.size.height;
    CGFloat cellWidth = screenWidth / 3.4;
    CGFloat cellHeight = collectionViewHeight / 3.6;
    CGSize size = CGSizeMake(cellWidth, cellHeight);
    
    return size;
}


- (void)fetchMeasurementDataFromRealm:(NSInteger)dayIndex {
    
    self.measurementData = [Measurement objectsWhere:[NSString stringWithFormat:@"day = '%ld' && programID = '%@'",(long)dayIndex + 1, self.currentCourse.userProgramId]];
    
    
}

- (void) loadCurrentDayNumbers {
    //Current Day Measurement Result
    RLMResults *currentDayResults = [Measurement objectsWhere:[NSString stringWithFormat:@"programID = '%@' && day = '%d'", self.currentCourse.userProgramId, self.day]];
    
    //First Day Measurement Results
    RLMResults *firstDayResults = [Measurement objectsWhere:[NSString stringWithFormat:@"programID = '%@' && day = '1'", self.currentCourse.userProgramId]];
    
    if ([firstDayResults count] > 0) {
        
        if(self.isDisplayMeasurement) {
            NSNumber *currentDayTotalMeasurement = [currentDayResults firstObject][@"totalMeasurements"];
            NSNumber *firstDayTotalMeasurement = [firstDayResults firstObject][@"totalMeasurements"];
            
            
            
            NSNumber *currentDayTotal = currentDayTotalMeasurement;
            NSNumber *firstDayTotal = firstDayTotalMeasurement;
            if ([self.settings.lenghtType integerValue ] == METERS){
                
                //Meters
                
            } else {
                MKQuantity* centimeter = [currentDayTotalMeasurement length_centimeter];
                currentDayTotal = [NSNumber numberWithFloat:[[[centimeter convertTo:[MKLengthUnit inch]] amountWithPrecision:0] floatValue]];   // lbs ?
                
                MKQuantity* centimeter2 = [firstDayTotalMeasurement length_centimeter];
                firstDayTotal = [NSNumber numberWithFloat:[[[centimeter convertTo:[MKLengthUnit inch]] amountWithPrecision:0] floatValue]];
            }
            
            
            int lossMeasurement = [firstDayTotal intValue] - [currentDayTotal intValue];
            
            
            if (lossMeasurement > 0) {
                
                self.currentMeasurementAmount.text = [NSString stringWithFormat:@"%@ in",currentDayTotal];
                [self programLabelColor:self.currentMeasurementAmount];
                self.currentLossAmount.text = [NSString stringWithFormat:@"%d in loss",lossMeasurement];
                
            } else {
                
                self.currentMeasurementAmount.text = [NSString stringWithFormat:@"%@ in",currentDayTotal];
                [self programLabelColor:self.currentMeasurementAmount];
                self.currentLossAmount.text = [NSString stringWithFormat:@"0 in loss"];
                
            }
            

            
        } else {
            
            
            User *userDetail = [User userInDB];
            NSString *weightStartingNumber = [NSString stringWithFormat:@"%@",userDetail.weight];
            NSNumber *currentDayWeight = [currentDayResults firstObject][@"weight"];
    
//            NSNumber *weight = currentWeight;
            if ([self.settings.wightType integerValue ] == GRAMS){
                
                //Grams
                
            } else {
                
                MKQuantity* currentDayWeightInkg = [currentDayWeight mass_kilogram];
                currentDayWeight = [NSNumber numberWithFloat:[[[currentDayWeightInkg convertTo:[MKMassUnit pound]] amountWithPrecision:0] floatValue]];   // lbs ?
            }
            
            int lossWeight = [weightStartingNumber intValue] - [currentDayWeight intValue];
            
            if (lossWeight > 0) {
                self.currentMeasurementAmount.text = [NSString stringWithFormat:@"%@ lbs",currentDayWeight];
                [self programLabelColor:self.currentMeasurementAmount];
                self.currentLossAmount.text = [NSString stringWithFormat:@"%d lbs loss",lossWeight];
            } else {
                self.currentMeasurementAmount.text = [NSString stringWithFormat:@"%@ lbs",currentDayWeight];
                [self programLabelColor:self.currentMeasurementAmount];
                self.currentLossAmount.text = [NSString stringWithFormat:@"0 lbs loss"];
            }
            
            
        }
    } else {
        self.currentLossAmount.text = @"0 Lbs loss";
        self.currentMeasurementAmount.text = @"0 Lbs";
        [self programLabelColor:self.currentMeasurementAmount];
    }
    


}




-(NSString *)setDateFormatOnNSString:(NSString *)dateString dayIndex:(NSInteger)index {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:dateString];
    
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = index;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:dateFromString options:0];
    
    
    [dateFormatter setDateFormat:@"d MMM"];
    NSString *stringDate = [dateFormatter stringFromDate:nextDate];
    return stringDate;
}


# pragma mark PICKERVIEW

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[UIFont familyNames] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *fontName = [[UIFont familyNames] objectAtIndex:row];
    
    return fontName;
}

- (IBAction)showGraph:(id)sender
{
    for (UIView *subview in self.graphContainerView.subviews) {
        if ([subview isKindOfClass:[FITGraphView class]]) {
            [subview removeFromSuperview];
        }
    }
    FITGraphView *graphView = [[FITGraphView alloc] initWithFrame:self.graphContainerView.bounds];
    graphView.graphData = [self createArrayToPassToGraph];
    
    graphView.pointFillColor = self.navigationController.navigationBar.barTintColor;
    graphView.strokeColor = self.navigationController.navigationBar.barTintColor;
    graphView.hideLabels = self.hidelabels.isOn;
    graphView.strokeWidth = 1;
    graphView.graphWidth = graphView.frame.size.width * 1;
    graphView.hidePoints = self.hidePoints.isOn;
    graphView.hideLines = self.hideLines.isOn;
    graphView.backgroundViewColor = self.graphBackgroundColour;
    
    //    graphView.barColor = [UIColor blackColor];
    
    NSArray *fontArray = [UIFont fontNamesForFamilyName:[self pickerView:self.fontPicker titleForRow:[self.fontPicker selectedRowInComponent:0] forComponent:0]];
    graphView.labelFont = [UIFont fontWithName:[fontArray firstObject] size:12];
    graphView.labelFontColor = self.fontColour;
    graphView.labelBackgroundColor = self.labelColour;
    graphView.pointFillColor = self.navigationController.navigationBar.barTintColor;
    
    [self.graphContainerView addSubview:graphView];
    //    [self.collectionView reloadData];
}



- (NSArray *)createArrayToPassToGraph
{
    
    [self.collectionView reloadData];
    if(self.isDisplayMeasurement) {
        
        return [NSArray arrayWithArray:self.graphMeasurementsValues];
    } else {
        return [NSArray arrayWithArray:self.graphWeightsValues];
        
    }
}

- (IBAction)closeBtnTapped:(id)sender {
    
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Program" bundle:nil];
//    UIViewController *weight = [sb instantiateViewControllerWithIdentifier:MEASUREMENTS_SCREEN];
//    [self.navigationController pushViewController:weight animated:YES];
    ProgramDashboardViewController *joinProgram = (ProgramDashboardViewController *)[self.storyboard instantiateViewControllerWithIdentifier:PROGRAM_DASHBOARD];
    
    [self.navigationController pushViewController:joinProgram animated:YES];
    
}

- (IBAction)switchProgressBtnTapped:(id)sender {
    self.isDisplayMeasurement = !self.isDisplayMeasurement;
    
    if(self.isDisplayMeasurement) {
        [self programButtonUpdate:self.switchProgressBtn buttonMode:3 inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_BUTTON_REVIEW_PROGRESS withColor:[THM BMColor]];
        [self.switchProgressBtn setTitle:@"Weights Progress" forState:UIControlStateNormal];
        [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_PROGRESS_SCREEN andKey:CONTENT_BUTTON_REVIEW_PROGRESS]];
        //        self.navigationItem.title = @"Measurements Progress";
        [self loadCurrentDayNumbers];
        
    } else {
        [self programButtonUpdate:self.switchProgressBtn buttonMode:3 inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_BUTTON_MEASUREMENT_PROGRESS withColor:[THM BMColor]];
        [self.switchProgressBtn setTitle:@"Measurements Progress" forState:UIControlStateNormal];
        [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_PROGRESS_SCREEN andKey:CONTENT_BUTTON_MEASUREMENT_PROGRESS]];
        [self loadCurrentDayNumbers];
    }
    [self.collectionView reloadData];
    [self showGraph:nil];
}

@end
