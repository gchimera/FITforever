//
//  FITProgressSequeItem.h
//  FIT
//
//  Created by Bruce Cresanta on 3/19/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

#import "FITButton.h"
#import "FITAPIConstant.h"
#import "StoryboardCostants.h"

#import "User.h"
#import "Utils.h"
#import "ColorConstants.h"

@interface FITProgressSegueItem : UIButton {
}

@property UserCourse *selectedCourse;
@property (readwrite) BOOL canenable;
@property (readwrite) UserCourseType *courseSelected;
@property (readwrite,assign) BOOL showActive;

-(void) setActive:(BOOL) active;

@end
