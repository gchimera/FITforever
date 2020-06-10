//
//  countryDetail.m
//  FIT
//
//  Created by Guglielmo Chimera on 04/04/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "countryDetail.h"
#import <Realm/Realm.h>
#import "Locales.h"
#import "User.h"

@interface countryDetail ()

@property RLMResults* result;
@property Locales* languages;

@end

@implementation countryDetail


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (_countryBL) {
        self.result = [[Locales allObjects]sortedResultsUsingProperty:@"countryLabel" ascending:YES];
        self.countryLB.text = @"Select country";
        
    }else{
        NSString *country = [[NSUserDefaults standardUserDefaults] stringForKey:@"country"];
        self.result = [Locales objectsWhere:[NSString stringWithFormat:@"country = '%@'",country]];
        self.countryLB.text = @"Select language";
        self.languages = [_result objectAtIndex:0];
        
        
    }
    
    [self languageAndButtonUIUpdate:self.doneButton buttonMode:3 inSection:CONTENT_FIT_C9_WATER_INTAKE_SECTION forKey:CONTENT_BUTTON_DONE backgroundColor:[THM BMColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    if (_countryBL) {
        return [self.result count];
    }else{
        return [self.languages.supportedLanguages count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = (UITableViewCell *)[theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    if (_countryBL) {
        Locales* exerc = [self.result objectAtIndex:indexPath.row];
        cell.textLabel.text = exerc.countryLabel;
    }else{
        cell.textLabel.text = [[self.languages.supportedLanguages valueForKey:@"languageDescription"]objectAtIndex:indexPath.row];
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %ld row", (long)indexPath.row);
    
    UITableViewCell *cell = [theTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row  inSection:0]];
    
    cell.imageView.image = [UIImage imageNamed:@"tick2"];
    
    cell.backgroundColor = [UIColor purpleColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (_countryBL) {
        
        Locales* exerc = [self.result objectAtIndex:indexPath.row];
        
        NSLog(@"%@",exerc.countryLabel);
        
        [[NSUserDefaults standardUserDefaults] setObject:exerc.country forKey:@"country"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        RLMResults *getuser = [User allObjects];
        NSString* token = [[getuser valueForKey:@"token"]firstObject];
        
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        
        [realm beginWriteTransaction];
        [User createOrUpdateInRealm:realm withValue:@{@"token": token, @"country": exerc.country}];
        [realm commitWriteTransaction];
    }
    else
    {
        
        
        RLMResults *getuser = [User allObjects];
        NSString* token = [[getuser valueForKey:@"token"]firstObject];
        
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        
        [realm beginWriteTransaction];
        [User createOrUpdateInRealm:realm withValue:@{@"token": token, @"language": [[self.languages.supportedLanguages valueForKey:@"languageCode"]objectAtIndex:indexPath.row]}];
        [realm commitWriteTransaction];
        
        [[NSUserDefaults standardUserDefaults] setObject:[[self.languages.supportedLanguages valueForKey:@"languageDescription"]objectAtIndex:indexPath.row] forKey:@"language"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[Utils sharedUtils] changeLanguageAndDownloadData];
        
        
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
