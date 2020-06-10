//
//  FITauthenticateCMS.m
//  authentication
//
//  Created by lshiva on 17/12/2016.
//  Copyright © 2016 B60apps. All rights reserved.
//

#import "FITAuthenticateCMS.h"
#import "FITAPIConstant.h"

@implementation FITAuthenticateCMS

@synthesize delegate,connection,urlSession;

#pragma mark AUTHENTICATE

- (void)getauthorizationCode:(NSString *)accessToken
{
    NSString *urlBody = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&redirect_uri=%@&code=%@",FBO_CLIENT_ID, FBO_CLIENT_SECRET,FBO_REDIRECT_URL,accessToken];
    
    
    NSString *urlString  = [NSString stringWithFormat:FBO_LOAD_TOKEN_URL];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody:[urlBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          
                                          if (!error)
                                          {
                                              
                                              [self processDataFromFLPServer:data];
                                              
                                          }
                                          else
                                          {
                                              NSLog(@"dataTaskWithRequest error: %@", error);
                                              
                                          }
                                          
                                      }];
    
    [dataTask resume];
    
}

- (void) processDataFromFLPServer:( NSData *)data
{
    NSError *error;
    
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    NSLog(@"Data:%@", jsonDictionary[@"error"]);
    
    if(jsonDictionary[@"error"])
    {
        NSLog(@"Failure...");
        NSLog(@"Error:%@",jsonDictionary);
        [delegate errorVerificationOfUser];
    }
    else
    {
        NSLog(@"Success...");
        
        NSLog(@"jsonData:%@",jsonDictionary);
        
        
        
        NSString *accessToken = [jsonDictionary objectForKey:@"access_token"];
        
        [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"token"];
        
        NSString *tokenURL = [jsonDictionary objectForKey:@"id"];
        
        NSDictionary* responseDict =  [self processUserDetails:tokenURL andToken:accessToken];
        
        NSLog(@"responseDict:%@",responseDict);
        
        if ([[responseDict objectForKey:@"success"] isEqualToString:@"no"])
        {
            [delegate authenticationFailureWithError:@"There was an error. Please check your login details"];
        }
        else
        {
            
            // add to realm DB
            // user control process
            // navigate to the dashboard
            [delegate successVerificationofUserForCMS:(responseDict)];
            
        }
        
        
    }
    
}


-(NSDictionary*)processUserDetails:(NSString*)requestString andToken:(NSString*)token
{
    NSString *urlString = [NSString stringWithFormat:@"%@",requestString];
    
    NSURL *userUrl = [NSURL URLWithString:urlString];
    
    NSString *encodedToken = [token stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:userUrl];
    
    request.HTTPMethod = @"GET";
    
    [request setValue:[NSString stringWithFormat:@"Bearer %@",encodedToken] forHTTPHeaderField:@"Authorization"];
    
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
    
    
    if (returnData == nil)
    {
        return [NSDictionary dictionaryWithObjectsAndKeys:@"success",@"no", nil];
        
    }
    else
    {
        NSDictionary* returnDict = [NSJSONSerialization JSONObjectWithData:returnData options:kNilOptions error:nil];
        
        if ([returnDict objectForKey:@"error"]) {
            NSArray* returnArray = [returnDict objectForKey:@"error"];
            return [NSDictionary dictionaryWithObjectsAndKeys:@"no",@"success",returnArray,@"profile", nil];
            
            
        }
        else
        {
            return [NSDictionary dictionaryWithObjectsAndKeys:@"yes",@"success",returnDict,@"profile", nil];
            
        }
    }
}

@end
