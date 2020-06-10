//
//  Player.m
//  fitapp
//
//  Created by Guglielmo Chimera on 26/01/17.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import "Player.h"


@interface Player ()




@end

@implementation Player

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.playerVC.videoURL = self.videoURL;
//    
//    self.playerVC.showsPlaybackControls = YES;
//    
//    [self.playerVC.overlayVC didPlayButtonSelected:self];
//    
//   // [self.playerVC.overlayVC didFullscreenButtonSelected:self];
//    
//    [self.playerVC.overlayVC willMoveToParentViewController:self];
//    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[AVPlayerVC class]])
        self.playerVC = segue.destinationViewController;
    

}

@end
