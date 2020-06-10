//
//  FITAPIManager.h
//  FIT
//
//  Created by Karim Sallam on 09/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTAPIManager.h"
#import "CMSAPIManager.h"

@class User, Program;

@interface FITAPIManager : NSObject

+ (id)sharedManager;

@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *language;

#pragma mark Middle Tier Call Mapping
- (NSURLSessionDataTask *)registerUserUsingMethod:(RegistrationMethod *)method
                                            email:(NSString *)email
                                         password:(NSString *)password
                                         username:(NSString *)username
                                              age:(NSUInteger)age
                                           gender:(NSString *)gender
                                           height:(NSUInteger)height
                                           weight:(NSUInteger)weight
                                            image:(NSString *)image
                                       idFacebook:(NSString *)idFacebook
                                         idFLP360:(NSString *)idFLP360
                                          success:(void (^)(User *user))success
                                          failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)loginUsingEmail:(NSString *)email
                                 password:(NSString *)password
                                  success:(void (^)(User *user))success
                                  failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)confirmLoginUsingEmail:(NSString *)email
                                        password:(NSString *)password
                                      idFacebook:(NSString *)idFacebook
                                        idFLP360:(NSString *)idFLP360
                                         success:(void (^)(User *user))success
                                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)checkEmail:(NSString *)email
                             success:(void (^)(int *status))success
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
                                success:(void (^)(User *user))success
                                failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)passwordResetUsingEmail:(NSString *)email
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
                                success:(void (^)( id  _Nonnull responseObject))success
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

#pragma mark CMS Groundswell Call Mapping
- (NSURLSessionDataTask *)getContentsWithSuccess:(void (^)(RLMResults<Content *> *contents))success
                                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getAwardsWithSuccess:(void (^)(NSArray<FITAwards *> *awards))success
                                       failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getSupplementsForProgram:(FITProgram)program
                                           success:(void (^)(Program *program))success
                                           failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getSupplementsForProgram:(FITProgram)program
                                              days:(FITDays)days
                                           success:(void (^)(Program *program))success
                                           failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getExercise:(FITExercise)exercise
                              success:(void (^)(void))success
                              failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *) getFreeFoodWithSuccess:(void (^)(NSArray<FITFreeFood *> *awards))success
                                          failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *) getRecipesForProgram:(UserCourseType)courseType
                                        success:(void (^)(NSArray<FITRecipes *> *recipes))success
                                        failure:(void (^)(NSError *error))failure;

// Exercise
- (void) getExercisesDataFromFITCMS;

- (NSURLSessionDataTask *) getLocalesList;

- (NSURLSessionDataTask *)getIngredientsWithSuccess:(void (^)(NSArray<FLPIngredients *> *ingredients))success
                                            failure:(void (^)(NSError *error))failure;

@end
