//
//  MessageCell.m
//  FIT
//
//  Created by Hamid Mehmood on 27/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell
//@synthesize imageSender;
//@synthesize imageRecipient;
//@synthesize messageBubble;


//-(CGFloat) adjustedCellHeight
//{
//    return [messageBubble adjustedCellHeight];
//    
//}
//
-(void) awakeFromNib
{
    [super awakeFromNib];
    [self programButtonUpdate:self.awardsImageButton buttonMode:1 inSection:@"" forKey:@""];
//    self.fromImageView.layer.cornerRadius = self.fromImageView.frame.size.width / 2;
//    self.myImageView.layer.cornerRadius = self.myImageView.frame.size.width / 2;
//    
}
//
//-(void) setMessageType:(MessageBubbleType) type
//{
//    messageType = type;
//    [self.messageBubble setMessageBubbleType:type];
//    
//    
//}
//-(void) setAwardsImageButton:(FITButton *)awardsImageButton iconName:(NSString *)iconName {
//    [self.awardsImageButton programButtonImageUpdate:awardsImageButton withImageName:iconName];
//
//}
//
//-(MessageBubbleType) getMessageType
//{
//    return messageType;
//    
//}


@end
