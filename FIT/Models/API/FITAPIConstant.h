//
//  FITAPIConstant.h
//  FIT
//
//  Created by Hamid Mehmood on 02/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#ifndef FITAPIConstant_h
#define FITAPIConstant_h


//#ifdef DEV // Dev Enviroment (Groundswell DEV)

//#define CMS_BASE_URL @"https://cms-production.cs21.force.com/fit/services/apexrest/fitapp/v1/"
//#define CMS_TOKEN @"AwO4coXUWGx%Q2aZzO&5!cR2R48ek*IFwS&U!^4zqCNG$Ij#2wuMEruweYfdZZBke&#Y9xG7HL2nfwgROSzdyLEan*3JnODc@hZc"
#define MT_BASE_URL @"http://forever-fit-dev.eu-west-1.elasticbeanstalk.com/"//https://fit.foreverlivingdev.com  //http://forever-fit-dev.eu-west-1.elasticbeanstalk.com
//#define MT_TOKEN @"6e1a424b-374c-48ac-b54a-9209b80f93a3"
//#define FBO_URL @"https://mobile-flp.cs11.force.com/partner/services/oauth2/authorize?client_id="
//#define FBO_CLIENT_SECRET @"5474656988269230252"
//#define FBO_CLIENT_ID @"3MVG9GiqKapCZBwFGARoucHMzFiuaUZPEH5roN4zUff8xXoGQWNfj41BHaO.bO6PNaJkXln6uilJWFHBU7knu"
//#define FBO_REDIRECT_URL @"http://localhost:8000/callback"
//#define FBO_LOAD_TOKEN_URL @"https://mobile-flp.cs11.force.com/partner/services/oauth2/token?"
//
//#endif
//
//#ifdef QA // QA Enviroment (Groundswell QA)

#define CMS_BASE_URL @"https://cmsqa-production.cs9.force.com/fit/services/apexrest/fitapp/v1/"
#define CMS_TOKEN @"LaOZ82pED!H8EQNgaywC#Iq4nNk5Qgk5h7o6EVYev%kGms93&5*#w%A9^Tdqfv5FdXrJN$6@lNM*t*%J6jojzO7E5OKEl*OlpQ$X"
//#define MT_BASE_URL @"https://fit.foreverlivingqa.com/"
#define MT_TOKEN @"6e1a424b-374c-48ac-b54a-9209b80f93a3"
#define FBO_URL @"https://dev-flp.cs20.force.com/partner/services/oauth2/authorize?client_id="
#define FBO_CLIENT_SECRET @"2209164775877210985"
#define FBO_CLIENT_ID @"3MVG9RHx1QGZ7OsgkU_ceZJiZlcqr07YUVEo7S2MFyvek8LmsbZ_OXIH2B4DfpwoiW1exgPV0jdDTzVXZTHkN"
#define FBO_REDIRECT_URL @"http://localhost:8000/callback"
#define FBO_LOAD_TOKEN_URL @"https://dev-flp.cs20.force.com/partner/services/oauth2/token?"

//#endif
//
//#ifdef PROD // Production Enviroment (Groundswell Production, Forever Prod SERVER)

//#define CMS_BASE_URL @"https://production.secure.force.com/fit/services/apexrest/fitapp/v1/"
//#define CMS_TOKEN @"YD5n0o%Ley9ms4t5QOj@Rtn%9z0@oxQ!tFTaREBQe%as7I^V2ejbX1QrCbmHcXuIdpCDSKxMLmdSgs0IkO@KNAX@MDZW^mthUz&r"
//#define MT_BASE_URL @"https://fit.foreverliving.com/"
//#define MT_TOKEN @"6e1a424b-374c-48ac-b54a-9209b80f93a3"
//#define FBO_URL @"https://flp.force.com/partner/services/oauth2/authorize?client_id="
//#define FBO_CLIENT_SECRET @"3374970584433708506"
//#define FBO_CLIENT_ID @"3MVG9rFJvQRVOvk60kCA4nSbSCJ0VzcWD2IsCRoSRaHIeMo8HY6VBE6GeXG6daGmPmeKsnSUSB.nHJr37w6cw"
//#define FBO_REDIRECT_URL @"http://localhost:8000/callback"
//#define FBO_LOAD_TOKEN_URL @"https://flp.force.com/partner/services/oauth2/token?"

//#endif


/* CMS AUTHENTICATION */


// Link to the API of Groundswell for the content for the app
// Content
#define CMS_CONTENT @"content/all"

// Suppliments
#define CMS_SUPPLIMENTS     @"supplements/"
#define CMS_SUPPLIMENTS_C9  @"fit-supplements-c9"
#define CMS_SUPPLIMENTS_F15 @"fit-supplements-f15"
#define CMS_SUPPLIMENTS_V5  @"fit-supplements-V5"
#define CMS_SUPPLIMENTS_ALL @"all"

// Freefood
#define CMS_FREEFOOD @"freefoods/all"

//Recipes
#define CMS_RECIPES                       @"recipes/"
#define CMS_RECIPES_C9                    @"C9"
#define CMS_RECIPES_F15_BEGINNER_1        @"f15-beginner-1"
#define CMS_RECIPES_F15_BEGINNER_2        @"f15-beginner-2"
#define CMS_RECIPES_F15_INTERMEDIATE_1    @"f15-intermediate-1"
#define CMS_RECIPES_F15_INTERMEDIATE_2    @"f15-intermediate-2"
#define CMS_RECIPES_F15_ADVANCED_1        @"f15-advanced-1"
#define CMS_RECIPES_F15_ADVANCED_2        @"f15-advanced-2"

// Exercises
#define CMS_EXERCISES @"exercises/"
#define CMS_EXERCISES_C9                        @"fit-exercises-c9"
#define CMS_EXERCISES_F15_BEGINNER_1            @"fit-exercises-f15-beginner-1"
#define CMS_EXERCISES_F15_BEGINNER_2            @"fit-exercises-f15-beginner-2"
#define CMS_EXERCISES_F15_INTERMEDIATE_1        @"fit-exercises-f15-intermediate-1"
#define CMS_EXERCISES_F15_INTERMEDIATE_2        @"fit-exercises-f15-intermediate-2"
#define CMS_EXERCISES_F15_ADVANCE_1             @"fit-exercises-f15-advanced-1"
#define CMS_EXERCISES_F15_ADVANCE_2             @"fit-exercises-f15-advanced-2"
#define CMS_EXERCISES_F15_WARM_UP_COOL_DOWN     @"fit-exercises-f15-warm-up-cool-down"
#define CMS_EXERCISES_ALL                       @"all"

// Adwards
#define CMS_AWARDS                          @"awards/all"
#define CMS_AWARDS_C9                       @"fit-awards-c9"
#define CMS_AWARDS_F15_BEGINNER             @"fit-awards-f15-beginner"
#define CMS_AWARDS_F15_INTERMEDIATE         @"fit-awards-f15-intermediate"
#define CMS_AWARDS_F15_ADVANCED             @"fit-awards-f15-advanced"
#define CMS_AWARDS_V5                       @"fit-awards-v5"
#define CMS_AWARDS_ALL                      @"all"

// Ingredients
#define CMS_INGREDIENTS @"ingredients/all"
#define CMS_INGREDIENTS_F15_BEGINNER             @"fit-ingredients-f15-beginner"
#define CMS_INGREDIENTS_F15_INTERMEDIATE         @"fit-ingredients-f15-intermediate"
#define CMS_INGREDIENTS_F15_ADVANCED             @"fit-ingredients-f15-advanced"
#define CMS_INGREDIENTS_ALL                      @"all"

// Notifications
#define CMS_NOTIFICATIONS @"notifications/"
#define CMS_NOTIFICATIONS_C9                         @"fit-msg-notifications-c9"
#define CMS_NOTIFICATIONS_F15_BEGINNER_1             @"fit-msg-notifications-f15-beginner-1"
#define CMS_NOTIFICATIONS_F15_BEGINNER_2             @"fit-msg-notifications-f15-beginner-2"
#define CMS_NOTIFICATIONS_F15_INTERMEDIATE_1         @"fit-msg-notifications-f15-intermediate-1"
#define CMS_NOTIFICATIONS_F15_INTERMEDIATE_2         @"fit-msg-notifications-f15-intermediate-2"
#define CMS_NOTIFICATIONS_F15_ADVANCED_1             @"fit-msg-notifications-f15-advanced-1"
#define CMS_NOTIFICATIONS_F15_ADVANCED_2             @"fit-msg-notifications-f15-advanced-2"
#define CMS_NOTIFICATIONS_V5                         @"fit-msg-notifications-v5"
#define CMS_NOTIFICATIONS_ALL                        @"all"

// Locales
#define CMS_LOCALES @"locales"


//Middle Tier API Mapping

/* MIDDLE TIER API LIST */

#define MT_AUTH_REGISTER             @"register"
#define MT_AUTH_UPDATEPROFILE        @"updateprofile"
#define MT_AUTH_CONFIRMLOGIN         @"confirmLogin"
#define MT_AUTH_CHECKEMAIL           @"checkEmail"
#define MT_AUTH_LOGIN                @"login"
#define MT_AUTH_RESET_PASSWORD       @"reset-password-request"

#define MT_SEND_MESSAGE              @"send-message"
#define MT_GET_MESSAGES              @"messages"
#define MT_GET_CONVERSTIONS          @"get-user-conversations"
#define MT_UPSERT_CONVERSATION       @"upsert-conversation"
#define MT_JOIN_PROGRAM              @"join-program"
#define MT_PROGRAM_UPSERT            @"program/upsert"
#define MT_DAY_ACTIVITIES_UPSERT     @"dayActivities/upsert"
#define MT_SETTINGS_UPSERT           @"settings/upsert"
#define MT_SETTINGS                  @"settings"
#define MT_RECIPIES_UPSERT           @"recipes/upsert" 
#define MT_RECIPIES                  @"recipes" //TODO
#define MT_USER_NOTIFICATIONS        @"user-notifications" //TODO
#define MT_UPDATE_NOTIFICATION       @"update-notification-status" //TODO
#define MT_PROGRAMS                  @"programs" //TODO

/* MT STATUS CODE */

#define MT_CODE_SUCCESS                 200

#define MT_CODE_AUTHFAIL                100
#define MT_CODE_UNKNOWNERROR            104
#define MT_CODE_NEWDEVICE               105
#define MT_CODE_MISSINGFIELD            106
#define MT_CODE_EMAIL_ALREADY_EXIST     107
#define MT_CODE_UNAUTHACCESS            401
#define MT_CODE_NOTFOUND                404
#define MT_CODE_ERROR_SEND_EMAIL        0


//All import class is going here
#import <AFNetworking/AFNetworking.h>
#import <Realm/Realm.h>

#import "FITProgram.h"
#import "FITDays.h"
#import "FITExercise.h"
#import "FITFreeFood.h"
#import "FITRecipes.h"
#import "Content.h"
#import "UserCourse.h"
#import "GenericCostant.h"
#import "MTLCourse.h"
#import "MTLConversation.h"
#import "MTLMessage.h"
#import "MTAPIManager_Error.h"
#import "FITExercise.h"
#import "User.h"
#import "ProgramFIT.h"
#import "FITAwards.h"


typedef enum : NSUInteger {
    CREATE = 0,
    UPDATE = 1
} UpsertAction;

typedef enum : NSUInteger {
    Facebook,
    FLP360,
    Email
} RegistrationMethod;


// PRograms Name

#define COURSE_PROGRAM_NAME_C9 @"C9"
#define COURSE_PROGRAM_NAME_F15BEGINNER1 @"F15 Beginner 1"
#define COURSE_PROGRAM_NAME_F15BEGINNER2 @"F15 Beginner 2"
#define COURSE_PROGRAM_NAME_F15INTERMEDIATE1 @"F15 Intermediate 1"
#define COURSE_PROGRAM_NAME_F15INTERMEDIATE2 @"F15 Intermediate 2"
#define COURSE_PROGRAM_NAME_F15ADVANCED1 @"F15 Advanced 1"
#define COURSE_PROGRAM_NAME_F15ADVANCED2 @"F15 Advanced 2"

#endif /* FITAPIConstant_h */

