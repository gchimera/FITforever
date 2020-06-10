//
//  AppSettings.m
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "AppSettings.h"

@implementation AppSettings

+ (NSString*)primaryKey {
    return  @"id";
}

+ (AppSettings * _Nullable)getAppSettings {
    RLMResults<AppSettings *> *settings = [AppSettings allObjects];
    return settings.count > 0 ? settings[0] : nil;
}

- (void) updateAppSettings:(AppSettings *) appSettings {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    RLMResults<AppSettings *> *users = [AppSettings allObjects];
    [realm beginWriteTransaction];
    [realm deleteObjects:users];
    [realm commitWriteTransaction];
    
    [realm beginWriteTransaction];
    [realm addObject:appSettings];
    [realm commitWriteTransaction];
    
}


@end
