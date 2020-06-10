//
//  countryDetail.h
//  FIT
//
//  Created by Guglielmo Chimera on 04/04/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MenuBaseViewController.h"

@interface countryDetail : MenuBaseViewController

@property IBOutlet UITableView* Tabella;
@property IBOutlet UILabel* countryLB;

@property BOOL countryBL;
@property (weak, nonatomic) IBOutlet FITButton *doneButton;


@end
