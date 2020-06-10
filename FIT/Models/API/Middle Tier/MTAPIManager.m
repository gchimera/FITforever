//
//  MTAPIManager.m
//  FIT
//
//  Created by Hamid Mehmood on 08/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MTAPIManager.h"
#import "MTLUser.h"
#import "MTAPIManager_Error.h"
#import "User.h"

NSErrorDomain const MTAPIErrorDomain = @"MTAPIErrorDomain";

@implementation MTAPIManager

- (void) initUser{
    User *user = [User userInDB];
    if( user != nil ){
        [self.requestSerializer setValue:user.token forHTTPHeaderField:@"FIT-User-Token"];
    }
    
}

- (NSURLSessionDataTask *)registerUserUsingMethod:(RegistrationMethod)method
                                            email:(NSString *)email
                                         password:(NSString *)password
                                         username:(NSString *)username
                                              age:(NSUInteger)age
                                           gender:(NSString *)gender
                                           height:(NSUInteger)height
                                           weight:(NSUInteger)weight
                                            image:(NSString *)image
                                        imageType:(NSString *)imageType
                                       idFacebook:(NSString *)idFacebook
                                         idFLP360:(NSString *)idFLP360
                                          success:(void (^)(MTLUser *user))success
                                          failure:(void (^)(NSError *error))failure {
    [self initUser];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"device_token"];
    NSDictionary *parameters = @{
                                 @"email":email != nil ? email : @"",
                                 @"password":password != nil ? password : @"",
                                 @"username":username != nil ? username : @"",
                                 @"age":@(age),
                                 @"gender":gender != nil ? gender : @"",
                                 @"height":@(height),
                                 @"weight":@(weight),
                                 @"image":image != nil ? image : @"",
                                 @"image_type":imageType != nil ? imageType : @"",
                                 @"device_token":token != nil ? token : @"",
                                 @"device_type":@"ios",
                                 @"facebook_id":idFacebook != nil ? idFacebook : @"",
                                 @"fl360_id":idFLP360 != nil ? idFLP360 : @""
                                 };
    return [self POST:MT_AUTH_REGISTER
           parameters:parameters
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                  [self handleUserResponseObject:responseObject
                                         success:success
                                         failure:failure];
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DLog(@"Error: %@", error);
                  if (failure != nil) {
                      failure(error);
                  }
              }];
}

- (NSURLSessionDataTask *)loginUsingEmail:(NSString *)email
                                 password:(NSString *)password
                                  success:(void (^)(MTLUser *user))success
                                  failure:(void (^)(NSError *error))failure {
    [self initUser];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"device_token"];
    NSDictionary *parameters = @{
                                 @"email":email != nil ? email : @"",
                                 @"password":password != nil ? password : @"",
                                 @"device_token":token != nil ? token : @"",
                                 @"device_type":@"ios"
                                 };
    return [self POST:MT_AUTH_LOGIN
           parameters:parameters
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                  [self handleUserResponseObject:responseObject
                                         success:success
                                         failure:failure];
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DLog(@"Error: %@", error);
                  if (failure != nil) {
                      failure(error);
                  }
              }];
}

- (void)handleUserResponseObject:(id _Nonnull)responseObject
                         success:(void (^)(MTLUser *user))success
                         failure:(void (^)(NSError *error))failure {
    if([[responseObject objectForKey:@"status"] integerValue] != nil && [[responseObject objectForKey:@"status"] integerValue] == Success){
        NSError *error;
        MTLUser *user = [MTLJSONAdapter modelOfClass:MTLUser.class
                                  fromJSONDictionary:responseObject
                                               error:&error];
        
        DLog(@"User %@:", user);
        
        if (user == nil || error || user.status != Success) {
            if (failure != nil) {
                if (error) {
                    failure(error);
                } else {
                    failure([[NSError alloc] initWithDomain:MTAPIErrorDomain
                                                       code:user.status
                                                   userInfo:nil]);
                    
                }
            }
        } else if (success != nil) {
            success(user);
        }
        
    } else {
        failure([[NSError alloc] initWithDomain:MTAPIErrorDomain
                                           code:[[responseObject objectForKey:@"status"] integerValue]
                                       userInfo:nil]);
    }
}

- (NSURLSessionDataTask *)confirmLoginUsingEmail:(NSString *)email
                                        password:(NSString *)password
                                      idFacebook:(NSString *)idFacebook
                                        idFLP360:(NSString *)idFLP360
                                         success:(void (^)(MTLUser *user))success
                                         failure:(void (^)(NSError *error))failure {
    [self initUser];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"device_token"];
    NSDictionary *parameters = @{
                                 @"email":email != nil ? email : @"",
                                 @"password":password != nil ? password : @"",
                                 @"device_token":token != nil ? token : @"",
                                 @"device_type":@"ios",
                                 @"facebook_id":idFacebook != nil ? idFacebook : @"",
                                 @"fl360_id":idFLP360 != nil ? idFLP360 : @""
                                 };
    return [self POST:MT_AUTH_CONFIRMLOGIN
           parameters:parameters
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                  [self handleUserResponseObject:responseObject
                                         success:success
                                         failure:failure];
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DLog(@"registerUser error: %@", error);
                  if (failure != nil) {
                      failure(error);
                  }
              }];
}

- (NSURLSessionDataTask *)updateProfile:(NSString *)email
                               password:(NSString *)password
                               username:(NSString *)username
                                    age:(NSUInteger)age
                                 gender:(NSString *)gender
                                 height:(NSUInteger)height
                                 weight:(NSUInteger)weight
                                  image:(NSString *)image
                              imageType:(NSString *)imageType
                             idFacebook:(NSString *)idFacebook
                               idFLP360:(NSString *)idFLP360
                                success:(void (^)(MTLUser *user))success
                                failure:(void (^)(NSError *error))failure {
    [self initUser];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"device_token"];
    NSDictionary *parameters = @{
                                 @"email":email != nil ? email : @"",
                                 @"password":password != nil ? password : @"",
                                 @"username":username != nil ? username : @"",
                                 @"age":@(age),
                                 @"gender":gender != nil ? gender : @"",
                                 @"height":@(height),
                                 @"weight":@(weight),
                                 @"image":image != nil ? image : @"",
                                 @"image_type":imageType != nil ? imageType : @"",
                                 @"device_token":token != nil ? token : @"",
                                 @"device_type":@"ios",
                                 @"facebook_id":idFacebook != nil ? idFacebook : @"",
                                 @"fl360_id":idFLP360 != nil ? idFLP360 : @"",
                                 @"profileCompleted":@(1)
                                 };
    return [self POST:MT_AUTH_UPDATEPROFILE
           parameters:parameters
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                  NSError *error;
                  MTLUser *user = [MTLJSONAdapter modelOfClass:MTLUser.class
                                            fromJSONDictionary:responseObject
                                                         error:&error];
                  
                  DLog(@"User %@:", user);
                  
                  if (user == nil || error) {
                      if (failure != nil) {
                          failure(error);
                      }
                  } else if (success != nil) {
                      success(user);
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DLog(@"registerUser error: %@", error);
                  if (failure != nil) {
                      failure(error);
                  }
              }];
}

- (NSURLSessionDataTask *)passwordResetUsingEmail:(NSString *)email
                                          success:(void (^)(int *status))success
                                          failure:(void (^)(NSError *error))failure {
    [self initUser];
    
    NSDictionary *parameters = @{@"email":email != nil ? email : @""};
    return [self POST:MT_AUTH_RESET_PASSWORD
           parameters:parameters
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                  
                  int status = [[responseObject objectForKey:@"status"] intValue]; ;
                  if (success != nil) {
                      success(status);
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DLog(@"registerUser error: %@", error);
                  if (failure != nil) {
                      failure(error);
                  }
              }];
}

- (NSURLSessionDataTask *)checkEmail:(NSString *)email
                             success:(void (^)(int *status))success
                             failure:(void (^)(NSError *error))failure {
    [self initUser];
    
    NSDictionary *parameters = @{@"email":email != nil ? email : @""};
    return [self POST:MT_AUTH_CHECKEMAIL
           parameters:parameters
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                  
                  int status = [[responseObject objectForKey:@"status"] intValue]; ;
                  if (success != nil) {
                      success(status);
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DLog(@"registerUser error: %@", error);
                  if (failure != nil) {
                      failure(error);
                  }
              }];
}


- (NSURLSessionDataTask *)programUpsert:(UpsertAction *)action
                              programId:(int *) programId
                            programName:(NSString *) programName
                              startDate:(NSString *) startDate
                            isCompleted:(BOOL *)isCompleted
                   isNotificationEnable:(BOOL *)isNotificationEnabled
                               isDelete:(BOOL *)isDelete
                            programDays:(int *)programDays
                      conversationTitle:(NSString *)conversationTitle
                                success:(void (^)( id  _Nonnull responseObject))success
                                failure:(void (^)(NSError *error))failure {
    [self initUser];
    NSString *actionProgram = @"create";
    NSString *program_id = @"";
    if(action == CREATE) {
        actionProgram = @"create";
        program_id = @"";
    } else {
        actionProgram = @"update";
        program_id = [NSString stringWithFormat:@"%d",programId];
    }
    NSDictionary *parameters = @{@"action":actionProgram,
                                 @"program_id": program_id,
                                 @"program_name": programName,
                                 @"start_date": startDate,
                                 @"is_completed": [NSNumber numberWithBool:isCompleted],
                                 @"notification": [NSNumber numberWithBool:isNotificationEnabled],
                                 @"is_deleted": [NSNumber numberWithBool:isDelete],
                                 @"number_of_days": [NSNumber numberWithInt:programDays],
                                 @"conversation_title":conversationTitle
                                 };
    
    
    return [self POST:MT_PROGRAM_UPSERT
           parameters:parameters
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                  
                  if (success != nil) {
                      success(responseObject);
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DLog(@"registerUser error: %@", error);
                  if (failure != nil) {
                      failure(error);
                  }
              }];
    
}

- (NSURLSessionDataTask *)joinProgram:(NSString *)programName
                            shareCode:(NSString *)shareCode
                              success:(void (^)( id  _Nonnull responseObject))success
                              failure:(void (^)(NSError *error))failure {
    [self initUser];
    
    NSDictionary *parameters = @{@"program_name":programName,
                                 @"program_code": shareCode,};
    
    return [self POST:MT_JOIN_PROGRAM
           parameters:parameters
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                  
                  if (success != nil) {
                      success(responseObject);
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DLog(@"registerUser error: %@", error);
                  if (failure != nil) {
                      failure(error);
                  }
              }];
    
}

- (NSURLSessionDataTask *)getUserConversationsWithSuccess:(void (^)(NSArray<MTLConversation *> *conversations))success
                                                  failure:(void (^)(NSError *error))failure {
    [self initUser];
    
    NSDictionary *parameters = @{};
    
    return [self GET:MT_GET_CONVERSTIONS
          parameters:parameters
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                 
                 if([[responseObject objectForKey:@"status"] integerValue] != nil && [[responseObject objectForKey:@"status"] integerValue] == Success){
                     
                     NSMutableArray<MTLConversation *> *conversations = [[NSMutableArray alloc] init];
                     NSMutableArray *contents = [[NSMutableArray alloc] init];
                     NSArray *contentsDictionary = [responseObject valueForKeyPath:@"data"];
                     if (contentsDictionary != nil) {
                         for (NSDictionary *contentDictionary in contentsDictionary) {
                             NSError *error;
                             MTLConversation *converestion = [MTLJSONAdapter modelOfClass:MTLConversation.class
                                                                       fromJSONDictionary:contentDictionary
                                                                                    error:&error];
                             [conversations addObject:converestion];
                             
                         }
                         
                         if (success != nil) {
                             success(conversations);
                         } else {
                             failure([[NSError alloc] initWithDomain:MTAPIErrorDomain
                                                                code:[[responseObject objectForKey:@"status"] integerValue]
                                                            userInfo:nil]);
                         }
                     }
                 }
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 DLog(@"registerUser error: %@", error);
                 if (failure != nil) {
                     failure(error);
                 }
             }];
    
}

- (NSURLSessionDataTask *)getMessagesForConversation:(NSString *)conversationId
                                             success:(void (^)(NSArray<MTLMessage *> *messages))success
                                             failure:(void (^)(NSError *error))failure {
    [self initUser];
    
    NSDictionary *parameters = @{@"conversation_id":conversationId != nil ? conversationId : @""};
    
    return [self POST:MT_GET_MESSAGES
           parameters:parameters
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                  
                  
                  if([[responseObject objectForKey:@"status"] integerValue] != nil && [[responseObject objectForKey:@"status"] integerValue] == Success){
                      
                      NSMutableArray<MTLMessage *> *messages = [[NSMutableArray alloc] init];
                      NSMutableArray *contents = [[NSMutableArray alloc] init];
                      NSArray *contentsDictionary = [responseObject valueForKeyPath:@"data"];
                      if (contentsDictionary != nil) {
                          for (NSDictionary *contentDictionary in contentsDictionary) {
                              NSError *error;
                              MTLMessage *message = [MTLJSONAdapter modelOfClass:MTLMessage.class
                                                              fromJSONDictionary:contentDictionary
                                                                           error:&error];
                              [messages addObject:message];
                              
                          }
                          
                          if (success != nil) {
                              success(messages);
                          } else {
                              failure([[NSError alloc] initWithDomain:MTAPIErrorDomain
                                                                 code:[[responseObject objectForKey:@"status"] integerValue]
                                                             userInfo:nil]);
                          }
                      }
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DLog(@"registerUser error: %@", error);
                  if (failure != nil) {
                      failure(error);
                  }
              }];
    
}

- (NSURLSessionDataTask *)sendMessageWithConversationId:(NSString *) conversationId
                                                message:(NSString *) message
                                                  image:(NSString *) image
                                             messageTyp:(NSString *) messageType
                                                   date:(NSString *) date
                                              imageType:(NSString *) imageType
                                               awardsId:(NSString *) awardsId
                                          notificaionId:(NSString *) notificationId
                                                success:(void (^)(int *status))success
                                                failure:(void (^)(NSError *error))failure {
    [self initUser];
    
    NSDictionary *parameters = @{@"conversation_id":conversationId != nil ? conversationId : @"",
                                 @"message":message,
                                 @"image":image,
                                 @"message_type":messageType,
                                 @"date":date,
                                 @"image_type":imageType,
                                 @"award_cms_id":awardsId,
                                 @"notification_cms_id":notificationId};
    
    return [self POST:MT_SEND_MESSAGE
           parameters:parameters
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                  
                  
                  if([[responseObject objectForKey:@"status"] integerValue] != nil && [[responseObject objectForKey:@"status"] integerValue] == Success){
                      
                      int status = [[responseObject objectForKey:@"status"] intValue];
                      if (success != nil) {
                          success(status);
                      }
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DLog(@"registerUser error: %@", error);
                  if (failure != nil) {
                      failure(error);
                  }
              }];
}

- (NSURLSessionDataTask *)settingsUpsert:(UpsertAction *)action
                               settingId:(int *) settingId
                                  userId:(int *) userId
                                language:(NSString *) language
                              unitLength:(NSString *) unitLength
                              unitWeigth:(NSString *) unitWeigth
                              unitVolume:(NSString *) unitVolume
                                timezone:(NSString *) timezone
                   isNotificationEnabled:(int *)isNotificationEnabled
                       conversationTitle:(NSString *)conversationTitle
                                 success:(void (^)(int *status))success
                                 failure:(void (^)(NSError *error))failure {
    [self initUser];
    
    NSDictionary *parameters = @{@"language":language != nil ? language : @""};
    
    return [self POST:MT_SETTINGS_UPSERT
           parameters:parameters
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                  
                  int status = [[responseObject objectForKey:@"status"] intValue];
                  if (success != nil) {
                      success(status);
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DLog(@"registerUser error: %@", error);
                  if (failure != nil) {
                      failure(error);
                  }
              }];
    
}

- (NSURLSessionDataTask *) programDayUpsert:(UpsertAction *)action
                                     params:(NSDictionary *) params
                                    success:(void (^)(int *status))success
                                    failure:(void (^)(NSError *error))failure {
    [self initUser];
    return [self POST:MT_DAY_ACTIVITIES_UPSERT parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        int status = [[responseObject objectForKey:@"status"] intValue];
        if (success != nil) {
            success(status);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"registerUser error: %@", error);
        if (failure != nil) {
            failure(error);
        }
    }];
}

- (NSURLSessionDataTask *) userProgramsWithSuccess:(void (^)(NSDictionary *programs))success
                                           failure:(void (^)(NSError *error))failure{
    [self initUser];
    return [self POST:MT_PROGRAMS parameters:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success != nil) {
            success(responseObject);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"registerUser error: %@", error);
        if (failure != nil) {
            failure(error);
        }
    }];
}

- (NSURLSessionDataTask *) recipesUpsertWithSuccess:(void (^)(int *status))success
                                            failure:(void (^)(NSError *error))failure {
    [self initUser];
    return [self POST:MT_RECIPIES
           parameters:@{}
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                  if (success != nil) {
                      //                      success(responseObject);
                  }
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DLog(@"registerUser error: %@", error);
                  if (failure != nil) {
                      failure(error);
                  }
              }];
}


- (NSURLSessionDataTask *) userRecipes:(NSDictionary *)recipes
                               success:(void (^)(NSDictionary *programs))success
                               failure:(void (^)(NSError *error))failure{
    [self initUser];
    return [self POST:MT_RECIPIES
           parameters:recipes
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                  if (success != nil) {
                      success(responseObject);
                      
                  }
                  
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DLog(@"userRecipes error: %@", error);
                  if (failure != nil) {
                      failure(error);
                  }
                  
              }];
}


- (NSURLSessionDataTask *) sendRecipe:(NSDictionary *)recipes
                              success:(void (^)(int *status))success
                              failure:(void (^)(NSError *error))failure {
    [self initUser];
    return [self POST:MT_RECIPIES_UPSERT
           parameters:recipes
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                  int status = [[responseObject objectForKey:@"status"] intValue];
                  if (success != nil) {
                      success(status);
                  }
                  
                  
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DLog(@"userRecipes error: %@", error);
                  if (failure != nil) {
                      failure(error);
                  }
                  
              }];
}

@end
