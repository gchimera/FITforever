//
//  Utils.h
//  FIT
//
//  Created by Hamid Mehmood on 08/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+ (Utils *) sharedUtils;

- (BOOL) validateEmail:(NSString*)email;
- (BOOL) validatePassword:(NSString*)password;

- (NSString *) generateSHA1WithString:(NSString *) string;


// get current date in  MM/DD/YYYY
-(NSString*)getDateinMMDDYY;

-(NSString*)getDateinDDMMYY;
-(NSString *)getUTCFormateDate;
-(NSString*)getDateinDDMMYYfromUTCDate:(NSString*)utcDate;

-(NSString*)getDateinUTCFromFormatDDMMYYWithDate:(NSString*)DateString;
-(NSString*)getDateinDDMMYYfromORIGINALUTCDate:(NSString*)utcDate;

// hex string to UIColor
- (UIColor *)colorWithHexString:(NSString *)stringToConvert;

- (void)convertToPercentage:(NSString *)progress withValue:(NSInteger)value;



- (NSInteger)getCurrentDayWithStartDate:(NSDate*)startDate;
- (NSString*)UUIDString;
-(NSData *)dataFromBase64EncodedString:(NSString *)string;
- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;
- (BOOL) logoutAndCleanAllData;
- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize;

- (void) updateProgramStatus;

-(void) showAlertViewWithMessage:(NSString *) message buttonTitle:(NSString *) buttonTitle;

- (void) changeLanguageAndDownloadData;

@end
