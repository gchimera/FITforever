//
//  ConversationListViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 27/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ConversationListViewController.h"
#import "MessageViewController.h"

@interface ConversationListViewController ()

@end

@implementation ConversationListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self tableView] setDataSource:self];
    [[self tableView] setDelegate:self];
    
    [[FITAPIManager sharedManager] getUserConversationsWithSuccess:^(NSArray<MTLConversation *> *conversations) {
        dispatch_async(dispatch_get_main_queue(), ^{
            localConversations = conversations;
            [self.tableView reloadData];
            if(localConversations.count ==1 ){
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MESSAGE_STORYBOARD bundle:nil];
                
                MessageViewController *messageViewController = (MessageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MessageViewController"];
                messageViewController.conversationId = [NSString stringWithFormat:@"%@",localConversations[0].covensation_id];
                [self.navigationController pushViewController:messageViewController animated:YES];
            }
        });
        
    } failure:^(NSError *error) {
        
    }];
    DLog(@"Table View Frame Height:%f",[[self tableView] bounds].size.height);
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [localConversations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ConversationCell *cell = (ConversationCell*)[tableView dequeueReusableCellWithIdentifier:@"conversationCell"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"conversationCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    MTLConversation *con = [localConversations objectAtIndex:indexPath.row];
    
    [[cell friendLabel] setText:con.title];
    [cell setTag:con.covensation_id];
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"INDEX NUM: %ld",(long)indexPath.row);
    
    
    ConversationCell *selectedCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row  inSection:0]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MESSAGE_STORYBOARD bundle:nil];
    
    MessageViewController *messageViewController = (MessageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MessageViewController"];
    messageViewController.conversationId = [NSString stringWithFormat:@"%@",selectedCell.tag];
    [self.navigationController pushViewController:messageViewController animated:YES];
}

@end
