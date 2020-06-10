//
//  FITauthenticateCMS.h
//  authentication
//
//  Created by lshiva on 17/12/2016.
//  Copyright © 2016 B60apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol loginprotocolFLP

@required

- (void) successVerificationofUser;

- (void)successVerificationofUserForCMS:(NSDictionary *)responseDict;

- (void) authenticationFailureWithError:(NSString*)errorMessage;

- (void) errorVerificationOfUser;

@end

@interface FITAuthenticateCMS : NSObject<UIWebViewDelegate>
{
    UIWebView *webview;
    NSMutableData *receivedData;
    
}

@property (retain) NSURLConnection *connection;

@property (retain) NSURLSession *urlSession;

@property (assign) id <loginprotocolFLP> delegate;

- (void) getauthorizationCode:(NSString *)accessToken; //STEP:2

-(NSDictionary*) processUserDetails:(NSString*)requestString andToken:(NSString*)token;

@end


