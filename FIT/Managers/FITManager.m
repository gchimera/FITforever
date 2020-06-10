//
//  FITManager.m
//  FIT
//
//  Created by Hamid Mehmood on 02/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "FITManager.h"

NSString * const kFileFolderName = @"uk.co.b60apps.fit.files";
NSString * const kFileName = @"uk.co.b60apps.fit.user.plist";
NSString * const kFileTypeName = @"uk.co.b60apps.fit.user.type.plist";

@implementation FITManager

+ (FITManager *)sharedManager
{
    static FITManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        [self initFilesFolder];
        [self loadUser];
        [self loadUserType];
    }
    return self;
}

- (void)initFilesFolder
{
    [self createFilesFolderIfNeeded];
}

- (BOOL)createFilesFolderIfNeeded
{
    NSURL *filesFolderURL = [self filesFolderURL];
    BOOL isDir = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:[filesFolderURL path] isDirectory:&isDir] == NO) {
        NSError *error = nil;
        if ([[NSFileManager defaultManager] createDirectoryAtURL:filesFolderURL
                                     withIntermediateDirectories:YES
                                                      attributes:@{ NSURLIsExcludedFromBackupKey : @(YES) }
                                                           error:&error] == NO) {
            NSLog(@"Can't create Files folder directory: %@", error);
            return NO;
        }
    }
    else if (isDir == NO) {
        NSLog(@"File folder directory name is already taken by a file");
        return NO;
    }
    return YES;
}

- (NSURL *)filesFolderURL
{
    NSURL *filesFolderURL = [self applicationSupportDirectory];
    filesFolderURL = [filesFolderURL URLByAppendingPathComponent:kFileFolderName isDirectory:YES];
    return filesFolderURL;
}

- (NSURL *)applicationSupportDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)setUser:(User *)user
{
    if (_user != user) {
        _user = user;
        [self saveUser];
    }
}

- (void)setUserType:(NSString *)userType
{
    if (_userType != userType) {
        _userType = userType;
        [self saveUserType];
    }
}


- (void)loadUser
{
    NSURL *dataURL = [[self filesFolderURL] URLByAppendingPathComponent:kFileName];
    _user = [NSKeyedUnarchiver unarchiveObjectWithFile:[dataURL path]];
}

- (void)saveUser
{
    NSURL *dataURL = [[self filesFolderURL] URLByAppendingPathComponent:kFileName];
    [NSKeyedArchiver archiveRootObject:self.user toFile:[dataURL path]];
}


- (void)loadUserType
{
    NSURL *dataURL = [[self filesFolderURL] URLByAppendingPathComponent:kFileTypeName];
    _userType = [NSKeyedUnarchiver unarchiveObjectWithFile:[dataURL path]];
}

- (void)saveUserType
{
    NSURL *dataURL = [[self filesFolderURL] URLByAppendingPathComponent:kFileTypeName];
    [NSKeyedArchiver archiveRootObject:self.userType toFile:[dataURL path]];
}

@end
