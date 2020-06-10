//
//  SetProgramStartDateViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 19/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface SetProgramStartDateViewController : ProgramBaseViewController<LAPickerViewDelegate,LAPickerViewDataSource>
@property UserCourseType *courseSelected;

@property NSString *databaseProgramName;
@property (weak, nonatomic) IBOutlet FITButton *doneBtn;

@property (weak, nonatomic) IBOutlet UILabel *lblDay;
@property (weak, nonatomic) IBOutlet UILabel *lblMonth;
@property (weak, nonatomic) IBOutlet UILabel *lblYear;
@property (nonatomic,weak) NSString *numberString;
@property (weak, nonatomic) IBOutlet LAPickerView *day;
@property (weak, nonatomic) IBOutlet LAPickerView *month;
@property (weak, nonatomic) IBOutlet LAPickerView *year;

@property NSString *pp;
@property long daySel;
@property long monthSel;
@property NSString *yearSel;

@property (weak, nonatomic) IBOutlet UIImageView *topShapes;
@property (weak, nonatomic) IBOutlet UIImageView *bottomShapes;
@property RLMResults *activeProgram;

@end
