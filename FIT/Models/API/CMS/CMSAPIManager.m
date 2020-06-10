//
//  CMSAPIManager.m
//  FIT
//
//  Created by Hamid Mehmood on 02/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "CMSAPIManager.h"
#import "CMSSessionManager.h"
#import "CMSSessionManager_Internal.h"
#import <Mantle/Mantle.h>
#import "Content.h"
#import "MTLProgram.h"
#import "FITFreeFood.h"
#import "MTLExercise.h"
#import "FITWorkoutDetailsRLM.h"
#import "FITExerciseDetailsRLM.h"
#import "Locales.h"
#import "LocaleSupportedLanguages.h"

//This class maps all the api method to MT or CMS groundswell

@implementation CMSAPIManager

- (NSDictionary *)baseParameters {
    User *userDB = [User userInDB];
    if(userDB != nil){
        return @{ @"country":userDB.country,@"lang":userDB.language};
    } else if(self.country != nil && self.language != nil){
        return @{ @"country":self.country,@"lang":self.language};
    } else {
        
        NSString *country = [[NSUserDefaults standardUserDefaults] stringForKey:@"country"];
        NSString *lang = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"language"];
        return @{ @"country":country,@"lang":lang};
    }
}

- (NSDictionary *)baseParametersWithGender {
    User *userDB = [User userInDB];
    NSString *gender = @"male";
    if(userDB != nil){
        if([userDB.gender isEqualToString:@"m"]){
            gender = @"male";
        } else {
            gender = @"female";
        }
        return @{ @"country":userDB.country,@"lang":userDB.language,@"gender": gender};
    } else if(self.country != nil && self.language != nil){
        return @{@"country":self.country, @"lang":self.language, @"gender":gender};
    } else {
        NSString *country = [[NSUserDefaults standardUserDefaults] stringForKey:@"country"];
        NSString *lang = [[NSUserDefaults standardUserDefaults]
                          stringForKey:@"language"];
        return @{ @"country":country,@"lang":lang, @"gender":@"male"}; //FIXME remove this not needed??
        
    }
    
}

- (NSURLSessionDataTask *)getContentsWithSuccess:(void (^)(NSArray<Content *> *contents))success
                                         failure:(void (^)(NSError *error))failure {
    return [self GET:CMS_CONTENT
          parameters:[self baseParameters]
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                 [self handleGetContentsResponse:responseObject
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

- (void)handleGetContentsResponse:(NSData *)responseObject
                          success:(void (^)(NSArray<Content *> *contents))success
                          failure:(void (^)(NSError *error))failure {
    NSError *error;
    NSDictionary *JSONDictionary = [self JSONFromResponseObject:responseObject
                                                          error:&error
                                                        context:@"getAwards"];
    
    if (JSONDictionary == nil || error) {
        if (failure != nil) {
            failure(error);
        }
        return;
    }
    
    NSMutableArray *contents = [[NSMutableArray alloc] init];
    NSDictionary *contentsDictionary = [JSONDictionary valueForKeyPath:@"data.children.items"];
    if (contentsDictionary != nil) {
        for (NSDictionary *contentDictionary in contentsDictionary) {
            for (NSString *contentKey in contentDictionary.allKeys) { // data.children.items/[keys]
                NSArray *contentComponents = [contentDictionary valueForKeyPath:[NSString stringWithFormat:@"%@.components", contentKey]]; // data.children.items/[keys]/components
                for (NSDictionary *contentComponentsDictionary in contentComponents) {
                    for (NSString *contentComponentKey in contentComponentsDictionary) { // data.children.items/[keys]/components/[keys]
                        NSString *contentComponentValue = contentComponentsDictionary[contentComponentKey];
                        
                        Content *content = [[Content alloc] initWithContentJSONDictionary:@{@"section":contentKey,
                                                                                            @"key":contentComponentKey,
                                                                                            @"value":contentComponentValue
                                                                                            }];
                        [contents addObject:content];
                    }
                }
            }
        }
        
        if (success != nil) {
            success(contents);
        }
    }
}


- (void)handleGetAwardsResponse:(NSData *)responseObject
                        success:(void (^)(NSArray<FITAwards *> *awards))success
                        failure:(void (^)(NSError *error))failure {
    NSError *error;
    NSDictionary *JSONDictionary = [self JSONFromResponseObject:responseObject
                                                          error:&error
                                                        context:@"getAwards"];
    
    if (JSONDictionary == nil || error) {
        if (failure != nil) {
            failure(error);
        }
        return;
    }
    
    NSMutableArray *awards = [[NSMutableArray alloc] init];
    NSDictionary *listAwardsDictionary = [JSONDictionary valueForKeyPath:@"data.children"];
    if (listAwardsDictionary != nil) {
        for (NSDictionary *awardsDictionary in listAwardsDictionary) {
            NSDictionary *itemsAwardsDictionary = [awardsDictionary valueForKeyPath:@"items"];
            if (itemsAwardsDictionary != nil) {
                for (NSString *contentKey in itemsAwardsDictionary.allKeys) { // data.children.items/[keys]
                    NSArray *awardsComponents = [itemsAwardsDictionary valueForKeyPath:[NSString stringWithFormat:@"%@", contentKey]];
                    for (NSDictionary *awardDictionary in awardsComponents) {
                        RLMRealm *realm = [RLMRealm defaultRealm];
                        [realm beginWriteTransaction];
                        
                        FITAwards *awardsRLM = [[FITAwards alloc] initWithAwardslistDictionary:awardDictionary];
                        
                        awardsRLM.programName = [awardsDictionary valueForKeyPath:@"name"];
                        [realm addOrUpdateObject:awardsRLM];
                        [realm commitWriteTransaction];
                    }
                }
            }
        }
        
        if (success != nil) {
            success(awards);
        }
    }
}

- (NSURLSessionDataTask *)getSupplementsForProgram:(FITProgram)program
                                           success:(void (^)(MTLProgram *program))success
                                           failure:(void (^)(NSError *error))failure {
    return [self GET:[CMS_SUPPLIMENTS stringByAppendingPathComponent:[self supplementPathForProgram:program]]
          parameters:[self baseParameters]
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                 [self handleGetSupplementsResponse:responseObject
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

- (NSURLSessionDataTask *)getSupplementsForProgram:(FITProgram)program
                                              days:(FITDays)days
                                           success:(void (^)(MTLProgram *program))success
                                           failure:(void (^)(NSError *error))failure {
    return [self GET:[CMS_SUPPLIMENTS stringByAppendingPathComponent:[self supplementPathForProgram:program]]
          parameters:[self baseParameters]
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                 //                 [self handleGetContentsResponse:responseObject
                 //                                         success:success
                 //                                         failure:failure];
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 DLog(@"Error: %@", error);
                 if (failure != nil) {
                     failure(error);
                 }
             }];
}

- (NSString *)supplementPathForProgram:(FITProgram)program {
    switch (program) {
        case Clean9 : return CMS_SUPPLIMENTS_C9;
        case Forever15: return CMS_SUPPLIMENTS_F15;
        case Vital5: return CMS_SUPPLIMENTS_V5;
    }
}

- (void)handleGetSupplementsResponse:(NSData *)responseObject
                             success:(void (^)(MTLProgram *program))success
                             failure:(void (^)(NSError *error))failure {
    NSError *error;
    NSDictionary *JSONDictionary = [self JSONFromResponseObject:responseObject
                                                          error:&error
                                                        context:@"getSupplements"];
    
    if (JSONDictionary == nil || error) {
        if (failure != nil) {
            failure(error);
        }
        return;
    }
    
    MTLProgram *program = [MTLJSONAdapter modelOfClass:MTLProgram.class
                                    fromJSONDictionary:JSONDictionary
                                                 error:&error];
    
    if (program != nil && success != nil) {
        success(program);
    } else if (failure != nil) {
        failure(error);
    }
}

- (NSURLSessionDataTask *)getAwardsWithSuccess:(void (^)(NSArray<FITAwards *> *awards))success
                                       failure:(void (^)(NSError *error))failure{
    return [self GET:CMS_AWARDS
          parameters:[self baseParameters]
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                 [self handleGetAwardsResponse:responseObject
                                       success:success
                                       failure:failure];
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 DLog(@"getContents error: %@", error);
             }];
}

- (NSURLSessionDataTask *)getExercise:(FITExercise)exercise
                              success:(void (^)(MTLExercise *exercise))success
                              failure:(void (^)(NSError *error))failure {
    switch (exercise) {
        case F15ExercisesBeginner1:
            return [self GET:[CMS_EXERCISES stringByAppendingPathComponent:CMS_EXERCISES_F15_BEGINNER_1]
                  parameters:[self baseParameters]
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         [self handleGetExerciseResponse:responseObject
                                                 success:success
                                                 failure:failure];
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         DLog(@"Error: %@", error);
                         if (failure != nil) {
                             failure(error);
                         }
                     }];
            break;
        case F15ExercisesBeginner2:
            return [self GET:[CMS_EXERCISES stringByAppendingPathComponent:CMS_EXERCISES_F15_BEGINNER_2]
                  parameters:[self baseParameters]
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         [self handleGetExerciseResponse:responseObject
                                                 success:success
                                                 failure:failure];
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         DLog(@"Error: %@", error);
                         if (failure != nil) {
                             failure(error);
                         }
                     }];
            break;
        case F15ExercisesIntermediate1:
            return [self GET:[CMS_EXERCISES stringByAppendingPathComponent:CMS_EXERCISES_F15_INTERMEDIATE_1]
                  parameters:[self baseParameters]
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         [self handleGetExerciseResponse:responseObject
                                                 success:success
                                                 failure:failure];
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         DLog(@"Error: %@", error);
                         if (failure != nil) {
                             failure(error);
                         }
                     }];
            break;
        case F15ExercisesIntermediate2:
            return [self GET:[CMS_EXERCISES stringByAppendingPathComponent:CMS_EXERCISES_F15_INTERMEDIATE_2]
                  parameters:[self baseParameters]
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         [self handleGetExerciseResponse:responseObject
                                                 success:success
                                                 failure:failure];
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         DLog(@"Error: %@", error);
                         if (failure != nil) {
                             failure(error);
                         }
                     }];
            break;
        case F15ExercisesAdvance1:
            return [self GET:[CMS_EXERCISES stringByAppendingPathComponent:CMS_EXERCISES_F15_ADVANCE_1]
                  parameters:[self baseParameters]
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         [self handleGetExerciseResponse:responseObject
                                                 success:success
                                                 failure:failure];
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         DLog(@"Error: %@", error);
                         if (failure != nil) {
                             failure(error);
                         }
                     }];
            break;
        case F15ExercisesAdvance2:
            return [self GET:[CMS_EXERCISES stringByAppendingPathComponent:CMS_EXERCISES_F15_ADVANCE_2]
                  parameters:[self baseParameters]
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         [self handleGetExerciseResponse:responseObject
                                                 success:success
                                                 failure:failure];
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         DLog(@"Error: %@", error);
                         if (failure != nil) {
                             failure(error);
                         }
                     }];
            break;
        case F15WarmUpCoolDown:
            return [self GET:[CMS_EXERCISES stringByAppendingPathComponent:CMS_EXERCISES_F15_WARM_UP_COOL_DOWN]
                  parameters:[self baseParameters]
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         [self handleGetExerciseResponse:responseObject
                                                 success:success
                                                 failure:failure];
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         DLog(@"Error: %@", error);
                         if (failure != nil) {
                             failure(error);
                         }
                     }];
            break;
            
    }
    return [self GET:[CMS_EXERCISES stringByAppendingPathComponent:CMS_EXERCISES_ALL]
          parameters:[self baseParameters]
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                 [self handleGetExerciseResponse:responseObject
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

- (void)handleGetExerciseResponse:(NSData *)responseObject
                          success:(void (^)(MTLExercise *exercise))success
                          failure:(void (^)(NSError *error))failure {
    NSError *error;
    NSDictionary *JSONDictionary = [self JSONFromResponseObject:responseObject
                                                          error:&error
                                                        context:@"getExercise"];
    
    if (JSONDictionary == nil || error) {
        if (failure != nil) {
            failure(error);
        }
        return;
    }
    
    [self processExercisesData:JSONDictionary];
    
    MTLExercise *exercise = [MTLJSONAdapter modelOfClass:MTLExercise.class
                                      fromJSONDictionary:JSONDictionary
                                                   error:&error];
    
    if (exercise != nil && success != nil) {
        success(exercise);
    } else if (failure != nil) {
        failure(error);
    }
}
- (void) processExercisesData:(NSDictionary *)jsonResponse
{
    //Shake - Lunch - Dinner  ...
    NSArray *allCategories = [[jsonResponse valueForKey:@"data"] objectForKey:@"children"];
    // Count All Recipes Categories
    
    long countAllExercisesCategories = [allCategories count];
    DLog(@"Count All Categories:%ld",countAllExercisesCategories);
    for (int i = 0; i < countAllExercisesCategories; i++)
    {
        NSDictionary *exerciseCategory = [allCategories objectAtIndex:i];
        //            DLog(@"DICT :::::: %@",dict);
        [self processEachExercisesCategory:exerciseCategory];
    }
    
    
}


-(void)processEachExercisesCategory:(NSDictionary *)categoryDictionary {
    
    long eachProgramExercise = [[categoryDictionary objectForKey:@"children"] count];
    for (int i = 0; i < eachProgramExercise; i++) {
        
        NSDictionary *programWorkoutDetails = [[[[[categoryDictionary objectForKey:@"children"] objectAtIndex:i] valueForKey:@"items"] valueForKey:@"fitapp-workout-details"] firstObject];
        NSString *systemName = [[[categoryDictionary objectForKey:@"children"] objectAtIndex:i] valueForKey:@"systemName"];
        NSString *sectionName = [[[categoryDictionary objectForKey:@"children"] objectAtIndex:i] valueForKey:@"name"];
        DLog(@"Dictionary To Save %@",programWorkoutDetails);
        [self insertWorkoutDetailsDataIntoRealmDB:programWorkoutDetails systemName:systemName sectionName:sectionName];
        
    }
    
    
    for (int i = 0; i < eachProgramExercise; i++) {
        
        long countExerciseDetails = [[[[[categoryDictionary objectForKey:@"children"] objectAtIndex:i] valueForKey:@"items"] valueForKey:@"fitapp-exercise-details"] count];
        
        for (int d = 0; d < countExerciseDetails; d++) {
            
            NSDictionary *programExerciseDetails = [[[[[categoryDictionary objectForKey:@"children"] objectAtIndex:i] valueForKey:@"items"] valueForKey:@"fitapp-exercise-details"] objectAtIndex:d];
            NSString *systemName = [[[categoryDictionary objectForKey:@"children"] objectAtIndex:i] valueForKey:@"systemName"];
            NSString *sectionName = [[[categoryDictionary objectForKey:@"children"] objectAtIndex:i] valueForKey:@"name"];
            DLog(@"Dictionary To Save %@",programExerciseDetails);
            [self insertExerciseDetailsDataIntoRealmDB:programExerciseDetails systemName:systemName sectionName:sectionName];
            
        }
        
        
    }
}

- (void) insertWorkoutDetailsDataIntoRealmDB:(NSDictionary *)programWorkoutDetails systemName:(NSString *)systemName sectionName:(NSString *)sectionName{
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    FITWorkoutDetailsRLM *workoutRLM = [[FITWorkoutDetailsRLM alloc] initWithDictionary:programWorkoutDetails systemName:systemName sectionName:sectionName];
    [realm addOrUpdateObject:workoutRLM];
    [realm commitWriteTransaction];
    
}


- (void) insertExerciseDetailsDataIntoRealmDB:(NSDictionary *)programExerciseDetails systemName:(NSString *)systemName sectionName:(NSString *)sectionName{
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    FITExerciseDetailsRLM *exerciseRLM = [[FITExerciseDetailsRLM alloc] initWithDictionary:programExerciseDetails systemName:systemName sectionName:sectionName];
    [realm addOrUpdateObject:exerciseRLM];
    [realm commitWriteTransaction];
    
}


- (NSURLSessionDataTask *) getFreeFoodWithSuccess:(void (^)(NSArray<FITFreeFood *> *awards))success
                                          failure:(void (^)(NSError *error))failure {
    
    return [self GET:CMS_FREEFOOD
          parameters:[self baseParameters]
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                 
                 [self handleFreeFoodsResponse:responseObject
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


- (void)handleFreeFoodsResponse:(NSData *)responseObject
                        success:(void (^)(NSArray<FITFreeFood *> *awards))success
                        failure:(void (^)(NSError *error))failure {
    NSError *error;
    NSDictionary *JSONDictionary = [self JSONFromResponseObject:responseObject
                                                          error:&error
                                                        context:@"getFreeFoods"];
    
    if (JSONDictionary == nil || error) {
        if (failure != nil) {
            failure(error);
        }
        return;
    }
    
    NSMutableArray *contents = [[NSMutableArray alloc] init];
    NSDictionary *contentsDictionary = [JSONDictionary valueForKeyPath:@"data.children.items"];
    if (contentsDictionary != nil) {
        for (NSDictionary *contentDictionary in contentsDictionary) {
            for (NSString *contentKey in contentDictionary.allKeys) { // data.children.items/[keys]
                NSArray *contentComponents = [contentDictionary valueForKeyPath:[NSString stringWithFormat:@"%@", contentKey]]; // data.children.items/[keys]/components
                for (NSDictionary *contentComponentsDictionary in contentComponents) {
                    
                    RLMRealm *realm = [RLMRealm defaultRealm];
                    [realm beginWriteTransaction];
                    
                    FITFreeFood *freeFood = [[FITFreeFood alloc] init];
                    
                    freeFood.name = [contentComponentsDictionary valueForKeyPath:@"components.food-name"];
                    if([contentComponentsDictionary valueForKeyPath:@"components.serving-size"] != nil){
                        freeFood.size = [contentComponentsDictionary valueForKeyPath:@"components.serving-size"];
                    } else {
                        freeFood.size = @"";
                    }
                    freeFood.type = [contentComponentsDictionary valueForKeyPath:@"type"];
                    freeFood.freeFoodId = [contentComponentsDictionary valueForKeyPath:@"id"];
                    
                    
                    [realm addOrUpdateObject:freeFood];
                    [realm commitWriteTransaction];
                    
                }
            }
        }
        
        if (success != nil) {
            success(contents);
        }
    }
}

- (NSURLSessionDataTask *) getRecipesForProgram:(UserCourseType)courseType
                                        success:(void (^)(NSArray<FITRecipes *> *recipes))success
                                        failure:(void (^)(NSError *error))failure {
    switch (courseType) {
        case C9:
            return [self GET:[CMS_RECIPES stringByAppendingPathComponent:CMS_RECIPES_C9]
                  parameters:[self baseParametersWithGender]
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         
                         [self handleRecipesResponse:responseObject
                                  withUserCourseType:courseType
                                             success:success
                                             failure:failure];
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         DLog(@"Error: %@", error);
                         if (failure != nil) {
                             failure(error);
                         }
                     }];
            break;
        case F15Begginner1:
            return [self GET:[CMS_RECIPES stringByAppendingPathComponent:CMS_RECIPES_F15_BEGINNER_1]
                  parameters:[self baseParametersWithGender]
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         
                         [self handleRecipesResponse:responseObject
                                  withUserCourseType:courseType
                                             success:success
                                             failure:failure];
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         DLog(@"Error: %@", error);
                         if (failure != nil) {
                             failure(error);
                         }
                     }];
            break;
        case F15Begginner2:
            return [self GET:[CMS_RECIPES stringByAppendingPathComponent:CMS_RECIPES_F15_BEGINNER_2]
                  parameters:[self baseParametersWithGender]
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         
                         [self handleRecipesResponse:responseObject
                                  withUserCourseType:courseType
                                             success:success
                                             failure:failure];
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         DLog(@"Error: %@", error);
                         if (failure != nil) {
                             failure(error);
                         }
                     }];
            break;
        case F15Intermidiate1:
            return [self GET:[CMS_RECIPES stringByAppendingPathComponent:CMS_RECIPES_F15_INTERMEDIATE_1]
                  parameters:[self baseParametersWithGender]
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         
                         [self handleRecipesResponse:responseObject
                                  withUserCourseType:courseType
                                             success:success
                                             failure:failure];
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         DLog(@"Error: %@", error);
                         if (failure != nil) {
                             failure(error);
                         }
                     }];
            break;
        case F15Intermidiate2:
            return [self GET:[CMS_RECIPES stringByAppendingPathComponent:CMS_RECIPES_F15_INTERMEDIATE_2]
                  parameters:[self baseParametersWithGender]
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         
                         [self handleRecipesResponse:responseObject
                                  withUserCourseType:courseType
                                             success:success
                                             failure:failure];
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         DLog(@"Error: %@", error);
                         if (failure != nil) {
                             failure(error);
                         }
                     }];
            break;
        case F15Advance1:
            return [self GET:[CMS_RECIPES stringByAppendingPathComponent:CMS_RECIPES_F15_ADVANCED_1]
                  parameters:[self baseParametersWithGender]
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         
                         [self handleRecipesResponse:responseObject
                                  withUserCourseType:courseType
                                             success:success
                                             failure:failure];
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         DLog(@"Error: %@", error);
                         if (failure != nil) {
                             failure(error);
                         }
                     }];
            break;
        case F15Advance2:
            return [self GET:[CMS_RECIPES stringByAppendingPathComponent:CMS_RECIPES_F15_ADVANCED_2]
                  parameters:[self baseParametersWithGender]
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                         
                         [self handleRecipesResponse:responseObject
                                  withUserCourseType:courseType
                                             success:success
                                             failure:failure];
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         DLog(@"Error: %@", error);
                         if (failure != nil) {
                             failure(error);
                         }
                     }];
            break;
    }
    return nil;
}

- (void)handleRecipesResponse:(NSData *)responseObject
           withUserCourseType:(UserCourseType) courseType
                      success:(void (^)(NSArray<FITRecipes *> *awards))success
                      failure:(void (^)(NSError *error))failure {
    NSError *error;
    NSDictionary *JSONDictionary = [self JSONFromResponseObject:responseObject
                                                          error:&error
                                                        context:@"getRecipes"];
    
    if (JSONDictionary == nil || error) {
        if (failure != nil) {
            failure(error);
        }
        return;
    }
    
    NSMutableArray *contents = [[NSMutableArray alloc] init];
    NSDictionary *contentsDictionary = [JSONDictionary valueForKeyPath:@"data.children.items"];
    if (contentsDictionary != nil) {
        for (NSDictionary *contentDictionary in contentsDictionary) {
            for (NSString *contentKey in contentDictionary.allKeys) { // data.children.items/[keys]
                NSArray *contentComponents = [contentDictionary valueForKeyPath:[NSString stringWithFormat:@"%@", contentKey]]; // data.children.items/[keys]/components
                for (NSDictionary *contentComponentsDictionary in contentComponents) {
                    
                    RLMRealm *realm = [RLMRealm defaultRealm];
                    [realm beginWriteTransaction];
                    
                    FITRecipes *recipe = [[FITRecipes alloc] init];
                    int courseInt = 0;
                    switch (courseType) {
                        case C9:
                            recipe.programF15Beginner1 = NO;
                            recipe.programF15Beginner2 = NO;
                            recipe.programF15Intermediate1 = NO;
                            recipe.programF15Intermediate2 = NO;
                            recipe.programF15Advanced1 = NO;
                            recipe.programF15Advanced2 = NO;
                            courseInt = 0;
                            break;
                        case F15Begginner1:
                            recipe.programF15Beginner1 = YES;
                            recipe.programF15Beginner2 = NO;
                            recipe.programF15Intermediate1 = NO;
                            recipe.programF15Intermediate2 = NO;
                            recipe.programF15Advanced1 = NO;
                            recipe.programF15Advanced2 = NO;
                            courseInt = 2;
                            break;
                        case F15Begginner2:
                            recipe.programF15Beginner1 = NO;
                            recipe.programF15Beginner2 = YES;
                            recipe.programF15Intermediate1 = NO;
                            recipe.programF15Intermediate2 = NO;
                            recipe.programF15Advanced1 = NO;
                            recipe.programF15Advanced2 = NO;
                            courseInt = 3;
                            break;
                        case F15Intermidiate1:
                            recipe.programF15Beginner1 = NO;
                            recipe.programF15Beginner2 = NO;
                            recipe.programF15Intermediate1 = YES;
                            recipe.programF15Intermediate2 = NO;
                            recipe.programF15Advanced1 = NO;
                            recipe.programF15Advanced2 = NO;
                            courseInt = 5;
                            break;
                        case F15Intermidiate2:
                            recipe.programF15Beginner1 = NO;
                            recipe.programF15Beginner2 = NO;
                            recipe.programF15Intermediate1 = NO;
                            recipe.programF15Intermediate2 = YES;
                            recipe.programF15Advanced1 = NO;
                            recipe.programF15Advanced2 = NO;
                            courseInt = 6;
                            break;
                        case F15Advance1:
                            recipe.programF15Beginner1 = NO;
                            recipe.programF15Beginner2 = NO;
                            recipe.programF15Intermediate1 = NO;
                            recipe.programF15Intermediate2 = NO;
                            recipe.programF15Advanced1 = YES;
                            recipe.programF15Advanced2 = NO;
                            courseInt = 8;
                            break;
                        case F15Advance2:
                            recipe.programF15Beginner1 = NO;
                            recipe.programF15Beginner2 = NO;
                            recipe.programF15Intermediate1 = NO;
                            recipe.programF15Intermediate2 = NO;
                            recipe.programF15Advanced1 = NO;
                            recipe.programF15Advanced2 = YES;
                            courseInt = 9;
                            break;
                    }
                    
                    recipe.recipePrimaryKey = [NSString stringWithFormat:@"%@_%d",[contentComponentsDictionary valueForKeyPath:@"id"],courseInt];
                    
                    recipe.recipeId = [contentComponentsDictionary valueForKeyPath:@"id"];
                    recipe.type = [contentComponentsDictionary valueForKeyPath:@"type"];
                    recipe.title = [contentComponentsDictionary valueForKeyPath:@"title"];
                    recipe.sequence = [NSString stringWithFormat: @"%ld", (long)[contentComponentsDictionary valueForKeyPath:@"sequence"]];
                    recipe.name = [contentComponentsDictionary valueForKeyPath:@"name"];
                    recipe.language = [contentComponentsDictionary valueForKeyPath:@"language"];
                    recipe.country = [contentComponentsDictionary valueForKeyPath:@"country"];
                    recipe.image = [contentComponentsDictionary valueForKeyPath:@"components.image"];
                    recipe.thumbnailImage = [contentComponentsDictionary valueForKeyPath:@"components.thumbnail-image"];
                    recipe.shakeVideo = [contentComponentsDictionary valueForKeyPath:@"components.shake-video"];
                    recipe.ingredients = [contentComponentsDictionary valueForKeyPath:@"components.ingredients"];
                    recipe.estimatedCalories = [contentComponentsDictionary valueForKeyPath:@"components.estimated-calories"];
                    recipe.desc = [contentComponentsDictionary valueForKeyPath:@"components.description"];
                    recipe.recipeName = [contentComponentsDictionary valueForKeyPath:@"components.recipe-name"];
                    
                    [realm addOrUpdateObject:recipe];
                    [realm commitWriteTransaction];
                    
                }
            }
        }
        
        if (success != nil) {
            success(contents);
        }
    }
}

- (NSURLSessionDataTask *) getLocalesList {
    return [self GET:CMS_LOCALES
          parameters:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                 NSError *error;
                 NSDictionary *JSONDictionary = [self JSONFromResponseObject:responseObject
                                                                       error:&error
                                                                     context:@"getLocalesList"];
                 
                 NSDictionary *contentsDictionary = [JSONDictionary valueForKeyPath:@"locales"];
                 if (contentsDictionary != nil) {
                     for (NSDictionary *contentDictionary in contentsDictionary) {
                         //TODO
                         NSString *localeid = [NSString stringWithFormat:@"%@_%@",[contentDictionary valueForKeyPath:@"country"],[contentDictionary valueForKeyPath:@"defaultLanguage"]];
                         
                         RLMRealm *realm = [RLMRealm defaultRealm];
                         [realm beginWriteTransaction];
                         Locales *locale = [[Locales alloc] init];
                         
                         locale.defaultLanguage = [contentDictionary valueForKeyPath:@"defaultLanguage"];
                         locale.countryLabel = [contentDictionary valueForKeyPath:@"countryLabel"];
                         locale.country = [contentDictionary valueForKeyPath:@"country"];
                         locale.localeId = localeid;
                         
                         RLMArray<LocaleSupportedLanguages *><LocaleSupportedLanguages> *supportedLanguagesArray ;
                         NSDictionary *supportedLanguages = [contentDictionary valueForKeyPath:@"supportedLanguages"];
                         if (supportedLanguages != nil) {
                             for (NSString *contentKey in supportedLanguages.allKeys) {
                                 NSString *supportedLanguageId = [NSString stringWithFormat:@"%@_%@",localeid,contentKey];
                                 NSString *languageDescription = supportedLanguages[contentKey];
                                 LocaleSupportedLanguages *supportedLanguage = [[LocaleSupportedLanguages alloc] init];
                                 supportedLanguage.supportedLanguageId = supportedLanguageId;
                                 supportedLanguage.languageCode = contentKey;
                                 supportedLanguage.languageDescription = languageDescription;
                                 [realm addOrUpdateObject:supportedLanguage];
                                 [locale.supportedLanguages  addObject:supportedLanguage];
                                 
                             }
                         }
                         
                         [realm addOrUpdateObject:locale];
                         [realm commitWriteTransaction];
                     }
                 }
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 DLog(@"getContents error: %@", error);
             }];
}

- (NSURLSessionDataTask *)getIngredientsWithSuccess:(void (^)(NSArray<FLPIngredients *> *ingredients))success
                                            failure:(void (^)(NSError *error))failure {
    return [self GET:CMS_INGREDIENTS
          parameters:[self baseParametersWithGender]
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                 NSError *error;
                 NSDictionary *JSONDictionary = [self JSONFromResponseObject:responseObject
                                                                       error:&error
                                                                     context:@"getIngredientsWithProgram"];
                 
                 if (JSONDictionary == nil || error) {
                     if (failure != nil) {
                         failure(error);
                     }
                     return;
                 }
                 
                 NSMutableArray *ingredients = [[NSMutableArray alloc] init];
                 NSDictionary *ingredientsDictionary = [JSONDictionary valueForKeyPath:@"data.children"];
                 if (ingredientsDictionary != nil) {
                     for (NSDictionary *ingredientDictionary in ingredientsDictionary) {
                         
                         NSArray *ingredientDic = [ingredientDictionary valueForKeyPath:@"children"];
                         if (ingredientDic != nil) {
                             for (NSDictionary *ingreDictionary in ingredientDic) {
                                 
                                 NSArray *ingredientComponents = [ingreDictionary valueForKeyPath:@"children"];
                                 if (ingredientComponents != nil) {
                                     for (NSDictionary *ingredientComponentsDictionary in ingredientComponents) {
                                         
                                         NSArray *childrenDictionary = [ingredientComponentsDictionary valueForKeyPath:@"items"];
                                         if (childrenDictionary != nil) {
                                             
                                             NSMutableArray *ingredient = [[NSMutableArray alloc] init];
                                             NSArray *fitIngredient = [childrenDictionary valueForKeyPath:@"fitapp-ingredient"];
                                             NSArray *fitIngredientAdvance = [childrenDictionary valueForKeyPath:@"fitapp-ingredient-advanced"];
                                             if(fitIngredient != nil)
                                                 ingredient = fitIngredient;
                                             else if (fitIngredientAdvance != nil)
                                                 ingredient = fitIngredientAdvance;
                                             for (NSDictionary *ingredientComponentKey in ingredient) {
                                                 
                                                 
                                                 RLMRealm *realm = [RLMRealm defaultRealm];
                                                 [realm beginWriteTransaction];
                                                 FLPIngredients *ingredient = [[FLPIngredients alloc] init];
                                                 ingredient.group = [ingreDictionary valueForKeyPath:@"systemName"];
                                                 
                                                 ingredient.type = [ingredientComponentsDictionary valueForKeyPath:@"parentName"];
                                                 ingredient.title = [ingredientComponentKey valueForKeyPath:@"title"];
                                                 ingredient.foreverId = [ingredientComponentKey valueForKeyPath:@"id"];
                                                 ingredient.servingSize = [ingredientComponentKey valueForKeyPath:@"components.serving-size"];
                                                 ingredient.calories = [ingredientComponentKey valueForKeyPath:@"components.estimated-calories"];
                                                 ingredient.ingredientType = [ingredientComponentKey valueForKeyPath:@"type"];
                                                 
                                                 [realm addOrUpdateObject:ingredient];
                                                 [realm commitWriteTransaction];
                                             }
                                             
                                         }
                                     }
                                 }
                             }
                         }
                     }
                 }
                 
                 if (success != nil) {
                     success(ingredients);
                 }
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 if (failure != nil) {
                     failure(error);
                 }
                 DLog(@"getContents error: %@", error);
             }];
}

@end
