//
//  AddWeightViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 17/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"
#import "FITProgressSegueView.h"


@interface AddWeightViewController : ProgramBaseViewController<UIScrollViewAccessibilityDelegate, LAPickerViewDelegate,LAPickerViewDataSource>

@property (nonatomic,weak) NSString *numberString;
@property (weak, nonatomic) IBOutlet LAPickerView *weight;
@property (nonatomic) NSInteger count;
@property (weak, nonatomic) NSString *pp;
@property NSMutableDictionary *measurementDictionary;
@property (nonatomic) NSInteger integ;
@property (nonatomic) NSInteger intero;
@property (nonatomic) NSInteger decim;
@property NSMutableArray *valuesArray;

@property (weak, nonatomic) IBOutlet FITButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblWeight;
@property (weak, nonatomic) IBOutlet UILabel *yourWeightLabel;


@end
