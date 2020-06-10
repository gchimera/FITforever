//
//  Utils.m
//  FIT
//
//  Created by Hamid Mehmood on 08/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "Utils.h"
#import <NSHash/NSString+NSHash.h>
#import <NSHash/NSData+NSHash.h>
#import "GenericCostant.h"
#import "AppSettings.h"
#import "CourseMealMap.h"
#import "CourseSettings.h"
#import "CustomRecipe.h"
#import "DayExercise.h"
#import "DayMeasurement.h"
#import "DayWaterIntake.h"
#import "Exercise.h"
#import "FITAwardCompleted.h"
#import "Meal.h"
#import "Measurement.h"
#import "ProgramFIT.h"
#import "Supplements.h"
#import "User.h"
#import "UserCourse.h"
#import "Water.h"
#import "SIAlertView.h"
#import "SVProgressHUD.h"
#import "FITAPIManager.h"
#import "FITWorkoutDetailsRLM.h"
#import "CourseDay.h"


static Utils * settingsInstance = nil;
NSMutableDictionary *paramsDict;
NSMutableArray *paramsArray;


@implementation Utils


+ (Utils *) sharedUtils{
    
    @synchronized(self){
        
        if (settingsInstance == nil){
            
            settingsInstance = [[Utils alloc] init];
            
        }
    }
    return settingsInstance;
}

#pragma -mark UUID or NSUUID
- (NSString*)UUIDString {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

- (BOOL) validateEmail:(NSString*)email
{
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", laxString];
    return [emailTest evaluateWithObject:email];
}

- (BOOL) validatePassword:(NSString*)password
{
    //    NSString *laxString = @"\\.+@(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}*";
    //    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", laxString];
    if([password length] >= 6)
        return true;
    else
        return false;
    //    return [passwordTest evaluateWithObject:password];
}

- (NSString *) generateSHA1WithString:(NSString *) string {
    return [string SHA1];
}

// get current date in MM/DD/YYYY

- (NSString*)getDateinDDMMYY
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd/MM/yyyy"];
    
    NSDate *now = [[NSDate alloc] init];
    
    NSString *dateString = [format stringFromDate:now];
    
    return dateString;
    
}

- (NSString*)getDateinMMDDYY
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    
    NSDate *now = [[NSDate alloc] init];
    
    NSString *dateString = [format stringFromDate:now];
    
    return dateString;
    
}

- (NSString*)getDate
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM/dd/yyyy"];
    
    NSDate *now = [[NSDate alloc] init];
    
    NSString *dateString = [format stringFromDate:now];
    
    return dateString;
    
}

// get current date in DD


- (NSString*)getDateinDay
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd"];
    
    NSDate *now = [[NSDate alloc] init];
    
    NSString *dateString = [format stringFromDate:now];
    
    return dateString;
}

- (NSString *)getUTCFormateDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // NSDate * date = [dateFormatter dateFromString:localDate];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}


- (NSString*)getDateinDDMMYYfromUTCDate:(NSString*)utcDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    
    NSDate *dateInLocalTimezone;
    
    
    
    NSDate *dateInUTC = [formatter dateFromString:utcDate];
    NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
    dateInLocalTimezone = [dateInUTC dateByAddingTimeInterval:timeZoneSeconds];
    
    [formatter setDateFormat:@"dd/MM/yyyy"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    NSString* returnDate = [formatter stringFromDate:dateInLocalTimezone];
    
    return returnDate;
    
    
}

- (NSString*)getDateinDDMMYYfromORIGINALUTCDate:(NSString*)utcDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    
    NSDate *dateInLocalTimezone;
    
    
    
    NSDate *dateInUTC = [formatter dateFromString:utcDate];
    NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
    dateInLocalTimezone = [dateInUTC dateByAddingTimeInterval:timeZoneSeconds];
    
    [formatter setDateFormat:@"dd/MM/yyyy"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    NSString* returnDate = [formatter stringFromDate:dateInLocalTimezone];
    
    return returnDate;
    
    
}

- (NSString*)getDateinUTCFromFormatDDMMYYWithDate:(NSString*)DateString
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    NSDate *dateInLocalTimezone;
    
    
    
    NSDate *dateInGMT = [formatter dateFromString:DateString];
    NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
    dateInLocalTimezone = [dateInGMT dateByAddingTimeInterval:timeZoneSeconds];
    
    
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    
    NSString* returnDate = [formatter stringFromDate:dateInLocalTimezone];
    
    return returnDate;
    
}


#pragma mark Colors

- (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""]; // remove the #
    NSScanner *scanner = [NSScanner scannerWithString:noHashString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]]; // remove + and $
    
    unsigned hex;
    if (![scanner scanHexInt:&hex]) return nil;
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

#pragma mark TOKEN VALIDATION
- (BOOL)doesTokenExists
{
    BOOL response;
    NSString* token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (token == nil || token == Nil || [token isEqualToString:@""])
    {
        response = NO;
    }else
    {
        response = YES;
    }
    
    return response;
}

- (void) removeAuthenticateToken
{
    NSLog(@"authentication token removed");
    return;
}
#pragma mark PERCENTAGE

- (void)convertToPercentage:(NSString *)progress withValue:(NSInteger)value
{
    
}

- (NSInteger)getCurrentDayWithStartDate:(NSDate*)startDate
{
    NSDate *now = [[NSDate alloc] init];
    
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:startDate];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:now];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    
    return [difference day] +1;
    
}

-(NSData *)dataFromBase64EncodedString:(NSString *)string {
    if (string.length > 0) {
        
        //the iPhone has base 64 decoding built in but not obviously. The trick is to
        //create a data url that's base 64 encoded and ask an NSData to load it.
        NSString *data64URLString = [NSString stringWithFormat:@"data:;base64,%@", string];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:data64URLString]];
        return data;
    }
    return nil;
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

- (BOOL) logoutAndCleanAllData {
    
    paramsArray = [[NSMutableArray alloc] init];
    paramsDict = [[NSMutableDictionary alloc] init];
    
    // here remove all data USer and all archived events
    dispatch_async(dispatch_queue_create("background", 0), ^{
        
        RLMResults *coursesList = [UserCourse allObjects];
        
        NSMutableArray *dayListData = [[NSMutableArray alloc] init];
        
        for (RLMObject *eachCourse in coursesList) {
            UserCourse *course = [[UserCourse alloc] init];
            if(eachCourse != nil)
                course = eachCourse;
            
            RLMResults *daysCourse = [CourseDay objectsWhere:[NSString stringWithFormat:@"programID == '%@'", course.userProgramId]];
            
            for(RLMObject *eachDay in daysCourse){
                CourseDay *day = [[CourseDay alloc] init];
                if(eachDay != nil)
                    day = eachDay;
                
                //here fill the json
                NSMutableDictionary *dayDictionary = [[NSMutableDictionary alloc] init];
                
                [dayDictionary setObject:day.day forKey:@"day_number"];
                [dayDictionary setObject:day.serverDayId != nil ? day.serverDayId : @"" forKey:@"day_id"];
                [dayDictionary setObject:day.day forKey:@"day"];
                [dayDictionary setObject:course.serverProgramId forKey:@"program_id"];
                
                // Measumrent
                NSMutableArray *measurementArray = [[NSMutableArray alloc] init];
                RLMResults *indexMeasurementDay = [Measurement objectsWhere:[NSString stringWithFormat:@"programID == '%@' AND day == '%@'",course.userProgramId  ,day.day]];
                if([indexMeasurementDay count] > 0) {
                    
                    
                    for (RLMObject *measurementDay in indexMeasurementDay) {
                        NSLog(@"%@",measurementDay);
                        [measurementArray addObjectsFromArray:@[
                                                                @{
                                                                    @"weight": [measurementDay valueForKey:@"weight"],
                                                                    @"chest": [measurementDay valueForKey:@"chest"],
                                                                    @"waist": [measurementDay valueForKey:@"waist"],
                                                                    @"arm": [measurementDay valueForKey:@"arm"],
                                                                    @"hip": [measurementDay valueForKey:@"hip"],
                                                                    @"thigh": [measurementDay valueForKey:@"thigh"],
                                                                    @"calf": [measurementDay valueForKey:@"calf"]
                                                                    }
                                                                ]];
                        
                        NSLog(@"Measurement Array = %@",measurementArray);
                    }
                    
                    [dayDictionary setObject:measurementArray forKey:@"measurement"]; //measurement objects
                }
                
                // Water
                RLMResults *indexWaterDay = [Water objectsWhere:[NSString stringWithFormat:@"programID == '%@' AND day == '%@'",course.userProgramId  ,day.day]];
                if([indexWaterDay count] > 0) {
                    
                    [dayDictionary setObject:[[indexWaterDay objectAtIndex:0] valueForKey:@"count"] forKey:@"water"];
                    
                }
                NSLog(@"Water Dictionary = %@",dayDictionary);
                
                
                
                
                // Meal
                NSMutableArray *mealsArray = [[NSMutableArray alloc] init];
                RLMResults *indexMealsDay = [Meal objectsWhere:[NSString stringWithFormat:@"programID == '%@' AND day == '%@' ",course.userProgramId  ,day.day]];
                if([indexMealsDay count] > 0) {
                    
                    for (RLMObject *mealDay in indexMealsDay) {
                        
                        [mealsArray addObjectsFromArray:@[
                                                          @{
                                                              @"meal_id": [mealDay valueForKey:@"serverMealId"] != nil ? [mealDay valueForKey:@"serverMealId"] : @"" ,
                                                              @"part_of_day": [mealDay valueForKey:@"partOfDay"],
                                                              @"id": [mealDay valueForKey:@"foodID"],
                                                              @"isCustom":[mealDay valueForKey:@"isCustomRecipe"]
                                                              
                                                              }
                                                          ]];
                        
                        NSLog(@"Supplements Array = %@",mealsArray);
                    }
                    
                    [dayDictionary setObject:mealsArray forKey:@"meal"]; //meal array
                    
                }
                
                // Supplemnent
                NSMutableArray *supplementsArray = [[NSMutableArray alloc] init];
                RLMResults *indexSupplementsDay = [Supplements objectsWhere:[NSString stringWithFormat:@"programID == '%@' AND day == '%@' AND isChecked == 1",course.userProgramId  ,day.day]];
                if([indexSupplementsDay count] > 0) {
                    
                    for (RLMObject *suppelementDay in indexSupplementsDay) {
                        //                        NSLog(@"%@",suppelementDay);
                        [supplementsArray addObjectsFromArray:@[
                                                                @{
                                                                    @"supplement_id": [suppelementDay valueForKey:@"cmsID"] != nil ? [suppelementDay valueForKey:@"cmsID"] : @"" ,
                                                                    @"part_of_day": [suppelementDay valueForKey:@"partOfDay"],
                                                                    @"cmsId": [suppelementDay valueForKey:@"supplementID"],
                                                                    
                                                                    }
                                                                ]];
                        
                        NSLog(@"Supplements Array = %@",supplementsArray);
                    }
                    
                    [dayDictionary setObject:supplementsArray forKey:@"supplements"]; //supplement array
                    
                }
                
                
                
                // Awards
                NSMutableArray *awardDict = [[NSMutableArray alloc] init];
                NSLog(@"%@",course.userProgramId);
                RLMResults *indexAward = [FITAwardCompleted objectsWhere:[NSString stringWithFormat:@"day == '%@'",day.day]];
                
                if([indexAward count] > 0) {
                    
                    //                    for (RLMObject *awardDay in indexAward) {
                    //
                    //                        [awardDict addObjectsFromArray:@[
                    //                                                         @{
                    //                                                             @"id": [awardDay valueForKey:@"awardCompleteId"] != nil ? [awardDay valueForKey:@"awardCompleteId"] : @"" ,
                    ////                                                             @"dateComplete": [awardDay valueForKey:@"dateAchieved"],
                    //
                    //                                                             }
                    //                                                         ]];
                    //
                    //                    }
                    
                    NSLog(@"Awards = %@",awardDict);
                    
                    [dayDictionary setObject:awardDict forKey:@"awards"]; //awards
                    
                }
                
                
                
                
                // Exercise
                NSMutableArray *exerciseDict = [[NSMutableArray alloc] init];
                RLMResults *exerciseDays = [Exercise objectsWhere:[NSString stringWithFormat:@"day == '%@' AND programID == '%@'",day.day, day.programID]];
                
                if([exerciseDays count] > 0) {
                    
                    NSString *exercisesValues = [NSString stringWithFormat:@"%d",[course.courseType integerValue]];
                    NSString *serverId = @"";
                    for (RLMObject *exerciseDay in exerciseDays) {
                        serverId = [exerciseDay valueForKey:@"serverExerciseId"] != nil ? [exerciseDay valueForKey:@"serverExerciseId"] : @"";
                        //                        if(exer
                        NSString *exerciseString = [exerciseDay valueForKey:@"exerciseName"];
                        if([exerciseString isEqualToString:@"thirtyMinutes"]){
                            exercisesValues = [NSString stringWithFormat:@"%@|C",exercisesValues];
                        } else if([exerciseString isEqualToString:@"twoMinutes"]) {
                            exercisesValues = [NSString stringWithFormat:@"%@|W",exercisesValues];
                        } else if([exerciseString isEqualToString:@"fiveMinutes"]) {
                            exercisesValues = [NSString stringWithFormat:@"%@|E",exercisesValues];
                        } else if([exerciseString isEqualToString:@"coolDown"]){
                            exercisesValues = [NSString stringWithFormat:@"%@|C",exercisesValues];
                        } else if([exerciseString isEqualToString:@"warmUp"]) {
                            exercisesValues = [NSString stringWithFormat:@"%@|W",exercisesValues];
                        } else if([exerciseString isEqualToString:@"workOut"]) {
                            exercisesValues = [NSString stringWithFormat:@"%@|E",exercisesValues];
                        }
                    }
                    if(![exercisesValues isEqualToString:@""]){
                        [exerciseDict addObjectsFromArray:@[
                                                            @{
                                                                @"exercise_id": serverId ,
                                                                @"exercise_cms_id": exercisesValues,
                                                                @"day_id": day.serverDayId != nil ? day.serverDayId : @"",
                                                                
                                                                
                                                                }
                                                            ]];
                    }
                    
                    //                    NSLog(@"Awards = %@",exerciseDict);
                    
                    [dayDictionary setObject:exerciseDict forKey:@"exercise"]; // esercise
                    
                }
                
                
                //add day to the arraylist
                [dayListData addObject:dayDictionary];
                
            }
            
            
        }
        
        
        NSLog(@"%@",paramsDict);
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        [parameters setObject:dayListData forKey:@"days"];
        
        
        [[FITAPIManager sharedManager] programDayUpsert:CREATE params:dayListData success:^(int *status) {
            
            
            RLMRealm *realm = [RLMRealm defaultRealm];
            
            
            RLMResults<CourseSettings *> *courseSettings = [CourseSettings allObjects];
            RLMResults<CustomRecipe *> *customRecipe = [CustomRecipe allObjects];
            RLMResults<DayExercise *> *dayExercise = [DayExercise allObjects];
            RLMResults<DayMeasurement *> *dayMeasurement = [DayMeasurement allObjects];
            RLMResults<DayWaterIntake *> *dayWaterIntake = [DayWaterIntake allObjects];
            RLMResults<Exercise *> *exercise = [Exercise allObjects];
            RLMResults<FITAwardCompleted *> *awardCompleted = [FITAwardCompleted allObjects];
            RLMResults<Meal *> *meal = [Meal allObjects];
            RLMResults<Measurement *> *measurement = [Measurement allObjects];
            RLMResults<Supplements *> *supplements = [Supplements allObjects];
            RLMResults<User *> *user = [User allObjects];
            RLMResults<UserCourse *> *userCourse = [UserCourse allObjects];
            RLMResults<Water *> *water = [Water allObjects];
            
            
            [realm beginWriteTransaction];
            
            [realm deleteObjects:courseSettings];
            [realm deleteObjects:customRecipe];
            [realm deleteObjects:dayExercise];
            [realm deleteObjects:dayMeasurement];
            [realm deleteObjects:dayWaterIntake];
            [realm deleteObjects:exercise];
            [realm deleteObjects:awardCompleted];
            [realm deleteObjects:meal];
            [realm deleteObjects:measurement];
            [realm deleteObjects:supplements];
            [realm deleteObjects:user];
            [realm deleteObjects:userCourse];
            [realm deleteObjects:water];
            [realm commitWriteTransaction];
            
            
        } failure:^(NSError *error) {
            [self showAlertViewWithMessage:@"Error Save on Server" buttonTitle:@"OK"];
            
            RLMRealm *realm = [RLMRealm defaultRealm];
            
            
            RLMResults<CourseSettings *> *courseSettings = [CourseSettings allObjects];
            RLMResults<CustomRecipe *> *customRecipe = [CustomRecipe allObjects];
            RLMResults<DayExercise *> *dayExercise = [DayExercise allObjects];
            RLMResults<DayMeasurement *> *dayMeasurement = [DayMeasurement allObjects];
            RLMResults<DayWaterIntake *> *dayWaterIntake = [DayWaterIntake allObjects];
            RLMResults<Exercise *> *exercise = [Exercise allObjects];
            RLMResults<FITAwardCompleted *> *awardCompleted = [FITAwardCompleted allObjects];
            RLMResults<Meal *> *meal = [Meal allObjects];
            RLMResults<Measurement *> *measurement = [Measurement allObjects];
            RLMResults<Supplements *> *supplements = [Supplements allObjects];
            RLMResults<User *> *user = [User allObjects];
            RLMResults<UserCourse *> *userCourse = [UserCourse allObjects];
            RLMResults<Water *> *water = [Water allObjects];
            
            
            [realm beginWriteTransaction];
            
            [realm deleteObjects:courseSettings];
            [realm deleteObjects:customRecipe];
            [realm deleteObjects:dayExercise];
            [realm deleteObjects:dayMeasurement];
            [realm deleteObjects:dayWaterIntake];
            [realm deleteObjects:exercise];
            [realm deleteObjects:awardCompleted];
            [realm deleteObjects:meal];
            [realm deleteObjects:measurement];
            [realm deleteObjects:supplements];
            [realm deleteObjects:user];
            [realm deleteObjects:userCourse];
            [realm deleteObjects:water];
            
            [realm commitWriteTransaction];
        }];
    });
    
    
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    
    RLMResults<CourseSettings *> *courseSettings = [CourseSettings allObjects];
    RLMResults<CustomRecipe *> *customRecipe = [CustomRecipe allObjects];
    RLMResults<DayExercise *> *dayExercise = [DayExercise allObjects];
    RLMResults<DayMeasurement *> *dayMeasurement = [DayMeasurement allObjects];
    RLMResults<DayWaterIntake *> *dayWaterIntake = [DayWaterIntake allObjects];
    RLMResults<Exercise *> *exercise = [Exercise allObjects];
    RLMResults<FITAwardCompleted *> *awardCompleted = [FITAwardCompleted allObjects];
    RLMResults<Meal *> *meal = [Meal allObjects];
    RLMResults<Measurement *> *measurement = [Measurement allObjects];
    RLMResults<Supplements *> *supplements = [Supplements allObjects];
    RLMResults<User *> *user = [User allObjects];
    RLMResults<UserCourse *> *userCourse = [UserCourse allObjects];
    RLMResults<Water *> *water = [Water allObjects];
    
    
    [realm beginWriteTransaction];
    
    [realm deleteObjects:courseSettings];
    [realm deleteObjects:customRecipe];
    [realm deleteObjects:dayExercise];
    [realm deleteObjects:dayMeasurement];
    [realm deleteObjects:dayWaterIntake];
    [realm deleteObjects:exercise];
    [realm deleteObjects:awardCompleted];
    [realm deleteObjects:meal];
    [realm deleteObjects:measurement];
    [realm deleteObjects:supplements];
    [realm deleteObjects:user];
    [realm deleteObjects:userCourse];
    [realm deleteObjects:water];
    [realm commitWriteTransaction];
    
    return true;
}

- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize {
    CGSize actSize = image.size;
    float scale = actSize.width/actSize.height;
    
    if (scale < 1) {
        newSize.height = newSize.width/scale;
    } else {
        newSize.width = newSize.height*scale;
    }
    
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (void) updateProgramStatus{
    dispatch_async(dispatch_queue_create("background", 0), ^{
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        
        RLMResults *programs =  [UserCourse allObjects];
        if ([programs count] > 0) {// here update all program status to STATUS COMPLETED once days pass
            for(int i = 0; i < [programs count]; i++){
                UserCourse *progUpdate = [[UserCourse alloc] init];
                progUpdate = [programs objectAtIndex:i];
                if([progUpdate.status integerValue] != STATUS_COMPLETED){
                    if([self getCurrentDayWithStartDate:progUpdate.startDate] > 9 && [progUpdate.courseType integerValue] == C9){
                        progUpdate.status = @(STATUS_COMPLETED);
                        [realm addOrUpdateObject:progUpdate];
                    } else if([self getCurrentDayWithStartDate:progUpdate.startDate] > 15){
                        progUpdate.status = @(STATUS_COMPLETED);
                        [realm addOrUpdateObject:progUpdate];
                    }
                }
            }
        }
        [realm commitWriteTransaction];
    });
}


-(void) showAlertViewWithMessage:(NSString *) message buttonTitle:(NSString *) buttonTitle{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Forever F.I.T." andMessage:message];
    
    [alertView addButtonWithTitle:buttonTitle
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alert) {
                              NSLog(@"Button1 Clicked");
                          }];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    
    [alertView show];
}


- (void) changeLanguageAndDownloadData {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        BOOL ok = // some result
        
        [[FITAPIManager sharedManager] getContentsWithSuccess:^(RLMResults<Content *> *contents) {} failure:^(NSError *error) {}];
        
        [[FITAPIManager sharedManager] getSupplementsForProgram:Forever15 success:^(Program *program) {} failure:^(NSError *error) {}];
        [[FITAPIManager sharedManager] getSupplementsForProgram:Clean9 success:^(Program *program) {} failure:^(NSError *error) {}];
        // do some long running processing here
        
        [[FITAPIManager sharedManager] getIngredientsWithSuccess:^(NSArray<FLPIngredients *> *ingredients) {} failure:^(NSError *error) {}];
        
        //Download Exercises
        [[FITAPIManager sharedManager] getExercise:C9Exercises success:^{} failure:^(NSError *error) {}];
        [[FITAPIManager sharedManager] getExercise:F15ExercisesBeginner1 success:^{} failure:^(NSError *error) {}];
        [[FITAPIManager sharedManager] getExercise:F15ExercisesBeginner2 success:^{} failure:^(NSError *error) {}];
        [[FITAPIManager sharedManager] getExercise:F15ExercisesIntermediate1 success:^{} failure:^(NSError *error) {}];
        [[FITAPIManager sharedManager] getExercise:F15ExercisesIntermediate2 success:^{} failure:^(NSError *error) {}];
        [[FITAPIManager sharedManager] getExercise:F15ExercisesAdvance1 success:^{} failure:^(NSError *error) {}];
        [[FITAPIManager sharedManager] getExercise:F15ExercisesAdvance2 success:^{} failure:^(NSError *error) {}];
        [[FITAPIManager sharedManager] getExercise:F15WarmUpCoolDown success:^{} failure:^(NSError *error) {}];
        
        //Download Recipes
        [[FITAPIManager sharedManager] getRecipesForProgram:C9 success:^(NSArray<FITRecipes *> *recipes) {} failure:^(NSError *error) {}];
        [[FITAPIManager sharedManager] getRecipesForProgram:F15Begginner1 success:^(NSArray<FITRecipes *> *recipes) {} failure:^(NSError *error) {}];
        [[FITAPIManager sharedManager] getRecipesForProgram:F15Begginner2 success:^(NSArray<FITRecipes *> *recipes) {} failure:^(NSError *error) {}];
        [[FITAPIManager sharedManager] getRecipesForProgram:F15Intermidiate1 success:^(NSArray<FITRecipes *> *recipes) {} failure:^(NSError *error) {}];
        [[FITAPIManager sharedManager] getRecipesForProgram:F15Intermidiate2 success:^(NSArray<FITRecipes *> *recipes) {} failure:^(NSError *error) {}];
        [[FITAPIManager sharedManager] getRecipesForProgram:F15Advance1 success:^(NSArray<FITRecipes *> *recipes) {} failure:^(NSError *error) {}];
        [[FITAPIManager sharedManager] getRecipesForProgram:F15Advance2 success:^(NSArray<FITRecipes *> *recipes) {} failure:^(NSError *error) {}];
        
        //Download Awards
        [[FITAPIManager sharedManager] getAwardsWithSuccess:^(NSArray<FITAwards *> *awards) {} failure:^(NSError *error) {}];
        //Donwload free food if neccesary
        [[FITAPIManager sharedManager] getFreeFoodWithSuccess:^(NSArray<FITFreeFood *> *awards){} failure:^(NSError *error) {}];
        
        
    });
}

@end
