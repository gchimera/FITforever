//
//  FITBurgerMenu.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FITProgram.h"

@protocol FITNavDrawerDelegate <NSObject>
@required
- (void)FITNavDrawerSelection:(NSInteger)selectionIndex;
@end

@interface FITBurgerMenu : UINavigationController <UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSArray *menuArray;
}

@property (nonatomic, strong) UIPanGestureRecognizer *pan_gr;
@property (weak, nonatomic)id<FITNavDrawerDelegate> FITNavDrawerDelegate;

- (void)drawerToggle;


@end
