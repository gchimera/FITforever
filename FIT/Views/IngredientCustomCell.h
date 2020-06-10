//
//  IngredientCustomCell.h
//  FIT
//
//  Created by Hadi Roohian on 03/04/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IngredientCustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ingredientTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *servingSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *caloryLabel;

@end
