//
//  FITAPIManager.m
//  FIT
//
//  Created by Karim Sallam on 09/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "FITAPIManager.h"
#import "Utils.h"
#import "Water.h"
#import "Measurement.h"
#import "Supplements.h"
#import "Meal.h"
#import "Exercise.h"
#import "CourseDay.h"
#import "CustomRecipe.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation FITAPIManager

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    return self;
}

+ (id)sharedManager {
    static FITAPIManager *_APIManager = nil;
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:92 / 255.0f green:38 / 255.0f blue:132 / 255.0f alpha:1.0f]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _APIManager = [[self alloc] init];
    });
    
    return _APIManager;
}

- (void)setCountry:(NSString *)country {
    if (_country != country) {
        _country = country;
        User *user = [User userInDB];
        if(user != nil){
            [[CMSAPIManager sharedManager] setCountry:user.country];
        } else {
            NSString *country = [[NSUserDefaults standardUserDefaults]
                                 stringForKey:@"country"];
            [[CMSAPIManager sharedManager] setCountry:country];
        }
    }
}

- (void)setLanguage:(NSString *)language {
    if (_language != language) {
        _language = language;
        User *user = [User userInDB];
        if(user != nil){
            [[CMSAPIManager sharedManager] setLanguage:user.language];
        } else {
            
            NSString *lang = [[NSUserDefaults standardUserDefaults]
                              stringForKey:@"language"];
            [[CMSAPIManager sharedManager] setLanguage:lang];
        }
    }
}

- (void)saveMantleUser:(MTLUser *)mantleUser
            completion:(void(^)(User *user))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        RLMResults<User *> *users = [User allObjects];
        [realm beginWriteTransaction];
        [realm deleteObjects:users];
        [realm commitWriteTransaction];
        
        User *user = [[User alloc] initWithMantleModel:mantleUser];
        
        NSString *lang = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"language"];
        NSString *country = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"country"];
        user.language = lang;
        user.country = country;
        [realm beginWriteTransaction];
        [realm addObject:user];
        [realm commitWriteTransaction];
        if (completion != nil) {
            completion(user);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            if (completion != nil) {
                User *user = [[User allObjects] firstObject];
                completion(user);
            }
        });
    });
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
                                       idFacebook:(NSString *)idFacebook
                                         idFLP360:(NSString *)idFLP360
                                          success:(void (^)(User *user))success
                                          failure:(void (^)(NSError *error))failure {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[MTAPIManager sharedManager] registerUserUsingMethod:method
                                                           email:email
                                                        password:password
                                                        username:username
                                                             age:age
                                                          gender:gender
                                                          height:height
                                                          weight:weight
                                                           image:image
                                                       imageType:@"Base64"
                                                      idFacebook:idFacebook
                                                        idFLP360:idFLP360
                                                         success:^(MTLUser *user) {
                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                 [SVProgressHUD dismiss];
                                                             });
                                                             [self saveMantleUser:user
                                                                       completion:success];
                                                         }
                                                         failure:^(NSError *error) {
                                                             
                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                 [SVProgressHUD dismiss];
                                                             });
                                                             if (failure != nil) {
                                                                 failure(error);
                                                             }
                                                         }];
}

- (NSURLSessionDataTask *)loginUsingEmail:(NSString *)email
                                 password:(NSString *)password
                                  success:(void (^)(User *user))success
                                  failure:(void (^)(NSError *error))failure{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    
    return [[MTAPIManager sharedManager] loginUsingEmail:email
                                                password:password
                                                 success:^(MTLUser *user) {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         [SVProgressHUD dismiss];
                                                     });
                                                     
                                                     [self saveMantleUser:user
                                                               completion:success];
                                                 }
                                                 failure:^(NSError *error) {
                                                     
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         [SVProgressHUD dismiss];
                                                     });
                                                     if (failure != nil) {
                                                         failure(error);
                                                     }
                                                 }];
}

- (NSURLSessionDataTask *)confirmLoginUsingEmail:(NSString *)email
                                        password:(NSString *)password
                                      idFacebook:(NSString *)idFacebook
                                        idFLP360:(NSString *)idFLP360
                                         success:(void (^)(User *user))success
                                         failure:(void (^)(NSError *error))failure {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    
    return [[MTAPIManager sharedManager] confirmLoginUsingEmail:email
                                                       password:password
                                                     idFacebook:idFacebook
                                                       idFLP360:idFLP360
                                                        success:^(User *user) {
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                [SVProgressHUD dismiss];
                                                            });
                                                            
                                                            [self saveMantleUser:user
                                                                      completion:success];
                                                        } failure:^(NSError *error) {
                                                            
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                [SVProgressHUD dismiss];
                                                            });
                                                            if (failure != nil) {
                                                                failure(error);
                                                            }
                                                        }];
}

- (NSURLSessionDataTask *)confirmLoginUsingEmail:(NSString *)email
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
                                         failure:(void (^)(NSError *error))failure {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    
    return [[MTAPIManager sharedManager] confirmLoginUsingEmail:email
                                                       password:password
                                                       username:username
                                                            age:age
                                                         gender:gender
                                                         height:height
                                                         weight:weight
                                                          image:image
                                                     idFacebook:idFacebook
                                                       idFLP360:idFLP360
                                                        success:^(User *user) {
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                [SVProgressHUD dismiss];
                                                            });
                                                            [self saveMantleUser:user
                                                                      completion:success];
                                                        }
                                                        failure:^(NSError *error) {
                                                            
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                                [SVProgressHUD dismiss];
                                                            });
                                                            if (failure != nil) {
                                                                failure(error);
                                                            }
                                                        }];
    
}

- (NSURLSessionDataTask *)checkEmail:(NSString *)email
                             success:(void (^)(int *status))success
                             failure:(void (^)(NSError *error))failure{
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        [SVProgressHUD show];
    //    });
    return [[MTAPIManager sharedManager] checkEmail:email success:success failure:failure];
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
                                success:(void (^)(User *user))success
                                failure:(void (^)(NSError *error))failure{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return  [[MTAPIManager sharedManager] updateProfile:email password:password username:username age:age gender:gender height:height weight:weight image:image imageType:imageType idFacebook:idFacebook idFLP360:idFLP360 success:^(User *user) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        [self saveMantleUser:user
                  completion:success];
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        if (failure != nil) {
            failure(error);
        }
    }];
}

- (NSURLSessionDataTask *)passwordResetUsingEmail:(NSString *)email
                                          success:(void (^)(int *status))success
                                          failure:(void (^)(NSError *error))failure{
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //    [SVProgressHUD show];
    //});
    return [[MTAPIManager sharedManager] passwordResetUsingEmail:email success:success failure:failure];
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
                                failure:(void (^)(NSError *error))failure{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[MTAPIManager sharedManager] programUpsert:action
                                             programId:programId
                                           programName:programName
                                             startDate:startDate
                                           isCompleted:isCompleted
                                  isNotificationEnable:isNotificationEnabled
                                              isDelete:isDelete
                                           programDays:programDays
                                     conversationTitle:conversationTitle success:^(id  _Nonnull responseObject) {
                                         
                                         
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             [SVProgressHUD dismiss];
                                         });
                                         if (success != nil) {
                                             success(responseObject);
                                         }
                                     } failure:^(NSError *error) {
                                         
                                         DLog(@"programUpsert error: %@", error);
                                         
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             [SVProgressHUD dismiss];
                                         });
                                         if (failure != nil) {
                                             failure(error);
                                         }
                                     }];
}

- (NSURLSessionDataTask *)joinProgram:(NSString *)programName
                            shareCode:(NSString *)shareCode
                              success:(void (^)( id  _Nonnull responseObject))success
                              failure:(void (^)(NSError *error))failure{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[MTAPIManager sharedManager] joinProgram:programName shareCode:shareCode success:^(id  _Nonnull responseObject) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        if (success != nil) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        DLog(@"joinProgram error: %@", error);
        if (failure != nil) {
            failure(error);
        }
    }];
}


- (NSURLSessionDataTask *)getUserConversationsWithSuccess:(void (^)(NSArray<MTLConversation *> *conversations))success
                                                  failure:(void (^)(NSError *error))failure{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[MTAPIManager sharedManager] getUserConversationsWithSuccess:^(NSArray<MTLConversation *> *conversations) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        if(success != nil) {
            success(conversations);
        }
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        if(failure != nil) {
            failure(error);
        }
    }];
}

- (NSURLSessionDataTask *)getMessagesForConversation:(NSString *)conversationId
                                             success:(void (^)(NSArray<MTLMessage *> *messages))success
                                             failure:(void (^)(NSError *error))failure {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[MTAPIManager sharedManager] getMessagesForConversation:conversationId success:^(NSArray<MTLMessage *> *messages) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        if(success != nil) {
            success(messages);
        }
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        if(failure != nil) {
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
                                                failure:(void (^)(NSError *error))failure{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[MTAPIManager sharedManager] sendMessageWithConversationId:conversationId message:message image:image messageTyp:messageType date:date imageType:imageType awardsId:awardsId notificaionId:notificationId success:^(int *status) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        if (success != nil) {
            success(status);
        }
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        DLog(@"joinProgram error: %@", error);
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
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[MTAPIManager sharedManager] settingsUpsert:action
                                              settingId:settingId
                                                 userId:userId
                                               language:language
                                             unitLength:unitLength
                                             unitWeigth:unitWeigth
                                             unitVolume:unitVolume
                                               timezone:timezone
                                  isNotificationEnabled:isNotificationEnabled
                                      conversationTitle:conversationTitle
                                                success:^(int *status) {
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [SVProgressHUD dismiss];
                                                    });
                                                    if (success != nil) {
                                                        success(status);
                                                    }
                                                } failure:^(NSError *error) {
                                                    
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        [SVProgressHUD dismiss];
                                                    });
                                                    DLog(@"settingsUpsert error: %@", error);
                                                    if (failure != nil) {
                                                        failure(error);
                                                    }
                                                }];
}


- (NSURLSessionDataTask *) programDayUpsert:(UpsertAction *)action
                                     params:(NSDictionary *) params
                                    success:(void (^)(int *status))success
                                    failure:(void (^)(NSError *error))failure {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[MTAPIManager sharedManager] programDayUpsert:action params:params success:^(int *status) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        if (success != nil) {
            success(status);
        }
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        DLog(@"programDayUpsert error: %@", error);
        if (failure != nil) {
            failure(error);
        }
    }];
    //TODO FIXXXX
    return nil;
}

- (NSURLSessionDataTask *) userProgramsWithSuccess:(void (^)(NSDictionary *programs))success
                                           failure:(void (^)(NSError *error))failure{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[MTAPIManager sharedManager] userProgramsWithSuccess:^(NSDictionary *programs) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        @try{
            bool isFirstTime = YES;
            if (programs != nil) {
                //TODO here update all data inside the table
                //            NSLog(@"%@", programs);
                //            success(MT_CODE_SUCCESS);
                
                NSArray *data = [programs valueForKey:@"data"];
                
                for(NSDictionary *eachProgram in data) {
                    NSLog(@"%@",eachProgram);
                    
                    if([eachProgram[@"is_deleted"] boolValue]) {
                        continue;
                    }
                    
                    
                    RLMRealm *realm = [RLMRealm defaultRealm];
                    [realm beginWriteTransaction];
                    
                    // Course Program
                    UserCourse *userCourse = [[UserCourse alloc] init];
                    userCourse.programName = eachProgram[@"program_name"];
                    userCourse.userProgramId = [[Utils sharedUtils] UUIDString];
                    
                    RLMResults *existanceCourse = [UserCourse objectsWhere:[NSString stringWithFormat:@"serverProgramId = %ld",[eachProgram[@"program_id"] integerValue]]];
                    if([existanceCourse count] > 0) {
                        userCourse.userProgramId = [existanceCourse firstObject][@"userProgramId"];
                    } else {
                        userCourse.userProgramId = [[Utils sharedUtils] UUIDString];
                    }
                    
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyy-MM-dd"];
                    NSDate *dateFromString = [[NSDate alloc] init];
                    dateFromString = [dateFormatter dateFromString:eachProgram[@"start_date"]];
                    
                    
                    userCourse.serverProgramId = eachProgram[@"program_id"];
                    userCourse.startDate = dateFromString;
                    userCourse.conversationId = eachProgram[@"conversation_id"];
                    userCourse.programDays = eachProgram[@"number_of_days"];
                    userCourse.shareCode = eachProgram[@"program_code"];
                    
                    if([eachProgram[@"program_name"] isEqualToString:COURSE_PROGRAM_NAME_C9]) {
                        userCourse.courseType = @(C9);
                    } else if([eachProgram[@"program_name"] isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER1]) {
                        userCourse.courseType = @(F15Begginner1);
                    } else if([eachProgram[@"program_name"] isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER2]) {
                        userCourse.courseType = @(F15Begginner2);
                    }else if([eachProgram[@"program_name"] isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE1]) {
                        userCourse.courseType = @(F15Intermidiate1);
                    } else if([eachProgram[@"program_name"] isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE2]) {
                        userCourse.courseType = @(F15Intermidiate2);
                    } else if([eachProgram[@"program_name"] isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED1]) {
                        userCourse.courseType = @(F15Advance1);
                    } else if([eachProgram[@"program_name"] isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED2]) {
                        userCourse.courseType = @(F15Advance2);
                    }
                    
                    userCourse.isCurrentCourse = YES;
                    
                    //                NSDate *today = [NSDate date];
                    //                NSComparisonResult result;
                    //                //NSOrderedSame,NSOrderedDescending, NSOrderedAscending
                    //
                    //                result = [today compare:dateFromString];
                    
                    
                    if([eachProgram[@"is_completed"] boolValue]) {
                        userCourse.status = @(STATUS_COMPLETED);
                    } else {
                        //                    if ( result == NSOrderedAscending) {
                        //Future Programs Waiting
                        if(isFirstTime) {
                            if([userCourse.courseType integerValue] == C9){
                                if([[Utils sharedUtils] getCurrentDayWithStartDate:userCourse.startDate] > 9){
                                    userCourse.status = @(STATUS_COMPLETED);
                                } else {
                                    userCourse.status = @(STATUS_IN_PROGRESS);
                                    isFirstTime = NO;
                                }
                            } else {
                                if([[Utils sharedUtils] getCurrentDayWithStartDate:userCourse.startDate] > 15){
                                    userCourse.status = @(STATUS_COMPLETED);
                                } else {
                                    userCourse.status = @(STATUS_IN_PROGRESS);
                                    isFirstTime = NO;
                                }
                            }
                            
                        } else {
                            if([userCourse.courseType integerValue] == C9){
                                if([[Utils sharedUtils] getCurrentDayWithStartDate:userCourse.startDate] > 9){
                                    userCourse.status = @(STATUS_COMPLETED);
                                } else {
                                    userCourse.status = @(STATUS_WAITING);
                                }
                            } else {
                                if([[Utils sharedUtils] getCurrentDayWithStartDate:userCourse.startDate] > 15){
                                    userCourse.status = @(STATUS_COMPLETED);
                                } else {
                                    userCourse.status = @(STATUS_WAITING);
                                }
                            }
                        }
                        
                    }
                    //                NSLog(@"Days %lu",[ ]);
                    
                    [realm addOrUpdateObject:userCourse];
                    [realm commitWriteTransaction];
                    
                    
                    
                    
                    
                    NSArray *allDaysData = [eachProgram valueForKey:@"days"];
                    for( NSDictionary *eachDayData in allDaysData) {
                        NSLog(@"%@",eachDayData);
                        //here load USerDay table
                        NSString *dayNumber = [NSString stringWithFormat:@"%@",eachDayData[@"day"]];
                        [realm beginWriteTransaction];
                        CourseDay *programDay = [[CourseDay alloc] init];
                        programDay.dayId = [NSString stringWithFormat:@"%@%@",userCourse.userProgramId, eachDayData[@"day"]];
                        programDay.day = dayNumber;
                        programDay.serverDayId = [NSString stringWithFormat:@"%@",eachDayData[@"day_id"]];
                        programDay.programID = userCourse.userProgramId;
                        [realm addOrUpdateObject:programDay];
                        [realm commitWriteTransaction];
                        
                        NSArray *waterData = eachDayData[@"water"];
                        if([waterData count] > 0) {
                            [realm beginWriteTransaction];
                            Water *water = [[Water alloc] init];
                            
                            NSLog(@"%d",[[[waterData firstObject] valueForKey:@"actual_intake"] intValue]);
                            
                            water.day = dayNumber;//eachDayData[@"day"];
                            water.count = [[[waterData firstObject] valueForKey:@"actual_intake"] intValue];
                            water.serverWaterId = [[waterData firstObject] valueForKey:@"water_id"];
                            
                            if([existanceCourse count] > 0) {
                                water.programID = [existanceCourse firstObject][@"userProgramId"];
                            } else {
                                water.programID = [[Utils sharedUtils] UUIDString];
                            }
                            
                            
                            
                            NSLog(@"%@",water.programID);
                            RLMResults *existanceWaterDay = [Water objectsWhere:[NSString stringWithFormat:@"programID == '%@' && day == '%@'",water.programID, water.day]];
                            if([existanceWaterDay count] > 0) {
                                water.uid = [existanceWaterDay firstObject][@"uid"];
                            } else {
                                water.uid = [[Utils sharedUtils] UUIDString];
                            }
                            
                            
                            [realm addOrUpdateObject:water];
                            [realm commitWriteTransaction];
                        }
                        
                        
                        
                        NSArray *measurementsData = eachDayData[@"measurements"];
                        Measurement *measurement = [[Measurement alloc] init];
                        measurement.calf = @0;
                        measurement.weight = @0;
                        measurement.chest = @0;
                        measurement.thigh = @0;
                        measurement.arm = @0;
                        measurement.waist = @0;
                        if([measurementsData count] > 0) {
                            [realm beginWriteTransaction];
                            for(NSDictionary *eachDayMeasurment in measurementsData) {
                                
                                if([[eachDayMeasurment valueForKey:@"measurement_type"] isEqualToString:@"thigh"]) {
                                    measurement.thigh = [eachDayMeasurment valueForKey:@"measurement_value"];
                                } else if([[eachDayMeasurment valueForKey:@"measurement_type"] isEqualToString:@"arm"]) {
                                    measurement.arm = [eachDayMeasurment valueForKey:@"measurement_value"];
                                } else if([[eachDayMeasurment valueForKey:@"measurement_type"] isEqualToString:@"knee"]) {
                                    measurement.calf = [eachDayMeasurment valueForKey:@"measurement_value"];
                                } else if([[eachDayMeasurment valueForKey:@"measurement_type"] isEqualToString:@"hip"]) {
                                    measurement.hip = [eachDayMeasurment valueForKey:@"measurement_value"];
                                } else if([[eachDayMeasurment valueForKey:@"measurement_type"] isEqualToString:@"waist"]) {
                                    measurement.waist = [eachDayMeasurment valueForKey:@"measurement_value"];
                                } else if([[eachDayMeasurment valueForKey:@"measurement_type"] isEqualToString:@"chest"]) {
                                    measurement.chest = [eachDayMeasurment valueForKey:@"measurement_value"];
                                } else if([[eachDayMeasurment valueForKey:@"measurement_type"] isEqualToString:@"weight"]) {
                                    measurement.weight = [eachDayMeasurment valueForKey:@"measurement_value"];
                                }
                                measurement.totalMeasurements = eachDayData[@"totalInches"];
                                
                            }
                            
                            measurement.day = dayNumber;//eachDayData[@"day"];
                            if([existanceCourse count] > 0) {
                                measurement.programID = [existanceCourse firstObject][@"userProgramId"];
                            } else {
                                measurement.programID = [[Utils sharedUtils] UUIDString];
                            }
                            
                            
                            
                            NSLog(@"%@",measurement.programID);
                            RLMResults *existanceMeasurementDay = [Measurement objectsWhere:[NSString stringWithFormat:@"programID == '%@' && day == '%@'",measurement.programID, measurement.day]];
                            if([existanceMeasurementDay count] > 0) {
                                measurement.measurementId = [existanceMeasurementDay firstObject][@"measurementId"];
                            } else {
                                measurement.measurementId = [NSString stringWithFormat:@"%@_%@",measurement.programID,measurement.day];
                            }
                            
                            [realm addOrUpdateObject:measurement];
                            [realm commitWriteTransaction];
                            
                            
                        }
                        
                        
                        
                        
                        
                        NSArray *eachDaySupplementsData = eachDayData[@"supplements"];
                        
                        if([eachDaySupplementsData count] > 0) {
                            for(NSDictionary *eachFoodSupplement in eachDaySupplementsData) {
                                [realm beginWriteTransaction];
                                Supplements *supplements = [[Supplements alloc] init];
                                NSLog(@"each day supp : %@",eachFoodSupplement);
                                
                                supplements.partOfDay = [eachFoodSupplement valueForKey:@"part_of_day"];
                                supplements.day = dayNumber;//eachDayData[@"day"];
                                supplements.serverSupplementId = [eachFoodSupplement valueForKey:@"supplement_id"];
                                supplements.supplementID = [eachFoodSupplement valueForKey:@"cmsID"];
                                supplements.isChecked = YES;
                                
                                
                                
                                if([existanceCourse count] > 0) {
                                    supplements.programID = [existanceCourse firstObject][@"userProgramId"];
                                } else {
                                    supplements.programID = [[Utils sharedUtils] UUIDString];
                                }
                                
                                
                                
                                NSLog(@"%@",supplements.programID);
                                RLMResults *existanceFoodDaySupplement = [Supplements objectsWhere:[NSString stringWithFormat:@"programID == '%@' && day == '%@' && partOfDay == '%@' && supplementID == '%@' ",supplements.programID, supplements.day, supplements.partOfDay, supplements.supplementID]];
                                if([existanceFoodDaySupplement count] > 0) {
                                    supplements.uid = [existanceFoodDaySupplement firstObject][@"uid"];
                                } else {
                                    supplements.uid = [[Utils sharedUtils] UUIDString];
                                }
                                
                                [realm addOrUpdateObject:supplements];
                                [realm commitWriteTransaction];
                                
                            }
                            
                            
                            
                        }
                        
                        
                        NSArray *eachDayMealData = eachDayData[@"meals"];
                        
                        if([eachDayMealData count] > 0) {
                            for(NSDictionary *eachFoodMeal in eachDayMealData) {
                                [realm beginWriteTransaction];
                                Meal *meal = [[Meal alloc] init];
                                NSLog(@"each day meal : %@",eachFoodMeal);
                                
                                meal.partOfDay = [eachFoodMeal valueForKey:@"part_of_day"];
                                meal.day = dayNumber;//eachDayData[@"day"];
                                meal.serverMealId = [eachFoodMeal valueForKey:@"meal_id"];
                                meal.foodID = [eachFoodMeal valueForKey:@"cms_id"];
                                
                                
                                
                                if([existanceCourse count] > 0) {
                                    meal.programID = [existanceCourse firstObject][@"userProgramId"];
                                } else {
                                    meal.programID = [[Utils sharedUtils] UUIDString];
                                }
                                
                                
                                
                                NSLog(@"%@",meal.programID);
                                RLMResults *existanceFoodDayMeal = [Meal objectsWhere:[NSString stringWithFormat:@"programID == '%@' && day == '%@' && partOfDay == '%@'",meal.programID, meal.day, meal.partOfDay]];
                                if([existanceFoodDayMeal count] > 0) {
                                    meal.uid = [existanceFoodDayMeal firstObject][@"uid"];
                                } else {
                                    meal.uid = [[Utils sharedUtils] UUIDString];
                                }
                                
                                [realm addOrUpdateObject:meal];
                                [realm commitWriteTransaction];
                                
                            }
                        }
                        
                        
                        
                        
                        NSArray *eachDayExerciseData = eachDayData[@"exercises"];
                        
                        if([eachDayExerciseData count] > 0) {
                            for(NSDictionary *eachExercise in eachDayExerciseData) {
                                NSNumber *exerciseType;
                                NSString *exerciseName = @"";
                                NSString *exercise_cms_id = [eachExercise valueForKey:@"exercise_cms_id"];
                                NSArray *chunks = [exercise_cms_id componentsSeparatedByString: @"|"];
                                
                                for (NSString *character in chunks) {
                                    Exercise *exercise = [[Exercise alloc] init];
                                    NSLog(@"each day meal : %@",eachExercise);
                                    exercise.day = dayNumber;//eachDayData[@"day"];
                                    exercise.serverExerciseId = [eachExercise valueForKey:@"exercise_id"];
                                    
                                    NSLog(@"%@",character);
                                    if([chunks[0] isEqualToString: @"0"]) {
                                        if([character isEqualToString:@"C"]){
                                            exerciseType = @3;
                                            exerciseName = @"thirtyMinutes";
                                        } else if([character isEqualToString:@"W"]) {
                                            exerciseType = @1;
                                            exerciseName = @"twoMinutes";
                                        } else if([character isEqualToString:@"E"]) {
                                            exerciseType = @2;
                                            exerciseName = @"fiveMinutes";
                                        }
                                    } else {
                                        if([character isEqualToString:@"C"]){
                                            exerciseType = @3;
                                            exerciseName = @"coolDown";
                                        } else if([character isEqualToString:@"W"]) {
                                            exerciseType = @1;
                                            exerciseName = @"warmUp";
                                        } else if([character isEqualToString:@"E"]) {
                                            exerciseType = @2;
                                            exerciseName = @"workOut";
                                        }
                                    }
                                    
                                    if(!([exerciseName isEqualToString:@""])){
                                        exercise.exerciseType = exerciseType;
                                        exercise.exerciseName = exerciseName;
                                        
                                        
                                        if([existanceCourse count] > 0) {
                                            exercise.programID = [existanceCourse firstObject][@"userProgramId"];
                                        } else {
                                            exercise.programID = [[Utils sharedUtils] UUIDString];
                                        }
                                        
                                        NSLog(@"%@",exercise.programID);
                                        RLMResults *existanceExerciseDay = [Exercise objectsWhere:[NSString stringWithFormat:@"programID == '%@' && day == '%@' && exerciseName == '%@'",exercise.programID, exercise.day, exercise.exerciseName]];
                                        if([existanceExerciseDay count] > 0) {
                                            exercise.uid = [existanceExerciseDay firstObject][@"uid"];
                                        } else {
                                            exercise.uid = [[Utils sharedUtils] UUIDString];
                                        }
                                        
                                        
                                        [realm beginWriteTransaction];
                                        [realm addOrUpdateObject:exercise];
                                        [realm commitWriteTransaction];
                                    }
                                }
                                
                                
                                
                            }
                            
                        }
                        
                        
                    }
                }
            }
        }
        @catch(NSException *exception ){
            DLog(@"WHYY");
        }@finally {
            
        }
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        DLog(@"joinProgram error: %@", error);
        if (failure != nil) {
            failure(error);
        }
    }];
}


- (NSURLSessionDataTask *) userSettingsWithSuccess:(void (^)(int *status))success
                                           failure:(void (^)(NSError *error))failure{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[MTAPIManager sharedManager] userSettingsWithSuccess:^(int *status) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
    
}

- (NSURLSessionDataTask *) recipesUpsertWithSuccess:(void (^)(int *status))success
                                            failure:(void (^)(NSError *error))failure{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[MTAPIManager sharedManager] recipesUpsertWithSuccess:^(int *status) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
}

- (NSURLSessionDataTask *) userRecipes:(NSDictionary *)recipes
                               success:(void (^)(NSDictionary *programs))success
                               failure:(void (^)(NSError *error))failure {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    
    return [[MTAPIManager sharedManager] userRecipes:recipes success:^(NSDictionary *recipes) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        
        NSArray *dataArray = [recipes valueForKey:@"data"];
        
        for (NSDictionary *recipe in dataArray) {
            
            int *typeccus;
            if([[recipe valueForKey:@"type"] isEqualToString:@"Meal"]) {
                typeccus = TYPE_MEAL;
            } else {
                typeccus = TYPE_SHAKE;
            }
            [realm beginWriteTransaction];
            
            [CustomRecipe createOrUpdateInRealm:realm withValue:@{
                                                                  @"isSynced" : @YES,
                                                                  @"recipeID": [recipe valueForKey:@"recipe_id"],
                                                                  @"name": [recipe valueForKey:@"name"],
                                                                  @"estimatedCalories" : [NSString stringWithFormat:@"%@",[recipe valueForKey:@"calories"]],
                                                                  @"description" :  [recipe valueForKey:@"description"],
                                                                  @"recipeType" : @0,
                                                                  @"programType" :  @0,
                                                                  
                                                                  }];
            
            //        @property NSNumber<RLMInt> * _Nullable recipeType;
            //        @property NSNumber<RLMInt> * _Nullable programType;
            
            
            
            [realm commitWriteTransaction];
        }
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
}



- (NSURLSessionDataTask *) sendRecipe:(NSDictionary *)recipes
                              success:(void (^)(int *status))success
                              failure:(void (^)(NSError *error))failure {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[MTAPIManager sharedManager] sendRecipe:recipes
                                            success:^(int *status) {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [SVProgressHUD dismiss];
                                                });
                                            } failure:^(NSError *error) {
                                                
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [SVProgressHUD dismiss];
                                                });
                                                
                                            }];
}



#pragma mark CMS Groundswell API mapping from here
- (NSURLSessionDataTask *)getContentsWithSuccess:(void (^)(RLMResults<Content *> *contents))success
                                         failure:(void (^)(NSError *error))failure {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[CMSAPIManager sharedManager] getContentsWithSuccess:^(NSArray<Content *> *contents) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        [self saveContents:contents
                completion:success];
    }
                                                         failure:^(NSError *error) {
                                                             
                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                 [SVProgressHUD dismiss];
                                                             });
                                                             if(failure != nil){
                                                                 failure(error);
                                                             }
                                                             
                                                         }];
}

- (NSURLSessionDataTask *)getAwardsWithSuccess:(void (^)(NSArray<FITAwards *> *awards))success
                                       failure:(void (^)(NSError *error))failure{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[CMSAPIManager sharedManager] getAwardsWithSuccess:^(NSArray<FITAwards *> *awards) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        if(success){
            success(awards);
        }
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        if(failure != nil){
            failure(error);
        }
        
    }];
}

- (void)saveContents:(NSArray<Content *> *)contents
          completion:(void(^)(RLMResults<Content *> *contents))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            RLMRealm *realm = [RLMRealm defaultRealm];
            
            [realm beginWriteTransaction];
            
            for (Content *content in contents) {
                [realm addOrUpdateObject:content];
            }
            
            [realm commitWriteTransaction];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                if (completion != nil) {
                    RLMResults<Content *> *contents = [Content allObjects];
                    completion(contents);
                }
            });
        }
    });
}

- (NSURLSessionDataTask *)getSupplementsForProgram:(FITProgram)program
                                           success:(void (^)(Program *program))success
                                           failure:(void (^)(NSError *error))failure {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[CMSAPIManager sharedManager] getSupplementsForProgram:program
                                                           success:^(MTLProgram *program) {
                                                               
                                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                                   [SVProgressHUD dismiss];
                                                               });
                                                               [self saveMantleProgram:program
                                                                            completion:success];
                                                           }
                                                           failure:^(NSError *error) {
                                                               
                                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                                   [SVProgressHUD dismiss];
                                                               });
                                                               if(failure != nil){
                                                                   failure(error);
                                                               }
                                                               
                                                           }];
}

- (NSURLSessionDataTask *)getSupplementsForProgram:(FITProgram)program
                                              days:(FITDays)days
                                           success:(void (^)(Program *program))success
                                           failure:(void (^)(NSError *error))failure {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[CMSAPIManager sharedManager] getSupplementsForProgram:program
                                                              days:days
                                                           success:^(MTLProgram *program) {
                                                               
                                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                                   [SVProgressHUD dismiss];
                                                               });
                                                               
                                                           }
                                                           failure:^(NSError *error) {
                                                               
                                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                                   [SVProgressHUD dismiss];
                                                               });
                                                               
                                                           }];
}

- (void)saveMantleProgram:(MTLProgram *)mantleProgram
               completion:(void(^)(Program *program))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            RLMRealm *realm = [RLMRealm defaultRealm];
            
            ProgramFIT *program = [[ProgramFIT alloc] initWithMantleModel:mantleProgram];
            
            [realm beginWriteTransaction];
            
            [realm addOrUpdateObject:program];
            
            [realm commitWriteTransaction];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                if (completion != nil) {
                    RLMResults<ProgramFIT *> *program = [ProgramFIT allObjects];
                    completion(program);
                }
            });
        }
    });
}

- (NSURLSessionDataTask *)getExercise:(FITExercise)exercise
                              success:(void (^)(void))success
                              failure:(void (^)(NSError *error))failure {
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[CMSAPIManager sharedManager] getExercise:exercise
                                              success:^(MTLExercise *exercise) {
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [SVProgressHUD dismiss];
                                                  });
                                                  NSLog(@"%@", exercise);
                                              }
                                              failure:^(NSError *error) {
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [SVProgressHUD dismiss];
                                                  });
                                                  NSLog(@"%@", error);
                                              }];
}


- (NSURLSessionDataTask *) getFreeFoodWithSuccess:(void (^)(NSArray<FITFreeFood *> *awards))success
                                          failure:(void (^)(NSError *error))failure{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[CMSAPIManager sharedManager] getFreeFoodWithSuccess:^(NSArray<FITFreeFood *> *awards) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        DLog(@"%@", awards);
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        DLog(@"%@", error);
    }];
}

- (NSURLSessionDataTask *) getRecipesForProgram:(UserCourseType)courseType
                                        success:(void (^)(NSArray<FITRecipes *> *recipes))success
                                        failure:(void (^)(NSError *error))failure{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[CMSAPIManager sharedManager] getRecipesForProgram:courseType success:^(NSArray<FITRecipes *> *recipes) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }];
}

- (NSURLSessionDataTask *) getLocalesList{
    return [[CMSAPIManager sharedManager] getLocalesList];
}

- (NSURLSessionDataTask *)getIngredientsWithSuccess:(void (^)(NSArray<FLPIngredients *> *ingredients))success
                                            failure:(void (^)(NSError *error))failure{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    return [[CMSAPIManager sharedManager] getIngredientsWithSuccess:^(NSArray<FLPIngredients *> *ingredients) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        DLog(@"%@", ingredients);
    } failure:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        DLog(@"%@", error);
    }];
}

@end
