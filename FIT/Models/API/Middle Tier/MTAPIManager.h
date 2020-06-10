//
//  MTAPIManager.h
//  FIT
//
//  Created by Hamid Mehmood on 08/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTSessionManager.h"
#import "FITAPIConstant.h"
#import "FITAPIManager.h"
#import "BaseResponse.h"

@class MTLUser;

@interface MTAPIManager : MTSessionManager

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
                                          failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)loginUsingEmail:(NSString *)email
                                 password:(NSString *)password
                                  success:(void (^)(MTLUser *user))success
                                  failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)confirmLoginUsingEmail:(NSString *)email
                                        password:(NSString *)password
                                      idFacebook:(NSString *)idFacebook
                                        idFLP360:(NSString *)idFLP360
                                         success:(void (^)(MTLUser *user))success
                                         failure:(void (^)(NSError *error))failure;

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
                                failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)passwordResetUsingEmail:(NSString *)email
                                          success:(void (^)(int *user))success
                                          failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)checkEmail:(NSString *)email
                             success:(void (^)(int *status))success
                             failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)programUpsert:(UpsertAction *)action
                              programId:(int *) programId
                            programName:(NSString *) programName
                              startDate:(NSString *) stratDate
                            isCompleted:(BOOL *)isCompleted
                   isNotificationEnable:(BOOL *)isNotificationEnabled
                               isDelete:(BOOL *)isDelete
                            programDays:(int *)programDays
                      conversationTitle:(NSString *)conversationTitle
                                success:(void (^)(id  _Nonnull responseObject))success
                                failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)joinProgram:(NSString *)programName
                            shareCode:(NSString *)shareCode
                              success:(void (^)( id  _Nonnull responseObject))success
                              failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getUserConversationsWithSuccess:(void (^)(NSArray<MTLConversation *> *conversations))success
                                                  failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getMessagesForConversation:(NSString *)conversationId
                                             success:(void (^)(NSArray<MTLMessage *> *messages))success
                                             failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)sendMessageWithConversationId:(NSString *) conversationId
                                                message:(NSString *) message
                                                  image:(NSString *) image
                                             messageTyp:(NSString *) messageType
                                                   date:(NSString *) date
                                              imageType:(NSString *) imageType
                                               awardsId:(NSString *) awardsId
                                          notificaionId:(NSString *) notificationId
                                                success:(void (^)(int *status))success
                                                failure:(void (^)(NSError *error))failure;

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
                                 failure:(void (^)(NSError *error))failure;


- (NSURLSessionDataTask *) programDayUpsert:(UpsertAction *)action
                                     params:(NSDictionary *) params
                                    success:(void (^)(int *status))success
                                    failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *) userProgramsWithSuccess:(void (^)(NSDictionary *programs))success
                                           failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *) userSettingsWithSuccess:(void (^)(int *status))success
                                           failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *) recipesUpsertWithSuccess:(void (^)(int *status))success
                                            failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *) userRecipes:(NSDictionary *)recipes
                               success:(void (^)(NSDictionary *programs))success
                               failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *) sendRecipe:(NSDictionary *)recipes
                               success:(void (^)(int *status))success
                              failure:(void (^)(NSError *error))failure;
@end
