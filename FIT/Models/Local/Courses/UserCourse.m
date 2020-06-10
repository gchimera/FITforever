//
//  UserCourse.m
//  FIT
//
//  Created by Hamid Mehmood on 13/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "UserCourse.h"

@implementation UserCourse

+ (NSString *)primaryKey {
    return @"userProgramId";
}

+ (UserCourse * _Nullable)currentProgram {
    RLMResults<UserCourse *> *program = [UserCourse objectsWhere:@"isCurrentCourse = %d",YES ];
    return program.count > 0 ? program[0] : nil;
}

- (UserCourse * _Nullable)createNewCourse:(UserCourse  * _Nonnull)course{
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    
    [realm addOrUpdateObject:course];
    
    [realm commitWriteTransaction];
    
    RLMResults<UserCourse *> *program = [UserCourse objectsWhere:@"userProgramId =  %d",course.userProgramId ];
    return program.count > 0 ? program[0] : nil;

}

+ (NSDictionary *)defaultPropertyValues {
    return @{@"thirdDayChoose": @0};
}

@end
