//
//  FITExercisesRLM.m
//  fitapp
//
//  Created by Hadi Roohian on 14/03/2017.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import "FITWorkoutDetailsRLM.h"

@implementation FITWorkoutDetailsRLM

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
        
        self.thumbnailImage = [dictionary[@"components"] valueForKey:@"thumbnail-image"];
        self.workoutVideo = [dictionary[@"components"] valueForKey:@"workout-video"];
        self.desc = [dictionary[@"components"] valueForKey:@"description"];
        self.workoutName = [dictionary[@"components"] valueForKey:@"workout-name"];

    }
    return self;
}

@end
