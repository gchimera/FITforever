//
//  FITRecipes.h
//  FIT
//
//  Created by Hamid Mehmood on 09/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseRealmData.h"

@interface FITRecipes : BaseRealmData

@property (nonatomic, assign) NSString *recipePrimaryKey;
@property (nonatomic, assign) NSString *recipeId;
@property NSString *type;
@property NSString *title;
@property NSString *sequence;
@property NSString *name;
@property NSString *language;
@property NSString *country;


@property NSString *image;
@property NSString *thumbnailImage;
@property NSString *shakeVideo;
@property NSString *ingredients;
@property NSString *estimatedCalories;
@property NSString *desc;
@property NSString *recipeName;
@property bool programF15Beginner1;
@property bool programF15Beginner2;
@property bool programF15Intermediate1;
@property bool programF15Intermediate2;
@property bool programF15Advanced1;
@property bool programF15Advanced2;

- (id)initWithDictionary:(NSDictionary *)dictionary;


@end
