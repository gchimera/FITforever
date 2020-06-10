//
//  Content.m
//  FIT
//
//  Created by Hamid Mehmood on 08/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "Content.h"

@implementation Content

- (id)initWithContentJSONDictionary:(NSDictionary *)JSONDictionary {
    self = [super init];
    if(!self) return nil;
    
    self.section = JSONDictionary[@"section"];
    self.key = JSONDictionary[@"key"];
    self.value = JSONDictionary[@"value"];
    self.idContent = [Content idContentFromSection:self.section andKey:self.key];

    return self;
}

+ (NSString *)primaryKey {
    return @"idContent";
}

+ (NSString *)idContentFromSection:(NSString *)section andKey:(NSString *)key {
    return [NSString stringWithFormat:@"%@_%@", section, key];
}

+ (NSString * _Nullable)contentValueForSection:(NSString *)section andKey:(NSString *)key {
    RLMResults<Content *> *contents = [Content objectsWhere:@"section = %@ AND key = %@", section, key];
    return contents.count > 0 ? contents[0].value : nil;
}

@end
