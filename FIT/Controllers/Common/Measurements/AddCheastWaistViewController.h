//
//  AddCheastWaistViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 17/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"

@interface AddCheastWaistViewController : ProgramBaseViewController<UIScrollViewAccessibilityDelegate,LAPickerViewDelegate,LAPickerViewDataSource>

@property (weak, nonatomic) IBOutlet FITButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblChest;
@property (weak, nonatomic) IBOutlet UILabel *lblWaist;
@property NSMutableDictionary *measurementDictionary;
@property (nonatomic,weak) NSString *numberString;
@property (weak, nonatomic) IBOutlet LAPickerView *chest;
@property (weak, nonatomic) IBOutlet LAPickerView *waist;
@property (weak, nonatomic) IBOutlet UILabel *youChestLabel;
@property (weak, nonatomic) IBOutlet UILabel *youWaist;

@property NSString *pp;

@property (nonatomic) NSInteger startChest;
@property (nonatomic) NSInteger countChest;
@property (nonatomic) NSInteger interoChest;
@property (nonatomic) NSInteger decimChest;

@property (nonatomic) NSInteger startWaist;
@property (nonatomic) NSInteger countWaist;
@property (nonatomic) NSInteger interoWaist;
@property (nonatomic) NSInteger decimWaist;

@property NSMutableArray *chestArray;
@property NSMutableArray *waistArray;

@end
