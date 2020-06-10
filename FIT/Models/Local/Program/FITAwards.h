//
//  FITAwards.h
//  FIT
//
//  Created by Hamid Mehmood on 09/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"
#import "FITAwardCompleted.h"

@interface FITAwards : BaseRealmData

@property (nonatomic, assign) NSString *awrdsId;
@property NSString *type;
@property NSString *title;
@property NSString *sequence;
@property NSString *name;
@property NSString *language;
@property NSString *country;
@property NSString *programName;
@property NSString *awardKey;
@property NSString *icon;


@property NSString *awardName;
@property NSString *instructionsForAchieving;
@property NSString *awardAchievedMessage;
@property bool typeSolo;
@property bool typeGroup;
@property bool allSupplementsTaken;
@property bool allWaterTaken;
@property bool allExercisesCompleted;
@property bool allFoodsChecked;
@property bool mostInchesLost;

- (id)initWithAwardslistDictionary:(NSDictionary *)awards;

@end
