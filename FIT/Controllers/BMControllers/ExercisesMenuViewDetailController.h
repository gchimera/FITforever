//
//  ExerisesMenuViewDetailController.h
//  FIT
//
//  Created by Bruce Cresanta on 3/24/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuBaseViewController.h"
#import "ExerciseCell.h"
#import "FITExerciseDetailsRLM.h"


@interface ExercisesMenuViewDetailController : MenuBaseViewController
{
    
}
@property (weak, nonatomic) IBOutlet UITableView* table;
@property (strong, nonatomic) NSString* sectionName;
@property (strong, nonatomic) NSString* stringPassed;

@end
