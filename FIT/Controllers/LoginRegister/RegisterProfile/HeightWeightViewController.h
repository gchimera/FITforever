//
//  HeightWeightViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 13/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseViewController.h"

@interface HeightWeightViewController : BaseViewController <UIScrollViewAccessibilityDelegate, LAPickerViewDelegate,LAPickerViewDataSource>{
    IBOutlet UIScrollView *scrollView1;
    
    int scaleCount;
    NSInteger KtotalActualEnd;
    
    IBOutlet UILabel *lblWeight;
    IBOutlet UILabel *lblHeight;
    
    IBOutlet RulerPicker *heightPK;
    IBOutlet LAPickerView *weightPK;
    
}

@property (nonatomic,weak) NSString *numberString;
@property (weak, nonatomic) IBOutlet LAPickerView *height;
@property (weak, nonatomic) IBOutlet LAPickerView *weight;
@property (nonatomic, retain) UIView *scrollView1;

@property (weak, nonatomic) IBOutlet FITButton *nextBtn;
@property (nonatomic) IBInspectable NSInteger countHeight;
@property (nonatomic) IBInspectable NSInteger countWeight;
@end
