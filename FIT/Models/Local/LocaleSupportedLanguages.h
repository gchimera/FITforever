//
//  LocaleSupportedLanguages.h
//  FIT
//
//  Created by Hamid Mehmood on 03/04/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"

@interface LocaleSupportedLanguages : BaseRealmData

@property NSString *supportedLanguageId;
@property NSString *languageCode;
@property NSString *languageDescription;

@end

RLM_ARRAY_TYPE(LocaleSupportedLanguages)
