//
//  Content.h
//  FIT
//
//  Created by Hamid Mehmood on 08/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"

@interface Content : BaseRealmData

@property NSString *idContent;
@property NSString *section;
@property NSString *key;
@property NSString *value;

- (id)initWithContentJSONDictionary:(NSDictionary *)JSONDictionary;

+ (NSString *)idContentFromSection:(NSString *)section andKey:(NSString *)key;

+ (NSString *)contentValueForSection:(NSString *)section andKey:(NSString *)key;

@end
