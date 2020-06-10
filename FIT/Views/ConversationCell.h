//
//  ConversationCell.h
//  FIT
//
//  Created by Hamid Mehmood on 27/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ConversationCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView* friendPicture;
@property (weak, nonatomic) IBOutlet UILabel*  friendLabel;

@end
