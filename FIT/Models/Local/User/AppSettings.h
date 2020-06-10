//
//  AppSettings.h
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"

typedef enum : NSUInteger {
    UNSET = 0,
    OUNCE = 1,
    LITRE = 2
} FITVolumeType;

typedef enum : NSUInteger {
    NOTYPE = 0,
    INCHES = 1,
    METERS = 2
} FITLenghtType;

typedef enum : NSUInteger {
    NOVALUE = 0,
    GRAMS = 1,
    LIBRA = 2
} FITWeightType;

@interface AppSettings : BaseRealmData

@property NSNumber<RLMInt> * _Nullable id;
@property NSString * _Nullable timeZone;
@property NSString * _Nullable deviceToken;
@property NSNumber<RLMInt> * _Nullable wightType;
@property NSNumber<RLMInt> * _Nullable volumeType;
@property NSNumber<RLMInt> * _Nullable lenghtType;
@property BOOL autoTimezone;
@property BOOL pushActive;
@property BOOL isMetricSystem;

+ (AppSettings * _Nullable)getAppSettings;
- (void) updateAppSettings:(AppSettings *) appSettings;

@end
