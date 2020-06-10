//
//  FITAwards.m
//  FIT
//
//  Created by Hamid Mehmood on 09/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "FITAwards.h"

@implementation FITAwards

+ (NSString*)primaryKey {
    return  @"awrdsId";
}

- (id)initWithAwardslistDictionary:(NSDictionary *)awards {
    if(self = [super init]) {
        self.type = awards[@"type"];
        self.title = awards[@"title"];
        self.sequence = [NSString stringWithFormat: @"%ld", (long)awards[@"sequence"]];
        self.name = awards[@"name"];
        self.language = awards[@"language"];
        self.country = awards[@"country"];
        self.awardName = awards[@"components"][@"award-name"];
        self.instructionsForAchieving = awards[@"components"][@"instructions-for-achieving"];
        self.awardAchievedMessage = awards[@"components"][@"award-achieved-message"];
        self.awardKey = awards[@"components"][@"award-key"];

        
    
        if ([self.awardKey isEqualToString:@"c9-weight-warrior"] || [self.awardKey isEqualToString:@"f15-advanced-weight-warrior"] || [self.awardKey isEqualToString:@"f15-beginner-weight-warrior"] || [self.awardKey isEqualToString:@"f15-beginner-weight-warrior"])
        {
            self.icon = @"weightwarrior";
        }
        if ([self.awardKey isEqualToString:@"c9-shape-shifter"] || [self.awardKey isEqualToString:@"f15-advanced-shape-shifter"] || [self.awardKey isEqualToString:@"f15-beginner-shape-shifter"] || [self.awardKey isEqualToString:@"f15-intermediate-shape-shifter"])
        {
            self.icon = @"shapeshifter";
        }
        if ([self.awardKey isEqualToString:@"f15-advanced-fighting-fit"] || [self.awardKey isEqualToString:@"f15-beginner-fighting-fit"] || [self.awardKey isEqualToString:@"f15-intermediate-fighting-fit"])
        {
            self.icon = @"fightingfit";
        }
        if ([self.awardKey isEqualToString:@"f15-advanced-kicking-cardio"] || [self.awardKey isEqualToString:@"f15-beginner-kicking-cardio"] || [self.awardKey isEqualToString:@"f15-intermediate-kicking-cardio"])
        {
            self.icon = @"kickingcardio";
        }
        if ([self.awardKey isEqualToString:@"c9-supplement-hero"] || [self.awardKey isEqualToString:@"f15-advanced-supplement-hero"] || [self.awardKey isEqualToString:@"f15-beginner-supplement-hero"]|| [self.awardKey isEqualToString:@"f15-intermediate-supplement-hero"])
        {
            self.icon = @"supplementhero";
        }
        if ([self.awardKey isEqualToString:@"c9-thirsty-first"] || [self.awardKey isEqualToString:@"f15-advanced-thirsty-first"] || [self.awardKey isEqualToString:@"f15-beginner-thirsty-first"]|| [self.awardKey isEqualToString:@"f15-intermediate-thirsty-first"])
        {
            self.icon = @"thirstyfirst";
        }
        if ([self.awardKey isEqualToString:@"c9-fitness-fanatic"] || [self.awardKey isEqualToString:@"f15-advanced-fitness-fanatic"] || [self.awardKey isEqualToString:@"f15-beginner-fitness-fanatic"]|| [self.awardKey isEqualToString:@"f15-intermediate-fitness-fanatic"])
        {
            self.icon = @"fitnessfanatic";
        }
        if ([self.awardKey isEqualToString:@"c9-well-supplied"] || [self.awardKey isEqualToString:@"f15-advanced-well-supplied"] || [self.awardKey isEqualToString:@"f15-beginner-well-supplied"] || [self.awardKey isEqualToString:@"f15-intermediate-well-supplied"])
        {
            self.icon = @"wellsupplied";
        }
        if ([self.awardKey isEqualToString:@"c9-quenched"] || [self.awardKey isEqualToString:@"f15-advanced-quenched"] || [self.awardKey isEqualToString:@"f15-beginner-quenched"]|| [self.awardKey isEqualToString:@"f15-intermediate-quenched"])
        {
            self.icon = @"quenched";
        }
        if ([self.awardKey isEqualToString:@"c9-perfect-performance"] || [self.awardKey isEqualToString:@"f15-advanced-perfect-performance"] || [self.awardKey isEqualToString:@"f15-beginner-perfect-performance"]|| [self.awardKey isEqualToString:@"f15-intermediate-perfect-performance"])
        {
            self.icon = @"perefctperformance";
        }
        if ([self.awardKey isEqualToString:@"c9-fuel-my-fire"] || [self.awardKey isEqualToString:@"f15-advanced-fuel-my-fire"] || [self.awardKey isEqualToString:@"f15-beginner-fuel-my-fire"]|| [self.awardKey isEqualToString:@"f15-intermediate-fuel-my-fire"])
        {
            self.icon = @"fuelmyfire";
        }
        if ([self.awardKey isEqualToString:@"f15-advanced-kitchen-commander"] || [self.awardKey isEqualToString:@"f15-beginner-kitchen-commander"]|| [self.awardKey isEqualToString:@"f15-intermediate-kitchen-commander"])
        {
            self.icon = @"kitchencommander";
        }
        if ([self.awardKey isEqualToString:@"f15-advanced-super-shaker"] || [self.awardKey isEqualToString:@"f15-beginner-super-shaker"]|| [self.awardKey isEqualToString:@"f15-intermediate-super-shaker"])
        {
            self.icon = @"supershaker";
        }
        if ([self.awardKey isEqualToString:@"c9-clean-machine"])
        {
            self.icon = @"cleanmachine";
        }
        if ([self.awardKey isEqualToString:@"c9-fully-fueled"] || [self.awardKey isEqualToString:@"f15-beginner-fully-fueled"] || [self.awardKey isEqualToString:@"f15-advanced-fully-fueled"] || [self.awardKey isEqualToString:@"f15-intermediate-fully-fueled"])
        {
            self.icon = @"fullyfueled";
        }
        if ([self.awardKey isEqualToString:@"f15-intermediate-yoga-master"])
        {
            self.icon = @"yogamaster";
        }
        
        
        self.typeSolo = [[awards[@"components"] valueForKey:@"type-solo"] boolValue];
        self.typeGroup = [[awards[@"components"] valueForKey:@"type-group"] boolValue];
        self.allSupplementsTaken = [[awards[@"components"] valueForKey:@"all-supplements-taken"] boolValue];
        self.allWaterTaken = [[awards[@"components"] valueForKey:@"all-water-taken"] boolValue];
        self.allExercisesCompleted = [[awards[@"components"] valueForKey:@"all-exercises-completed"] boolValue];
        self.allFoodsChecked = [[awards[@"components"] valueForKey:@"all-foods-checked"] boolValue];
        self.mostInchesLost = [[awards[@"components"] valueForKey:@"most-inches-lost"] boolValue];
        self.awrdsId = awards[@"id"];
        
    }
    return self;
}


@end
