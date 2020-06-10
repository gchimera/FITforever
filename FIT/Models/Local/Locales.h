//
//  Locales.h
//  FIT
//
//  Created by Hamid Mehmood on 03/04/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"
#import "LocaleSupportedLanguages.h"

@interface Locales : BaseRealmData

@property NSString * _Nullable localeId;
@property NSString * _Nullable defaultLanguage;
@property NSString * _Nullable countryLabel;
@property NSString * _Nullable country;
@property RLMArray<LocaleSupportedLanguages *><LocaleSupportedLanguages> *supportedLanguages;

@end
