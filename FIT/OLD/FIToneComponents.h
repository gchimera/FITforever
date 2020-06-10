//
//  FIToneComponents.h
//  fitapp
//
//  Created by Guglielmo Chimera on 24/12/16.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import <Realm/Realm.h>

@interface FIToneComponents : RLMObject

@property (nonatomic, assign) NSString* id;

@property NSString *name;

@property NSString *size;

@property NSString* type;


@end
