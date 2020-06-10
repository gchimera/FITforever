//
//  Water.h
//  fitapp
//
//  Created by Hadi Roohian on 05/01/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import "BaseRealmData.h"

@interface Water : BaseRealmData
@property   (nonatomic, assign) NSString * _Nullable uid;
@property   NSString * _Nullable day;
@property   int count;
@property NSString * _Nullable programID;
@property NSNumber<RLMInt> * _Nullable serverWaterId;
//@property   NSString *cmsID;
@property NSDate*  _Nullable dateAchieved;
@property BOOL isAchived;

@end
RLM_ARRAY_TYPE(Water)
