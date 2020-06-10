//
//  ConversationListViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 27/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ProgramBaseViewController.h"
#import "ConversationCell.h"

@interface ConversationListViewController : ProgramBaseViewController<UITableViewDelegate, UITableViewDataSource>{
    NSArray<MTLConversation *> *localConversations;
}

@property (strong, nonatomic) IBOutlet UITableView* tableView;

@end
