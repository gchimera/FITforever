//
//  FITExercisesRLM.h
//  fitapp
//
//  Created by Hadi Roohian on 14/03/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import <Realm/Realm.h>

@interface FITWorkoutDetailsRLM : RLMObject

@property (nonatomic, assign) NSString *uid;
@property NSString *systemName;
@property NSString *sectionName;
@property NSString *type;
@property NSString *title;
@property NSNumber<RLMInt> *sequence;
@property NSString *name;
@property NSString *language;
@property NSString *country;


@property NSString *thumbnailImage;
@property NSString *workoutVideo;
@property NSString *desc;
@property NSString *workoutName;

- (id)initWithDictionary:(NSDictionary *)dictionary systemName:(NSString *)systemName sectionName:(NSString *)sectionName;

@end
