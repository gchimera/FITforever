//
//  FITDBChecklist.h
//  fitapp
//
//  Created by Hadi Roohian on 21/12/2016.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import <Realm/Realm.h>

@interface FITDBChecklist : RLMObject

@property (nonatomic, assign) NSString *id;
@property NSString *type;
@property NSString *title;
@property NSString *sequence;
@property NSString *name;
@property NSString *language;
@property NSString *country;
@property NSString *dosage;
@property NSString *supplementName;
@property NSString *isInterval;
@property NSString *intervalText;
@property NSString *intervalTime;
@property int daysSystem;
@property int mealSystem;

- (id)initWithChecklistDictionary:(NSDictionary *)checklist DaysSystem:(int)daysSystem MealSystem:(int)mealSystem;

@end
