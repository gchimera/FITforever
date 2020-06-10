//
//  Player.h
//  fitapp
//
//  Created by Guglielmo Chimera on 26/01/17.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVPlayerVC.h"

@interface Player : UIViewController
@property NSURL *videoURL;
@property (nonatomic, weak) AVPlayerVC *playerVC;

@end
