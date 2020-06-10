//
//  DrawerView.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerView : UIView

@property (strong, nonatomic) IBOutlet UILabel *version;
@property (weak, nonatomic) IBOutlet UITableView *drawerTableView;
@end
