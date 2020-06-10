//
//  FITAwardsItemVC.m
//  fitapp
//
//  Created by Hadi Roohian on 30/12/2016.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import "FITAwardsItemVC.h"

@interface FITAwardsItemVC ()
@end

@implementation FITAwardsItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", _awardDetails);
    [self updateAwardDetails];
    [self programButtonUpdate:self.awardButton buttonMode:1 inSection:@"" forKey:@""];
  //  [self programLabelColor:self.awardTitleLabel inSection:@"" forKey:@""];
  //  [self programLabelColor:self.awardSubTitleLabel inSection:@"" forKey:@""];
 //   [self programLabelColor:self.messageLabel inSection:@"" forKey:@""];

}


-(void)updateAwardDetails {
    self.awardTitleLabel.text = [_awardDetails valueForKey:@"title"];
    self.awardSubTitleLabel.text = [_awardDetails valueForKey:@"subtitle"];
    self.messageLabel.text = [_awardDetails valueForKey:@"message"];

    [self.awardButton setImage:[UIImage imageNamed:_awardDetails[@"image"]] forState:UIControlStateNormal];
    
    if ([_achived isEqualToString:@"YES"])
    {
        [_imgShare setHidden:YES];
    }else{
        [_imgShare setHidden:NO];
    }
}

#pragma mark - burger delegate

-(void)FITNavDrawerSelection:(NSInteger)selectionIndex
{
    NSLog(@"FITNavDrawerSelection = %li", (long)selectionIndex);
    //    self.selectionIdx.text = [NSString stringWithFormat:@"%li",(long)selectionIndex];
}



- (IBAction)share:(id)sender {
    
    NSString *message =  self.awardTitleLabel.text;
    NSArray *activityItems = @[message];
    UIActivityViewController *activityViewControntroller = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewControntroller.excludedActivityTypes = @[];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        activityViewControntroller.popoverPresentationController.sourceView = self.view;
        activityViewControntroller.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width/2, self.view.bounds.size.height/4, 0, 0);
    }
    [self presentViewController:activityViewControntroller animated:true completion:nil];
    
}


@end
