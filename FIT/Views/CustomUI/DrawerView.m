//
//  DrawerView.m
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "DrawerView.h"

@interface DrawerView ()

@end

@implementation DrawerView

@synthesize version;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString* versionNo = [infoDict objectForKey:@"CFBundleShortVersionString"];
        NSString* build = [infoDict objectForKey:@"CFBundleVersion"];
        
        
        self.version.text = [NSString stringWithFormat:@"© FITAPP Version %@(%@)",versionNo,build]; //TODO
        NSLog(@"© FITAPP Version %@(%@)",versionNo,build);
        
    }
    
    return self;
}

@end
