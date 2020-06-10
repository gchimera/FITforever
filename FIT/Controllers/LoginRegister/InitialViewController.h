//
//  InitialViewController.h
//  FIT
//
//  Created by Hamid Mehmood on 01/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseViewController.h"
#import "FITAuthenticateCMS.h"

@interface InitialViewController : BaseViewController<UIWebViewDelegate, loginprotocolFLP>
{
    NSMutableData *receivedData;
    NSURLRequest *requestObj;
    UILabel *ageLbl;
    
}
// Buttons
@property (weak, nonatomic) IBOutlet FITButton *loginWithFLPButton;
@property (weak, nonatomic) IBOutlet FITButton *loginFBButton;
@property (weak, nonatomic) IBOutlet FITButton *loginEmailButton;
@property (weak, nonatomic) IBOutlet FITButton *learnMoreButton;



// Login Methods
- (void)progressProfilePicture;

@end
