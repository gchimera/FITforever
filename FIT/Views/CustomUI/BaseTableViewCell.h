//
//  BaseTableViewCell.h
//  FIT
//
//  Created by Bruce Cresanta on 3/19/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

#import "SVProgressHUD.h"
#import "FITButton.h"
#import "FITAPIConstant.h"
#import "StoryboardCostants.h"
#import "FITAPIManager.h"
#import "User.h"
#import "Utils.h"
#import "ColorConstants.h"
#import "FITRuler.h"
#import "FITBurgerMenu.h"
#import "RulerPicker.h"
#import "LAPickerView.h"
@interface BaseTableViewCell : UITableViewCell
@property UserCourse *currentCourse;

- (void)languageAndButtonUIUpdate:(UIButton *)button
                       buttonMode:(int)buttonMode
                        inSection:(NSString *)section
                           forKey:(NSString *)key
                  backgroundColor:(UIColor*)color;

- (void)languageAndLabelUIUpdate:(UILabel *)label
                       inSection:(NSString *)section
                          forKey:(NSString *)key;

- (void)languageHTMLLabelUIUpdate:(UILabel *)label
                        inSection:(NSString *) section
                           forKey:(NSString *) key;

- (void)languageAndTextFieldUIUpdate:(UITextField *)textField
                           inSection:(NSString *)section
                              forKey:(NSString *)key;

- (NSString *)localisedStringForSection:(NSString *)section
                                 andKey:(NSString *)key;

- (NSString *)localisedHTMLForSection:(NSString *)section
                               andKey:(NSString *)key;


@end
