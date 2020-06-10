//
//  ConversationCell.m
//  FIT
//
//  Created by Hamid Mehmood on 27/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ConversationCell.h"

@implementation ConversationCell

@synthesize friendPicture;
@synthesize friendLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
    
}

@end
