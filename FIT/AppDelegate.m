//
//  AppDelegate.m
//  FIT
//
//  Created by Hamid Mehmood on 01/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworkActivityLogger/AFNetworkActivityLogger.h>
#import "FITAPIManager.h"
#import "StoryboardCostants.h"
#import "InitialViewController.h"
#import "Dashboard.h"
#import "AppSettings.h"
#import <Reachability/Reachability.h>
#import "UserCourse.h"
#import "FITBurgerMenu.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLocale *locale = [NSLocale currentLocale];
    
    // Realm migration
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    // Set the new schema version. This must be greater than the previously used
    // version (if you've never set a schema version before, the version is 0).
    config.schemaVersion = 43;
    
    // Set the block which will be called automatically when opening a Realm with a
    // schema version lower than the one set above
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        // We haven’t migrated anything yet, so oldSchemaVersion == 0
        if (oldSchemaVersion < 1) {
            // Nothing to do!
            // Realm will automatically detect new properties and removed properties
            // And will update the schema on disk automaticall
            
        }
    };
    
    // Tell Realm to use this new configuration object for the default Realm
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    // Now that we've told Realm how to handle the schema change, opening the file
    // will automatically perform the migration
    [RLMRealm defaultRealm];
    
    
    //Push notification
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert
                                                                                             | UIUserNotificationTypeBadge
                                                                                             | UIUserNotificationTypeSound) categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    //TODO setup in proper way
    NSString *languageComplete = [[NSLocale preferredLanguages] firstObject];
    //    [[FITAPIManager sharedManager] setCountry:[locale objectForKey:NSLocaleCountryCode]];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"iso3166_1_2_to_iso3166_1_3" ofType:@"plist"]];
    
    
    NSString *country = [dictionary objectForKey:[[NSLocale currentLocale] objectForKey: NSLocaleCountryCode]];
    NSString *language = [[languageComplete componentsSeparatedByString:@"-"] firstObject];
    [[FITAPIManager sharedManager] setCountry:country];
    [[FITAPIManager sharedManager] setLanguage:language];
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"language"];
    [[NSUserDefaults standardUserDefaults] setObject:country forKey:@"country"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[FITAPIManager sharedManager] getSupplementsForProgram:Forever15 success:^(Program *program) {} failure:^(NSError *error) {}];
    [[FITAPIManager sharedManager] getSupplementsForProgram:Clean9 success:^(Program *program) {} failure:^(NSError *error) {}];
    
    // Setup Propel
    NSInteger types = UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
    
    [XPush registerForRemoteNotificationTypes:types];
    // Only runs for development builds sets push to sandbox mode and turns on debug logs
#if DEBUG
    [XPush setSandboxModeEnabled:YES];
    [XPush setShouldShowDebugLogs:YES];
#endif
    [XPush applicationDidFinishLaunchingWithOptions:launchOptions];
    
    [self.window makeKeyAndVisible];
    
    // get device platform
    [self platformString];
    
    //Crashlytics
    [Fabric with:@[[Crashlytics class]]];
    
    //Setting check
    [self getAndUpdateAppSettingsWithLocale:locale];
    
    //Update program status
    [[Utils sharedUtils] updateProgramStatus];
    
    
    User *user = [User userInDB];
    if( user != nil ){ // user already logged in get user to the dashboard
        UIViewController *dashboard = [[UIStoryboard storyboardWithName:PROGRAM_STORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:MAIN_DASHBOARD]; //or the homeController
        FITBurgerMenu *navController = [[FITBurgerMenu alloc]initWithRootViewController:dashboard];
        self.window.rootViewController = navController;
        
    } else {
        InitialViewController *loginController = [[UIStoryboard storyboardWithName:LOGIN_STORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:INITIAL_SCREEN]; //or the homeController
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
        self.window.rootViewController = navController;
    }
    
    
    return YES;
}

- (void) getAndUpdateAppSettingsWithLocale:(NSLocale *) locale{
    //    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    AppSettings *settings = [AppSettings getAppSettings];
    if(settings == nil){
        //setup the locale and setup the setting object for the volume and weight default
        settings = [[AppSettings alloc] init];
        settings.isMetricSystem = [[locale objectForKey:NSLocaleUsesMetricSystem] boolValue];
        
        settings.id = @1;
        
        if (settings.isMetricSystem) {
            settings.volumeType = @(LITRE);
            settings.wightType = @(GRAMS);
            settings.lenghtType = @(METERS);
        } else {
            settings.volumeType =@(OUNCE);
            settings.wightType = @(LIBRA);
            settings.lenghtType = @(INCHES);
        }
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        RLMResults<AppSettings *> *users = [AppSettings allObjects];
        [realm beginWriteTransaction];
        [realm deleteObjects:users];
        [realm commitWriteTransaction];
        
        [realm beginWriteTransaction];
        [realm addOrUpdateObject:settings];
        [realm commitWriteTransaction];
    }
}

- (NSUserDefaults *) platformString
{
    NSUserDefaults * device = [NSUserDefaults standardUserDefaults];
    
    [device setObject:@"unknown" forKey:@"device_info"];
    struct utsname systemInfo;
    uname(&systemInfo);
    //    DLog(@"systemInfo.machine: %@",[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding]);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if(platform) {
        
        NSMutableDictionary *deviceType = [[NSMutableDictionary alloc]init];
        [deviceType setObject:[UIDevice currentDevice].model forKey:@"deviceModel"];
        [deviceType setObject:[UIDevice currentDevice].description forKey:@"deviceModel"];
        [deviceType setObject:[UIDevice currentDevice].localizedModel forKey:@"localizedModel"];
        [deviceType setObject:[UIDevice currentDevice].name forKey:@"name"];
        [deviceType setObject:[UIDevice currentDevice].systemVersion forKey:@"systemVersion"];
        [deviceType setObject:[[UIDevice currentDevice].systemName lowercaseString] forKey:@"device_type"];
        [device setObject:deviceType forKey:@"device_info"];
        DLog(@"device_info ::%@",deviceType);
        
        return device;
    } else {
        DLog(@"device_info :%@",device);
        return device;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    //    [FBSDKAppEvents activateApp];
}


- (void)applicationWillTerminate:(UIApplication *)application {
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    // Add any custom logic here.
    return handled;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings // NS_AVAILABLE_IOS(8_0);
{
    //    [application registerForRemoteNotifications];
    if (notificationSettings.types != UIUserNotificationTypeNone) {
        DLog(@"didRegisterUser");
        [application registerForRemoteNotifications];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString * token = [NSString stringWithFormat:@"%@", deviceToken];//3e60f8351924be4dd0562b47c3c9e5f188124e3d276687e18769da238bed8481
    //Format token as need
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    
    // save temp
    if(![token isEqualToString:@""]){
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"device_token"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isDevice_token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"deviceIdentifier"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        DLog(@"device_token:%@",token);
        [XPush applicationDidRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [XPush applicationDidFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [XPush applicationDidReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [XPush applicationDidReceiveLocalNotification:notification];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Notification Received" message:notification.alertBody delegate:nil     cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
