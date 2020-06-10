//
//  AppDelegate.h
//  FIT
//
//  Created by Hamid Mehmood on 01/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <sys/utsname.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <Realm/Realm.h>
#import "User.h"
#import "UserCourse.h"
#import "XPush.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

