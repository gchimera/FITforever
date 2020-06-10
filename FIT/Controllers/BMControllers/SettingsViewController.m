//
//  SettingsViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 20/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppSettings.h"
#import "InitialViewController.h"
#import "countryDetail.h"
#import "Locales.h"

@interface SettingsViewController ()
@property AppSettings *appSettings;
@end

@implementation SettingsViewController
NSArray* lenght, *units;
NSMutableArray* tickArray, *tickArray45;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViewController];
    [self loadUIData];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadUIData];
    [_Tabella reloadData];
    [self.navigationController.navigationBar setBarTintColor:[THM BMColor]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadUIData{
    
    
    [self.Tabella reloadData];
    
    [self languageAndButtonUIUpdate:self.logout buttonMode:3 inSection:CONTENT_FITAPP_PROGRAM_SETTINGS_SECTION forKey:CONTENT_BUTTON_LOG_OUT backgroundColor:[THM BMColor]];
    
    [self languageAndButtonUIUpdate:self.done buttonMode:3 inSection:CONTENT_FITAPP_PROGRAM_SETTINGS_SECTION forKey:CONTENT_BUTTON_SAVE backgroundColor:[THM BMColor]];
    
    
    self.appSettings = [AppSettings getAppSettings];
    NSLog(@"Settings : %@", self.appSettings);
    
    // check 'Set Automatically' is on/off
    NSString *swt = [[NSUserDefaults standardUserDefaults] stringForKey:@"switchTime"];
    NSLog(@"%@",swt);
    SettingsCustomCell *cell0 = [_Tabella cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0  inSection:0]];
    SettingsCustomCell *cell1 = [_Tabella cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1  inSection:0]];
    SettingsCustomCell *cell2 = [_Tabella cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2  inSection:0]];
    
    if ([swt isEqualToString:@"1"])
    {
        [cell0.mySwitch setOn:NO animated:NO];
        cell1.userInteractionEnabled = YES;
        cell2.userInteractionEnabled = YES;
    }else{
        [cell0.mySwitch setOn:YES animated:NO];
        cell1.userInteractionEnabled = NO;
        cell2.userInteractionEnabled = NO;
    }
    
    // get timezoneValue
    RLMResults* timezone = [User allObjects];
    cell1.cityLB.text = [[timezone valueForKey:@"country"]firstObject];
    cell2.cityLB.text = [[timezone valueForKey:@"language"]firstObject];
}
- (void)setupViewController
{
    
    self.dataHeader = @[
                        [self localisedStringForSection:CONTENT_FITAPP_SETTINGS_SECTION andKey:CONTENT_LABEL_TIME_ZONE_AND_LANGUAGE],
                        [self localisedStringForSection:CONTENT_FITAPP_SETTINGS_SECTION andKey:CONTENT_LABEL_FUNCTIONALITY],
                        [self localisedStringForSection:CONTENT_FITAPP_SETTINGS_SECTION andKey:CONTENT_LABEL_NOTIFICATIONS]
                        ];
    
    NSArray* colors = @[[UIColor colorWithRed:0.35 green:0.35 blue:0.36 alpha:1.00]];
    
    lenght = @[[self localisedStringForSection:CONTENT_FITAPP_SETTINGS_SECTION andKey:CONTENT_LABEL_INCHES_FEET],[self localisedStringForSection:CONTENT_FITAPP_SETTINGS_SECTION andKey:CONTENT_LABEL_CENTIMETERS_METERS]];
    units = @[[self localisedStringForSection:CONTENT_FITAPP_SETTINGS_SECTION andKey:CONTENT_LABEL_KILOGRAMS],[self localisedStringForSection:CONTENT_FITAPP_SETTINGS_SECTION andKey:CONTENT_LABEL_POUNDS]];
    
    
    
    
    self.headers = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < 3 ; i++)
    {
        UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [header setBackgroundColor:[colors objectAtIndex:0]];
        
        UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 380, 30)];
        fromLabel.text = _dataHeader[i];
        fromLabel.numberOfLines = 1;
        fromLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
        fromLabel.adjustsFontSizeToFitWidth = YES;
        fromLabel.clipsToBounds = YES;
        fromLabel.backgroundColor = [UIColor clearColor];
        fromLabel.textColor = [UIColor whiteColor];
        fromLabel.textAlignment = NSTextAlignmentLeft;
        [header addSubview:fromLabel];
        
        UIView* whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 38, 500, 3)];
        [whiteView setBackgroundColor:[UIColor whiteColor]];
        [header addSubview:whiteView];
        
        
        
        int xArrow = 0;
        
        IS_IPHONE_5 ? xArrow = 280 : IS_IPHONE_6P ? xArrow = 370 : IS_IPHONE_6 ? 300 : 210;  // check 210
        
        // distance x, distance y, width, height
        UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(xArrow, 10, 20, 20)];
        dot.image=[UIImage imageNamed:@"downArrow"];
        [header addSubview:dot];
        
        
        
        [self.headers addObject:header];
    }
    
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    _cell = (SettingsCustomCell *)[theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (_cell == nil) {
        _cell = [[SettingsCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if ([indexPath section]==0)
    {
        
        if (indexPath.row == 0)
        {
            
            [_cell.contentView addSubview:[self setSwitch:0]];
            _cell.textLabel.text = [self localisedStringForSection:CONTENT_FITAPP_SETTINGS_SECTION andKey:CONTENT_LABEL_SET_AUTOMATICALLY];
            _cell.mySwitch.hidden = NO;
            _cell.cityLB.hidden = YES;
            _cell.backgroundColor = [UIColor whiteColor];
            _cell.textLabel.textColor = [UIColor blackColor];
            
            _cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            _cell.tick2.hidden = YES;
            
        }
        
        
        else if (indexPath.row == 1)
        {
            
            [_cell.contentView addSubview:[self setCity:[[NSUserDefaults standardUserDefaults] valueForKey:@"country"]]];
            _cell.textLabel.text = [self localisedStringForSection:CONTENT_FITAPP_SETTINGS_SECTION andKey:CONTENT_LABEL_TIME_ZONE];
            _cell.mySwitch.hidden = YES;
            _cell.cityLB.hidden = NO;
            _cell.backgroundColor = [UIColor colorWithHue:0.00 saturation:0.00 brightness:0.96 alpha:1.00];
            _cell.textLabel.textColor = [UIColor blackColor];
            
            //  _cell.userInteractionEnabled = NO;
            
            _cell.tick2.hidden = YES;
            
        }
        
        else if (indexPath.row == 2)
        {
            
            [_cell.contentView addSubview:[self setCity:[[NSUserDefaults standardUserDefaults] valueForKey:@"language"]]];
            _cell.textLabel.text = [self localisedStringForSection:CONTENT_FITAPP_SETTINGS_SECTION andKey:CONTENT_LABEL_LANGUAGE];
            _cell.mySwitch.hidden = YES;
            _cell.cityLB.hidden = NO;
            _cell.backgroundColor = [UIColor whiteColor];
            _cell.textLabel.textColor = [UIColor blackColor];
            
            
            //   _cell.userInteractionEnabled = NO;
            
            
            if (tickArray.count != 0) {
                _cell.tick2.hidden = NO;
            }
            else{
                _cell.tick2.hidden = YES;
                
            }
        }
        
    }
    
    
    
    
    else if ([indexPath section]==1)
    {
        if (indexPath.row == 0) {
            
            _cell.textLabel.text = [self localisedStringForSection:CONTENT_FITAPP_SETTINGS_SECTION andKey:CONTENT_LABEL_LENGTH];
            _cell.backgroundColor = [UIColor lightGrayColor];
            _cell.userInteractionEnabled = NO;
            _cell.textLabel.textColor = [UIColor blackColor];
            
            _cell.tick2.hidden = YES;
            
            
        }
        else  if (indexPath.row == 1)
        {
            _cell.textLabel.text = [lenght objectAtIndex:0]; // [self.functionality objectAtIndex:indexPath.row];
            _cell.backgroundColor = [UIColor whiteColor];
            _cell.textLabel.textColor = [UIColor blackColor];
            
            
            if (tickArray.count != 0 && [[tickArray firstObject]isEqualToString:@"1"]) {
                
                _cell.tick2.hidden = NO;
                
                _cell.textLabel.textColor = [UIColor whiteColor];
                
                _cell.backgroundColor = [UIColor purpleColor];
                
                _cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            else{
                if([self.appSettings.lenghtType integerValue] == INCHES){
                    
                    _cell.tick2.hidden = NO;
                    
                    _cell.textLabel.textColor = [UIColor whiteColor];
                    
                    _cell.backgroundColor = [UIColor purpleColor];
                    
                    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
                } else{
                    _cell.tick2.hidden = YES;
                }
                
            }
            
        }
        else  if (indexPath.row == 2)
        {
            _cell.textLabel.text = [lenght objectAtIndex:1];
            _cell.backgroundColor = [UIColor whiteColor];
            _cell.textLabel.textColor = [UIColor blackColor];
            
            if (tickArray.count != 0 && [[tickArray firstObject]isEqualToString:@"2"]) {
                
                _cell.tick2.hidden = NO;
                
                _cell.textLabel.textColor = [UIColor whiteColor];
                
                _cell.backgroundColor = [UIColor purpleColor];
                
                _cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            else{
                if([self.appSettings.lenghtType integerValue] == METERS){
                    
                    _cell.tick2.hidden = NO;
                    
                    _cell.textLabel.textColor = [UIColor whiteColor];
                    
                    _cell.backgroundColor = [UIColor purpleColor];
                    
                    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
                } else{
                    _cell.tick2.hidden = YES;
                }
                
            }
            
        }
        else  if (indexPath.row == 3)
        {
            _cell.textLabel.text = [self localisedStringForSection:CONTENT_FITAPP_SETTINGS_SECTION andKey:CONTENT_LABEL_UNITS];
            _cell.backgroundColor = [UIColor lightGrayColor];
            _cell.userInteractionEnabled = NO;
            _cell.textLabel.textColor = [UIColor blackColor];
            
            
            
            _cell.tick2.hidden = YES;
            
            
        }
        else  if (indexPath.row == 4)
        {
            _cell.textLabel.text = [units objectAtIndex:0];
            _cell.backgroundColor = [UIColor whiteColor];
            _cell.textLabel.textColor = [UIColor blackColor];
            _cell.userInteractionEnabled = YES;
            
            
            if (tickArray45.count != 0 && [[tickArray45 firstObject]isEqualToString:@"1"]) {
                _cell.tick2.hidden = NO;
                
                _cell.textLabel.textColor = [UIColor whiteColor];
                
                _cell.backgroundColor = [UIColor purpleColor];
                
                _cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }else{
                if([self.appSettings.wightType integerValue] == GRAMS){
                    
                    _cell.tick2.hidden = NO;
                    
                    _cell.textLabel.textColor = [UIColor whiteColor];
                    
                    _cell.backgroundColor = [UIColor purpleColor];
                    
                    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
                } else{
                    _cell.tick2.hidden = YES;
                }
                
            }
            
            
            
        }
        else  if (indexPath.row == 5)
        {
            _cell.textLabel.text = [units objectAtIndex:1];
            _cell.backgroundColor = [UIColor whiteColor];
            _cell.textLabel.textColor = [UIColor blackColor];
            _cell.userInteractionEnabled = YES;
            
            if (tickArray45.count != 0 && [[tickArray45 firstObject]isEqualToString:@"2"]) {
                _cell.tick2.hidden = NO;
                
                _cell.textLabel.textColor = [UIColor whiteColor];
                
                _cell.backgroundColor = [UIColor purpleColor];
                
                _cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }else{
                if([self.appSettings.wightType integerValue] == LIBRA){
                    
                    _cell.tick2.hidden = NO;
                    
                    _cell.textLabel.textColor = [UIColor whiteColor];
                    
                    _cell.backgroundColor = [UIColor purpleColor];
                    
                    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
                } else{
                    _cell.tick2.hidden = YES;
                }
                
            }
            
            
        }
        
        
        
        
        
        _cell.cityLB.hidden = YES;
        _cell.mySwitch.hidden = YES;
        
        
        
    }
    
    
    
    
    
    else if ([indexPath section]==2)
    {
        
        if (indexPath.row == 0)
        {
            
            [_cell.contentView addSubview:[self setSwitch:1]];
            _cell.textLabel.text = [self localisedStringForSection:CONTENT_FITAPP_SETTINGS_SECTION andKey:CONTENT_LABEL_PUSH_NOTIFICATIONS];
            _cell.cityLB.hidden = YES;
            _cell.mySwitch.hidden = NO;
            _cell.textLabel.textColor = [UIColor blackColor];
            
            _cell.tick2.hidden = YES;
            
            _cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        
        
    }
    
    
    return _cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int returnSections = 0;
    
    switch (section) {
        case 0:
            returnSections = 3;
            break;
            
        case 1:
            returnSections = 6;
            break;
            
        case 2:
            returnSections = 1;
            break;
            
        default:
            break;
    }
    return returnSections;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return [self.headers objectAtIndex:section];
}



-(UISwitch*)setSwitch:(int)function{
    
    _cell.mySwitch.thumbTintColor = [UIColor colorWithRed:0.58 green:0.27 blue:0.54 alpha:1.00];
    _cell.mySwitch.onTintColor = [UIColor colorWithRed:0.35 green:0.35 blue:0.36 alpha:1.00];
    
    // if function == 0 'setTimeAutomatically' otherwise 'setPushNotifications'
    if (function==0) {
        [_cell.mySwitch addTarget:self action:@selector(setTimeSwitch) forControlEvents:UIControlEventValueChanged];
    }else{
        [_cell.mySwitch addTarget:self action:@selector(setPushSwitch) forControlEvents:UIControlEventValueChanged];
    }
    
    return _cell.mySwitch;
    
}

-(void)setTimeSwitch
{
    SettingsCustomCell *cell0 = [_Tabella cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0  inSection:0]];
    
    SettingsCustomCell *cell1 = [_Tabella cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1  inSection:0]];
    SettingsCustomCell *cell2 = [_Tabella cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2  inSection:0]];
    
    if ([cell0.self.mySwitch isOn]) {
        
        cell1.userInteractionEnabled = NO;
        cell2.userInteractionEnabled = NO;
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"switchTime"];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"iso3166_1_2_to_iso3166_1_3" ofType:@"plist"]];
        
        NSString *languageComplete = [[NSLocale preferredLanguages] firstObject];
        
        NSString *country = [dictionary objectForKey:[[NSLocale currentLocale] objectForKey: NSLocaleCountryCode]];
        NSString *language = [[languageComplete componentsSeparatedByString:@"-"] firstObject];
        [[FITAPIManager sharedManager] setCountry:country];
        [[FITAPIManager sharedManager] setLanguage:language];
        [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"language"];
        [[NSUserDefaults standardUserDefaults] setObject:country forKey:@"country"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        RLMResults *getuser = [User allObjects];
        NSString* token = [[getuser valueForKey:@"token"]firstObject];
        
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        
        [realm beginWriteTransaction];
        [User createOrUpdateInRealm:realm withValue:@{@"token": token, @"country": country, @"language": language}];
        [realm commitWriteTransaction];
        
        [[Utils sharedUtils] changeLanguageAndDownloadData];
        
        
        [_Tabella reloadData];
        
    }else{
        cell1.userInteractionEnabled = YES;
        cell2.userInteractionEnabled = YES;
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"switchTime"];
        
        
        
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}

-(void)setPushSwitch{
    
    
    
}



- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %ld row", (long)indexPath.row);
    
    
    // goes to setting details to change country or time settings
    if (indexPath.section == 0)
    {
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
        
        countryDetail *dealVC = (countryDetail *)[storyboard instantiateViewControllerWithIdentifier:@"country"];
        
        // if called by TimeZone
        
//        if (indexPath.row == 2) {
//            
//            NSString *country = [[NSUserDefaults standardUserDefaults] stringForKey:@"country"];
//            RLMResults *locales = [Locales objectsWhere:[NSString stringWithFormat:@"country = '%@'",country]];
//            if([locales count] > 0){
//                dealVC.countryBL = NO;
//                [self presentViewController:dealVC animated:YES completion:^{ }];
//            }
//        }
        if (indexPath.row == 2) {
            User *user = [User userInDB];
            
            RLMResults *countryLanguages = [Locales objectsWhere:[NSString stringWithFormat:@"country = '%@'", [user.country lowercaseString]]];
            
            
            if([countryLanguages count] > 0){
                
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"" message:@"Select Language" preferredStyle:UIAlertControllerStyleActionSheet];
                Locales *locale = [[Locales alloc] init];
                locale = [countryLanguages objectAtIndex:0];
                
                for (int j =0 ; j<locale.supportedLanguages.count; j++)
                {
                    LocaleSupportedLanguages *supLang = [[LocaleSupportedLanguages alloc] init];
                    supLang = locale.supportedLanguages[j];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:supLang.languageDescription style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                        [ac dismissViewControllerAnimated:YES completion:nil];

                        LocaleSupportedLanguages *selectedLang = [[LocaleSupportedLanguages alloc] init];
                        selectedLang = locale.supportedLanguages[j];
                        
                        RLMResults *getuser = [User allObjects];
                        NSString* token = [[getuser valueForKey:@"token"]firstObject];
                        
                        
                        RLMRealm *realm = [RLMRealm defaultRealm];
                        
                        
                        [realm beginWriteTransaction];
                        [User createOrUpdateInRealm:realm withValue:@{@"token": token, @"language": selectedLang.languageCode}];
                        [realm commitWriteTransaction];
                        
                        [[NSUserDefaults standardUserDefaults] setObject:selectedLang.languageCode forKey:@"language"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        [[Utils sharedUtils] changeLanguageAndDownloadData];
                    }];
                    
                    [ac addAction:action];
                }
                
                [self presentViewController:ac animated:YES completion:nil];
                
//                NSString *country = [[NSUserDefaults standardUserDefaults] stringForKey:@"country"];
//                RLMResults *locales = [Locales objectsWhere:[NSString stringWithFormat:@"country = '%@'",country]];

            }
        }
        else if (indexPath.row == 1)
        {
            dealVC.countryBL = YES;
            [self presentViewController:dealVC animated:YES completion:^{ }];
        }
    }
    
    
    
    
    else if (indexPath.section == 1)
    {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        
        if (indexPath.row == 1) {
            
            [self tickCell1:YES table:theTableView cellrow:indexPath.row];
            
            [AppSettings createOrUpdateInRealm:realm withValue:@{
                                                                 @"id": @1 , @"lenghtType" : @(INCHES)
                                                                 }];
            
        }
        else if (indexPath.row == 2) {
            
            [self tickCell1:YES table:theTableView cellrow:indexPath.row];
            
            [AppSettings createOrUpdateInRealm:realm withValue:@{
                                                                 @"id": @1 , @"lenghtType" : @(METERS)
                                                                 }];
        }
        
        else if (indexPath.row == 4) {
            
            [self tickCell2:YES table:theTableView cellrow:indexPath.row];
            
            [AppSettings createOrUpdateInRealm:realm withValue:@{
                                                                 @"id": @1 , @"wightType" : @(GRAMS)
                                                                 }];
        }
        
        else if (indexPath.row == 5) {
            
            [self tickCell2:YES table:theTableView cellrow:indexPath.row];
            
            
            [AppSettings createOrUpdateInRealm:realm withValue:@{
                                                                 @"id": @1 , @"wightType" : @(LIBRA)
                                                                 }];
        }
        
        [realm commitWriteTransaction];
        
    }
    
    
    
    
    
    
    
    
    else if (indexPath.section == 2){
        
        
    }
    
    
}

-(void)updateWeight:(NSString*)property weightOrLenght:(int)val
{
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [AppSettings createOrUpdateInRealm:realm withValue:@{
                                                         @"id": @1 , [NSString stringWithFormat:@"%@",property] : [NSString stringWithFormat:@"%@",val]
                                                         }];
    [realm commitWriteTransaction];
}





-(UILabel*)setCity:(NSString*)string{
    _cell.cityLB.text = string;
    _cell.cityLB.numberOfLines = 1;
    _cell.cityLB.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    _cell.cityLB.adjustsFontSizeToFitWidth = YES;
    _cell.cityLB.clipsToBounds = YES;
    _cell.cityLB.backgroundColor = [UIColor clearColor];
    _cell.cityLB.textColor = [UIColor blackColor];
    _cell.cityLB.textAlignment = NSTextAlignmentLeft;
    
    return _cell.cityLB;
    
}


- (IBAction)logoutBtnTapped:(id)sender {
    [[Utils sharedUtils] logoutAndCleanAllData];
    InitialViewController *loginController = [[UIStoryboard storyboardWithName:LOGIN_STORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:INITIAL_SCREEN]; //or the homeController
    [self.navigationController pushViewController:loginController animated:YES];
    
}

- (IBAction)doneBtnTapped:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}


-(void)tickCell1:(BOOL)tick table:(UITableView*)table cellrow:(NSInteger)row
{
    tickArray = [[NSMutableArray alloc]init];
    
    if (row == 1) {
        
        SettingsCustomCell* cell1 = [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
        
        cell1.tick2.hidden = NO;
        
        cell1.textLabel.textColor = [UIColor whiteColor];
        
        cell1.backgroundColor = [UIColor purpleColor];
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [tickArray addObject:@"1"];
        
        SettingsCustomCell* cell2 = [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
        
        cell2.tick2.hidden = YES;
        
        cell2.textLabel.textColor = [UIColor blackColor];
        
        cell2.backgroundColor = [UIColor whiteColor];
        
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else if(row==2){
        
        
        SettingsCustomCell* cell1 = [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
        
        cell1.tick2.hidden = YES;
        
        cell1.textLabel.textColor = [UIColor blackColor];
        
        cell1.backgroundColor = [UIColor whiteColor];
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [tickArray addObject:@"2"];
        
        
        SettingsCustomCell* cell2 = [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
        
        cell2.tick2.hidden = NO;
        
        cell2.textLabel.textColor = [UIColor whiteColor];
        
        cell2.backgroundColor = [UIColor purpleColor];
        
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
}


-(void)tickCell2:(BOOL)tick table:(UITableView*)table cellrow:(NSInteger)row
{
    tickArray45 = [[NSMutableArray alloc]init];
    
    if (row == 4) {
        
        SettingsCustomCell* cell4 = [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:1]];
        
        cell4.tick2.hidden = NO;
        
        cell4.textLabel.textColor = [UIColor whiteColor];
        
        cell4.backgroundColor = [UIColor purpleColor];
        
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [tickArray45 addObject:@"1"];
        
        SettingsCustomCell* cell5 = [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:1]];
        
        cell5.tick2.hidden = YES;
        
        cell5.textLabel.textColor = [UIColor blackColor];
        
        cell5.backgroundColor = [UIColor whiteColor];
        
        cell5.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    } else if(row == 5){
        
        
        SettingsCustomCell* cell1 = [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:1]];
        
        cell1.tick2.hidden = YES;
        
        cell1.textLabel.textColor = [UIColor blackColor];
        
        cell1.backgroundColor = [UIColor whiteColor];
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [tickArray45 addObject:@"2"];
        
        
        SettingsCustomCell* cell2 = [table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:1]];
        
        cell2.tick2.hidden = NO;
        
        cell2.textLabel.textColor = [UIColor whiteColor];
        
        cell2.backgroundColor = [UIColor purpleColor];
        
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
}

@end
