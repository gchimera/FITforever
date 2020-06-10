//
//  FITDBChecklist.m
//  fitapp
//
//  Created by Hadi Roohian on 21/12/2016.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import "FITDBChecklist.h"

@implementation FITDBChecklist
+ (NSString*)primaryKey {
    return  @"id";
}

- (id)initWithChecklistDictionary:(NSDictionary *)checklist DaysSystem:(int)daysSystem MealSystem:(int)mealSystem {
    if(self = [super init]) {
        self.type = checklist[@"type"];
        self.title = checklist[@"title"];
        self.sequence = [NSString stringWithFormat: @"%ld", (long)checklist[@"sequence"]];
        self.name = checklist[@"name"];
        self.language = checklist[@"language"];
        self.country = checklist[@"country"];
        
        NSString *interval = [checklist[@"components"] valueForKey:@"interval"];
        if(!([interval boolValue] == true)) {
            self.dosage = checklist[@"components"][@"dosage"];
            self.isInterval = @"false";
            self.intervalText = @"";
            self.intervalTime = @"";
            
        } else {
            self.isInterval = @"true";
            self.intervalText = checklist[@"components"][@"interval-text"];
            self.intervalTime = checklist[@"components"][@"interval-time"];
            self.dosage = @"";
        }
        
        
        self.supplementName = checklist[@"components"][@"name"];
        self.daysSystem = daysSystem;
        self.mealSystem = mealSystem;
        self.id = checklist[@"id"];
        
    }
    return self;
}

@end
