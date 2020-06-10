//
//  AddThighCalfViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 17/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface AddThighCalfViewController : ProgramBaseViewController<LAPickerViewDelegate,LAPickerViewDataSource>

@property (weak, nonatomic) IBOutlet FITButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblThigh;
@property (weak, nonatomic) IBOutlet UILabel *lblKnee;
@property NSMutableDictionary *measurementDictionary;

@property (nonatomic,weak) NSString *numberString;
@property (weak, nonatomic) IBOutlet LAPickerView *thigh;
@property (weak, nonatomic) IBOutlet LAPickerView *knee;
@property (weak, nonatomic) IBOutlet UILabel *youThighLabel;
@property (weak, nonatomic) IBOutlet UILabel *youKneeLabel;

@property NSString *pp;

@property (nonatomic) NSInteger startThigh;
@property (nonatomic) NSInteger countThigh;
@property (nonatomic) NSInteger interoThigh;
@property (nonatomic) NSInteger decimThigh;

@property (nonatomic) NSInteger startKnee;
@property (nonatomic) NSInteger countKnee;
@property (nonatomic) NSInteger interoKnee;
@property (nonatomic) NSInteger decimKnee;

@property NSMutableArray *thighArray;
@property NSMutableArray *kneeArray;

@property int day;
@property RLMResults *result;

@end
