//
//  CCMSAPIManager.h
//  FIT
//
//  Created by Hamid Mehmood on 02/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FITAPIConstant.h"
#import "CMSSessionManager.h"
#import "BaseRealmData.h"
#import "FLPIngredients.h"

@class Content, MTLProgram, MTLExercise;

@interface CMSAPIManager : CMSSessionManager

@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *language;

- (NSURLSessionDataTask *)getContentsWithSuccess:(void (^)(NSArray<Content *> *contents))success
                                         failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getSupplementsForProgram:(FITProgram)program
                                           success:(void (^)(MTLProgram *program))success
                                           failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getSupplementsForProgram:(FITProgram)program
                                              days:(FITDays)days
                                           success:(void (^)(MTLProgram *program))success
                                           failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getExercise:(FITExercise)exercise
                              success:(void (^)(MTLExercise *exercise))success
                              failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getAwardsWithSuccess:(void (^)(NSArray<FITAwards *> *awards))success
                                       failure:(void (^)(NSError *error))failure;


- (NSURLSessionDataTask *) getFreeFoodWithSuccess:(void (^)(NSArray<FITFreeFood *> *awards))success
                                          failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *) getRecipesForProgram:(UserCourseType)courseType
                                         success:(void (^)(NSArray<FITRecipes *> *recipes))success
                                        failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *)getIngredientsWithSuccess:(void (^)(NSArray<FLPIngredients *> *ingredients))success
                                            failure:(void (^)(NSError *error))failure;

- (NSURLSessionDataTask *) getLocalesList;

@end
