//
//  MenuBaseViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 16/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseViewController.h"

@interface MenuBaseViewController : BaseViewController<FITNavDrawerDelegate>

@property (strong, nonatomic) FITBurgerMenu *navigationMenu;
@property UserCourse *currentCourseBM;

@end
