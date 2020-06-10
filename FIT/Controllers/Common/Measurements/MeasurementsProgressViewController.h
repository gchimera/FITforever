//
//  MeasurementsProgressViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 18/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"
#import "MeasurementCollectionViewCell.h"
#import "Measurement.h"

@interface MeasurementsProgressViewController : ProgramBaseViewController<UIPickerViewDataSource,UIPickerViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet FITButton *closeBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet FITButton *switchProgressBtn;
@property (weak, nonatomic) IBOutlet UILabel *currentMeasurementAmount;
@property (weak, nonatomic) IBOutlet UILabel *currentLossAmount;

@property (strong, nonatomic) IBOutlet UIView *settingsView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *colourSegment;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;
@property (weak, nonatomic) IBOutlet UISlider *alphaSlider;
@property (weak, nonatomic) IBOutlet UIView *colourPreview;
@property (weak, nonatomic) IBOutlet UISwitch *hideLines;
@property (weak, nonatomic) IBOutlet UISwitch *hidePoints;
@property (weak, nonatomic) IBOutlet UISwitch *curvedLine;
@property (weak, nonatomic) IBOutlet UISwitch *hidelabels;
@property (weak, nonatomic) IBOutlet UIPickerView *fontPicker;
@property (weak, nonatomic) IBOutlet UISlider *xAxisValueSlider;
@property (weak, nonatomic) IBOutlet UILabel *xAxisValueLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIColor *strokeColour;
@property (strong, nonatomic) UIColor *pointColour;
@property (strong, nonatomic) UIColor *graphBackgroundColour;
@property (strong, nonatomic) UIColor *barColour;
@property (strong, nonatomic) UIColor *fontColour;
@property (strong, nonatomic) UIColor *labelColour;

@property (weak, nonatomic) IBOutlet UIView *graphContainerView;



@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property int day;
@property RLMResults *result;
//@property RLMResults *currentProgram;
@property RLMResults *measurementData;
@property bool isDisplayMeasurement;
@property NSMutableArray *graphMeasurementsValues;
@property NSMutableArray *graphWeightsValues;

@end
