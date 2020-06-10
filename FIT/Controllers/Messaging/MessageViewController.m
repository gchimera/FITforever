//
//  MessageViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 27/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "UIImageView+WebCache.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    RLMResults *user = [User getUser];
    if([user count]>0){
        User *userDB = [user objectAtIndex:0];
        self.myUsername = userDB.username;
    }
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 71.0; // set to whatever your "average" cell height is

    [self loadData];
}

-(void) loadData {
    
    [[FITAPIManager sharedManager] getMessagesForConversation:[NSString stringWithFormat:@"%@",self.conversationId]
                                                      success:^(NSArray<MTLMessage *> *messages) {
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              self.messages = messages;
                                                              [tableView reloadData];
                                                          });
                                                      } failure:^(NSError *error) {
                                                      }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self programLabelColor:self.addfriendsLabel];
    [self.addfriendsLabel setText:@"Add Friends"];
    
    [self programImageUpdate:self.addFriendsButton withImageName:@"addfriends"];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addFriends)];
    singleTap.numberOfTapsRequired = 1;
    [self.addFriendsButton setUserInteractionEnabled:YES];
    [self.addFriendsButton addGestureRecognizer:singleTap];
    
    [self programViewColor:self.bottomView];
}

-(void)addFriends{
    NSLog(@"single Tap on imageview");
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",[self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS andKey:CONTENT_SHARE_PROGRAM_TEXT_PART1],self.currentCourse.programName, [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS andKey:CONTENT_SHARE_PROGRAM_TEXT_PART2],self.currentCourse.shareCode,[self localisedStringForSection:CONTENT_PLACEHOLDER_SECTION andKey:CONTENT_SHARE_END_PART]];
    
    UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:@[text] applicationActivities:nil];
    activityViewControntroller.excludedActivityTypes = @[];
    
    [self presentViewController:activityViewControntroller animated:true completion:nil];
    
}

- (IBAction)sendMessage:(id)sender {
    if([self.messageText hasText]){
        [[MTAPIManager sharedManager] sendMessageWithConversationId:self.conversationId message:self.messageText.text image:@"" messageTyp:@"TEXT" date:@"" imageType:@"" awardsId:@"" notificaionId:@""  success:^(int *status) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loadData];
                [self.messageText setText: @""];
            });
        } failure:^(NSError *error) {
            
        }];
    }
}

- (IBAction)sendPictureImage:(id)sender {
    NSLog(@"CAMERA TAP");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //DLog(@"%d size grouparray",(int)self.messageArray.count);
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MessageCell *awardCell = (MessageCell*)[tableView dequeueReusableCellWithIdentifier:@"awardCell"];
    MessageCell *fromMessageCell = (MessageCell*)[tableView dequeueReusableCellWithIdentifier:@"fromMessageCell"];
    MessageCell *myMessageCell = (MessageCell*)[tableView dequeueReusableCellWithIdentifier:@"myMessageCell"];
    
    
    if (awardCell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"awardCell" owner:self options:nil];
        awardCell = [nib objectAtIndex:0];
    }
    if (fromMessageCell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"fromMessageCell" owner:self options:nil];
        fromMessageCell = [nib objectAtIndex:0];
    }
    if (myMessageCell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"myMessageCell" owner:self options:nil];
        myMessageCell = [nib objectAtIndex:0];
    }
    
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"message_sent_time"
                                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray *sortedArray = [self.messages sortedArrayUsingDescriptors:sortDescriptors];
    MTLMessage *message = [sortedArray objectAtIndex:indexPath.row];
    fromMessageCell.messageText.text = message.message_body;
    myMessageCell.messageText.text = message.message_body;
    awardCell.messageText.text = message.message_body;
    

    
    NSLog(@"%@",message.sender_image);
    // Image Handling
    if([message.sender_image hasPrefix:@"http"]) {
        
        NSURL *url = [NSURL URLWithString:message.sender_image];
        [fromMessageCell.fromImageView sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"chat_man"]];
        [myMessageCell.myImageView sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"chat_man"]];
        
    } else if(!([message.sender_image isEqualToString:@""])) {
        
        UIImage *senderImage = [[Utils sharedUtils] decodeBase64ToImage:message.sender_image];
        fromMessageCell.fromImageView.image = senderImage;
        myMessageCell.myImageView.image = senderImage;
        
    } else {
        
        NSURL *url = [NSURL URLWithString:@""];
        [fromMessageCell.fromImageView sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"chat_man"]];
        [myMessageCell.myImageView sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"chat_man"]];
    }
    
    [[[fromMessageCell fromImageView] layer] setCornerRadius:fromMessageCell.fromImageView.frame.size.width / 2];
    [[[myMessageCell myImageView] layer] setCornerRadius:myMessageCell.myImageView.frame.size.width / 2];
    [[[fromMessageCell fromImageView] layer] setMasksToBounds:YES];
    [[[myMessageCell myImageView] layer] setMasksToBounds:YES];
    
    //Calculate the expected size based on the font and linebreak mode of your label
    // FLT_MAX here simply means no constraint in height
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    CGSize expectedLabelSize = [message.message_body sizeWithFont:myMessageCell.messageText.font constrainedToSize:maximumLabelSize lineBreakMode:myMessageCell.messageText.lineBreakMode];
    if(expectedLabelSize.height > myMessageCell.cellHeightContraint.constant){
        myMessageCell.cellHeightContraint.constant = expectedLabelSize.height + 15;
        fromMessageCell.cellHeightContraint.constant = expectedLabelSize.height + 15;
    }
    if (![message.award_cms_id isEqualToString:@""] && ![message.award_cms_id isEqualToString:@"null"]){
        RLMResults *award = [FITAwards objectsWhere:[NSString stringWithFormat:@"awrdsId = '%@'",message.award_cms_id]];
        if([award count] > 0){
            FITAwards *a = [award objectAtIndex:0];
            [self programButtonUpdate:awardCell.awardsImageButton buttonMode:1 inSection:@"" forKey:@""];
            [awardCell.awardsImageButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",a.icon]] forState:UIControlStateNormal];
            awardCell.messageText.text = [NSString stringWithFormat:@"%@ %@ %@",a.awardName, message.sender_name, a.awardAchievedMessage];
        }
        return  awardCell;
    } else if([message.sender_name isEqualToString:self.myUsername]){
        return  myMessageCell;
    } else {
        return fromMessageCell;
    }
}

@end
