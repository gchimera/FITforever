//
//  MessageViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 27/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"
#import "User.h"

@interface MessageViewController : ProgramBaseViewController<UITableViewDataSource, UITableViewDelegate>

@property NSString *myUsername;
@property NSString *conversationId;
@property NSArray<MTLMessage *> *messages;
@property (weak,nonatomic) IBOutlet UITableView* tableView;
@property (weak, nonatomic) IBOutlet UIImageView *addFriendsButton;
@property (weak, nonatomic) IBOutlet UILabel *addfriendsLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;

@property (weak, nonatomic) IBOutlet UITextField *messageText;

@end
