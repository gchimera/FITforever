//
//  Supplements.h
//  fitapp
//
//  Created by Hadi Roohian on 04/01/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import "BaseRealmData.h"

@interface Supplements : BaseRealmData

@property (nonatomic, assign) NSString * _Nullable uid;
@property NSString * _Nullable day;
@property NSNumber<RLMInt> * _Nullable serverSupplementId;
@property NSString * partOfDay;
@property NSString * _Nullable programID;
@property NSString * _Nullable supplementID;
@property bool isChecked;
@property NSString *cmsID;
//@property   NSDate *createdAt;


@end

// This protocol enables typed collections. i.e.:
RLM_ARRAY_TYPE(Supplements)
