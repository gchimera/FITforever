//
//  AgeGenderViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 13/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseViewController.h"
#import "LAPickerView.h"

@interface AgeGenderViewController : BaseViewController<LAPickerViewDelegate,LAPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *maleButton;
@property (weak, nonatomic) IBOutlet UIButton *femaleButton;
@property (weak, nonatomic) IBOutlet FITButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *youGenderLabel;
@property (weak, nonatomic) IBOutlet UILabel *yourAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageValueLabel;

@property (weak, nonatomic) IBOutlet LAPickerView *age;

@end
