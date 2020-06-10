//
//  AddArmHipViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 17/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface AddArmHipViewController : ProgramBaseViewController <LAPickerViewDelegate,LAPickerViewDataSource>

@property (weak, nonatomic) IBOutlet FITButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblArm;
@property (weak, nonatomic) IBOutlet UILabel *lblHip;
@property NSMutableDictionary *measurementDictionary;
@property (nonatomic,weak) NSString *numberString;
@property (weak, nonatomic) IBOutlet LAPickerView *arm;
@property (weak, nonatomic) IBOutlet LAPickerView *hip;
@property NSString *pp;
@property (nonatomic) NSInteger startArm;
@property (nonatomic) NSInteger countArm;
@property (nonatomic) NSInteger interoArm;
@property (nonatomic) NSInteger decimArm;

@property (nonatomic) NSInteger startHip;
@property (nonatomic) NSInteger countHip;
@property (nonatomic) NSInteger interoHip;
@property (nonatomic) NSInteger decimHip;

@property NSMutableArray * armArray;
@property NSMutableArray * hipArray;
@property (weak, nonatomic) IBOutlet UILabel *yourArmLabel;
@property (weak, nonatomic) IBOutlet UILabel *yourHipLabel;

@end
