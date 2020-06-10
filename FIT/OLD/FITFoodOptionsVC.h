//
//  FITFoodOptions.h
//  fitapp
//
//  Created by Hadi Roohian on 29/12/2016.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgramBaseViewController.h"

@interface FITFoodOptionsVC : ProgramBaseViewController

@property (weak, nonatomic) IBOutlet FITButton *supplementsBtn;
@property (weak, nonatomic) IBOutlet FITButton *mealBtn;

@property NSString* mealSelected;
@property NSInteger courseMapNumber;


@end
