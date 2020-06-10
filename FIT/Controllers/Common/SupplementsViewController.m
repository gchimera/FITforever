//
//  SupplementsViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "SupplementsViewController.h"
#import "Supplements.h"
#import "SupplementCell.h"

@interface SupplementsViewController ()

@property (strong, nonatomic) FITBurgerMenu *rootNav;
@property RLMResults *checklistData;
@property int day;
@property int meal;
@property NSString *program;
@property NSString *partOfDay;
@property RLMResults *result;
@property int currentCheckedCount;

@end

@implementation SupplementsViewController

@synthesize sender;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self programButtonUpdate:self.nextBtn buttonMode:3 inSection:CONTENT_FIT_C9_SNACK_SECTION forKey:CONTENT_BUTTON_NEXT];
    
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    
    self.partOfDay = sender;
    
    self.currentCheckedCount = 0;
    [self loadCurrentCheckedCount];
    [self fetchChecklistFromRealmForDay:self.day];
    
    self.rootNav = (FITBurgerMenu *)self.navigationController;
    [self.rootNav setFITNavDrawerDelegate:self];
    
    
    
    if ([sender isEqualToString:@"breakfast"]) {
        self.navigationItem.title = @"Breakfast";
    } else if([sender isEqualToString:@"lunch"]) {
        self.navigationItem.title = @"Lunch";
    } else if([sender isEqualToString:@"dinner"]) {
        self.navigationItem.title = @"Dinner";
    } else if([sender isEqualToString:@"snack"]) {
        self.navigationItem.title = @"Snack";
    } else if([sender isEqualToString:@"evening"]) {
        self.navigationItem.title = @"Evening";
    }
    
    
    
}
- (IBAction)drawerToggle:(id)sender {
    [self.rootNav drawerToggle];
}

-(void)loadCurrentCheckedCount {
    self.result = [Supplements objectsWhere:[NSString stringWithFormat:@"day = '%d' && partOfDay = '%@' && programID = '%@'",self.day,self.partOfDay, self.currentCourse.userProgramId]];
    if(self.result.firstObject == NULL) {
        self.currentCheckedCount = 0;
    } else {
        self.currentCheckedCount = [self.result[0][@"count"] intValue];
    }
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.checklistData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.result = [Supplements objectsWhere:[NSString stringWithFormat:@"day = '%d' && partOfDay = '%@' && programID = '%@' && supplementID = '%@'",self.day,self.partOfDay, self.currentCourse.userProgramId, [self.checklistData objectAtIndex:indexPath.row][@"id"]]];
    
    SupplementCell *supplementCell = [tableView dequeueReusableCellWithIdentifier:@"supplementCell"];
    if ([[[self.result firstObject] valueForKey:@"isChecked"] boolValue]) {
        [[supplementCell supplementHexBtn] setBackgroundImage:[UIImage imageNamed:@"hexagononC9"] forState:UIControlStateNormal];
    } else if ( indexPath.row == 1) {
        [[supplementCell supplementHexBtn] setBackgroundImage:[UIImage imageNamed:@"waitthirtyminutesicon"] forState:UIControlStateNormal];
    } else {
        [[supplementCell supplementHexBtn] setBackgroundImage:[UIImage imageNamed:@"hexagonoffC9"] forState:UIControlStateNormal];
    }
    //        [supplementCell configureSupplementCell:[self.checklistData objectAtIndex:indexPath.row][@"name"] supplementButtonImageName:@"hexopen"];
    [[supplementCell supplementLabel] setText:[self.checklistData objectAtIndex:indexPath.row][@"name"]];
    [[supplementCell supplementHexBtn] addTarget:self action:@selector(updateSelectedRow:) forControlEvents:UIControlEventTouchUpInside];
    [[supplementCell supplementHexBtn] setTag:indexPath.row];
    return supplementCell;
    //    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)updateSelectedRow:(UIButton *)senderButton {
    
    self.result = [Supplements objectsWhere:[NSString stringWithFormat:@"day = '%d' && partOfDay = '%@' && programID = '%@' && supplementID = '%@'",self.day,self.partOfDay, self.currentCourse.userProgramId, [self.checklistData objectAtIndex:senderButton.tag][@"id"]]];
    
    if ([[[self.result firstObject] valueForKey:@"isChecked"] boolValue]) {
        [self updateSupplementsTableInRealm:senderButton shouldCheck:NO forID:[[self.result firstObject] valueForKey:@"uid"]];
    } else {
        [self updateSupplementsTableInRealm:senderButton shouldCheck:YES forID:[[self.result firstObject] valueForKey:@"uid"]];
    }
    
    [self.tableView reloadData];
}








- (void)updateSupplementsTableInRealm:(UIButton *)senderButton shouldCheck:(BOOL)isChecked forID:(NSString *)primaryID {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    if([primaryID length] == 0) {
        [Supplements createOrUpdateInRealm:realm withValue:@{@"day": [NSString stringWithFormat:@"%d",self.day], @"partOfDay":self.partOfDay, @"supplementID": [self.checklistData objectAtIndex:senderButton.tag][@"id"], @"programID": self.currentCourse.userProgramId, @"isChecked": @(isChecked)}];
    } else {
        [Supplements createOrUpdateInRealm:realm withValue:@{@"uid":primaryID, @"day": [NSString stringWithFormat:@"%d",self.day], @"partOfDay":self.partOfDay, @"supplementID": [self.checklistData objectAtIndex:senderButton.tag][@"id"], @"programID": self.currentCourse.userProgramId, @"isChecked": @(isChecked)}];
    }
    
    [CourseDay createOrUpdateInRealm:realm withValue:@{
                                                       @"dayId":[NSString stringWithFormat:@"%@_%@",self.currentCourse.userProgramId,[NSString stringWithFormat:@"%d",self.day]],
                                                       @"programID":[NSString stringWithFormat:@"%@",self.currentCourse.userProgramId],
                                                       @"day" : [NSString stringWithFormat:@"%d",self.day],
                                                       @"date": [NSDate date]
                                                       }];
    [realm commitWriteTransaction];
}



#pragma mark - LOOP ON REALM DB TO SHOW LABELS
- (void)fetchChecklistFromRealmForDay:(int)day {
    //change real days to systemDays to use in our query to Realm DB.
    int systemDay;
    switch (self.day) {
        case 1 ... 2:
            systemDay = 0;
            break;
        case 3 ... 8:
            systemDay = 1;
            break;
        case 9:
            systemDay = 2;
        default:
            break;
    }
    
    
    int mealSystem;
    if ([self.partOfDay isEqualToString:@"breakfast"]) {
        mealSystem = 0;
    } else if ([self.partOfDay isEqualToString:@"snack"]) {
        mealSystem = 1;
    } else if ([self.partOfDay isEqualToString:@"lunch"]) {
        mealSystem = 2;
    } else if ([self.partOfDay isEqualToString:@"dinner"]) {
        mealSystem = 3;
    } else {
        mealSystem = 4;
    }
    
    //    self.checklistData =   [FITC9Checklist objectsWhere:[NSString stringWithFormat:@"daysSystem = %d && mealSystem = %d",systemDay, mealSystem]];
    
}

- (IBAction)nextBtnTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - burger delegate

-(void)FITNavDrawerSelection:(NSInteger)selectionIndex
{
    NSLog(@"FITNavDrawerSelection = %li", (long)selectionIndex);
    //        self.selectionIdx.text = [NSString stringWithFormat:@"%li",(long)selectionIndex];
}

@end
