//
//  FITExerciseDetailsRLM.m
//  fitapp
//
//  Created by Hadi Roohian on 14/03/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import "FITExerciseDetailsRLM.h"

@implementation FITExerciseDetailsRLM

+ (NSString*)primaryKey {
    return  @"uid";
}

- (id)initWithDictionary:(NSDictionary *)dictionary systemName:(NSString *)systemName sectionName:(NSString *)sectionName{
    if(self = [super init]) {
        self.uid = dictionary[@"id"];
        self.systemName = systemName;
        self.sectionName = sectionName;
        self.type = dictionary[@"type"];
        self.title = dictionary[@"title"];
        self.sequence = [NSNumber numberWithInt:[dictionary[@"sequence"] intValue]];
        self.name = dictionary[@"name"];
        self.language = dictionary[@"language"];
        self.country = dictionary[@"country"];
        
        self.duration = [dictionary[@"components"] valueForKey:@"duration"];
        self.exerciseName = [dictionary[@"components"] valueForKey:@"exercise-name"];

        
    }
    return self;
}

@end
