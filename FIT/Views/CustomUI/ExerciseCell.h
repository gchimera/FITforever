//
//  ExerciseCell.h
//  FIT
//
//  Created by Bruce Cresanta on 3/20/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCustomCell.h"


@interface ExerciseCell : BaseTableViewCustomCell
{
   
}
@property (weak,nonatomic) IBOutlet UIImageView* excerciseImageView;
@property (weak,nonatomic) IBOutlet UILabel    * excerciseLabel;

@end
