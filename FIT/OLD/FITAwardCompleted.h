//
//  FITAwardCompleted.h
//  fitapp
//
//  Created by Guglielmo Chimera on 06/03/17.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import <Realm/Realm.h>

@interface FITAwardCompleted : RLMObject

@property NSString* awardCompleteId;
@property NSString* programID;
@property NSDate* dateAchieved;
@property NSString* awardID;
@property NSString* day;

@end
