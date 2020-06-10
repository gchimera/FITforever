//
//  MessageCell.h
//  FIT
//
//  Created by Hamid Mehmood on 27/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BaseTableViewCustomCell.h"

@interface MessageCell : BaseTableViewCustomCell
//{
//    MessageBubbleType messageType;
//    CGFloat adjustedCellHeight;
//}
//
//@property (weak,nonatomic) IBOutlet MessageLabelBubble* messageBubble;
//@property (weak,nonatomic) IBOutlet UIImageView* imageSender;
//@property (weak,nonatomic) IBOutlet UIImageView* imageRecipient;
//
//
//-(void) setMessageType:(MessageBubbleType) type;
//-(MessageBubbleType) getMessageType;
//-(CGFloat) adjustedCellHeight;
@property (weak, nonatomic) IBOutlet UIImageView *fromImageView;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet FITButton *awardsImageButton;
@property (weak, nonatomic) IBOutlet UIImageView *bubbleImage;
@property (weak, nonatomic) IBOutlet UILabel *messageText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellHeightContraint;

@end
