//
//  CheckListViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "CheckListViewController.h"
#import "Supplements.h"
#import "Water.h"
#import "ProgramFIT.h"

@interface CheckListViewController ()
@property NSInteger program;
@property RLMResults *programSupplementsResults;
@end

@implementation CheckListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    self.program = [self.currentCourse.courseType integerValue];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self fetchChecklistFromRealmForDay:self.day];
}


#pragma mark - LOOP ON REALM DB TO SHOW LABELS
- (void)fetchChecklistFromRealmForDay:(int)day {
    
    if(self.program == 0) {
        
        NSString *dayIDForUsingInRealmQuery;
        switch (self.day) {
            case 1 ... 2:
                dayIDForUsingInRealmQuery = @"fit-supplements-c9-days-1-2";
                break;
            case 3 ... 8:
                dayIDForUsingInRealmQuery = @"fit-supplements-c9-days-3-8";
                break;
            case 9:
                dayIDForUsingInRealmQuery = @"fit-supplements-c9-days-9";
            default:
                break;
        }
        
        
        
        self.programSupplementsResults = [[[[ProgramFIT objectsWhere:[NSString stringWithFormat:@"name = 'C9'"]] valueForKey:@"days"] objectAtIndex:0] objectsWhere:[NSString stringWithFormat:@"idDays = '%@'",dayIDForUsingInRealmQuery]];
//    valueForKey:self.supplementNameForUsingInRealmQuery] objectAtIndex:0];

    } else {
        
        NSString *nameProgramForUsingInRealmQuery = [[NSString alloc] init];
        switch ([self.currentCourse.courseType integerValue]) {
            case F15Begginner1:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-beginner-1";
                break;
                
            case F15Begginner2:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-beginner-2";
                break;
                
            case F15Intermidiate1:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-intermediate-1";
                break;
                
            case F15Intermidiate2:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-intermediate-2";
                break;
                
            case F15Advance1:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-advanced-1";
                break;
                
            case F15Advance2:
                nameProgramForUsingInRealmQuery = @"fit-supplements-f15-advanced-2";
                break;
                
            default:
                
                break;
        }

        
        self.programSupplementsResults = [[[[ProgramFIT objectsWhere:[NSString stringWithFormat:@"name = 'F15'"]] valueForKey:@"days"] objectAtIndex:0] objectsWhere:[NSString stringWithFormat:@"idDays = '%@'", nameProgramForUsingInRealmQuery]];
    }
    DLog(@"All Supppps : %@",self.programSupplementsResults);
    
//    Counting all meals stored in Realm DB To know how many label we need for each meal.
    self.breakfastChecklist =  [[self.programSupplementsResults valueForKey:@"breakfastSupplements"] firstObject];
    self.snackChecklist =  [[self.programSupplementsResults valueForKey:@"snackSupplements"] firstObject];
    self.lunchChecklist =   [[self.programSupplementsResults valueForKey:@"lunchSupplements"] firstObject];
    self.dinnerChecklist = [[self.programSupplementsResults valueForKey:@"dinnerSupplements"] firstObject];
    self.eveningChecklist =  [[self.programSupplementsResults valueForKey:@"eveningSupplements"] firstObject];
    //TODO HADIIIII
    
    
//    if ([mealSelected isEqualToString:@"Breakfast"]) {
//        self.partOfDay =  @"fitapp-supplements-breakfast";
//    } else if ([mealSelected isEqualToString:@"Snack"]) {
//        self.partOfDay =   @"fitapp-supplements-snack";
//    }else if ([mealSelected isEqualToString:@"Lunch"]) {
//        self.partOfDay =   @"fitapp-supplements-lunch";
//    }else if ([mealSelected isEqualToString:@"Dinner"]) {
//        self.partOfDay =   @"fitapp-supplements-dinner";
//    } else {
//        self.partOfDay =   @"fitapp-supplements-evening";
//    }
    
    
    
    
    self.supplementsCount = [Supplements objectsWhere:[NSString stringWithFormat:@"day = '%d' && partOfDay = 'fitapp-supplements-breakfast' && programID = '%@' && isChecked = 1",self.day, self.currentCourse.userProgramId]];
    DLog(@"Result Object Hadi::::: %@",self.supplementsCount);
    
    
    if([self.supplementsCount count] > 0) {
        _checkedCount = (int)[_supplementsCount count];
    } else {
        _checkedCount = 0;
    }
    
    int countDistance = 0;
    
    //BREAKFAST LABELS DISPLAY LOOP
    for (int i = 0; i < self.breakfastChecklist.count; ++i) {
        if (i == 0){
            //Label Creation
            UILabel *header = [[UILabel alloc] init];
            header.translatesAutoresizingMaskIntoConstraints = NO;
            header.textColor = [self programColor];
            header.font = [UIFont fontWithName:@"SanFranciscoText-Bold" size:19];
            header.backgroundColor = [UIColor clearColor];
            header.numberOfLines = 0;
            header.text = @"Breakfast";
            [self.scrollViewContainer addSubview:header];
            
            [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[header]-(10)-|" options:0 metrics:nil views:@{@"header":header}]];
            
            [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[header]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:26]} views:@{@"header":header}]];
        }
        
        UILabel *label = [[UILabel alloc] init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.textColor = [UIColor colorWithRed:(74.0/255.0) green:(74.0/255.0) blue:(74.0/255.0) alpha:1];
        label.font = [UIFont fontWithName:@"SanFranciscoText-Bold" size:14];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        label.text = self.breakfastChecklist[i][@"name"];
        label.adjustsFontSizeToFitWidth=YES;
        label.minimumScaleFactor=0.5;
        
        UIImageView *hexOpen = [[UIImageView  alloc] init];
        if (i < _checkedCount) {
            [self programImageUpdate:hexOpen withImageName:@"hexagonon"];
        } else if ([[self.breakfastChecklist[i][@"components"] valueForKey:@"interval"] boolValue]) {
            [self programImageUpdate:hexOpen withImageName:@"waitthirtyminutesicon"];
        } else {
            [self programImageUpdate:hexOpen withImageName:@"hexagonoff"];
        }
        hexOpen.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.scrollViewContainer addSubview:hexOpen];
        [self.scrollViewContainer addSubview:label];
        [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[hexOpen]-(12)-[label]-(10)-|" options:0 metrics:nil views:@{@"hexOpen": hexOpen, @"label":label}]];
        [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[label]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:(55 + (i * 40))]} views:@{@"label":label}]];
        [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[hexOpen]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:(47 + (i * 40))]} views:@{@"hexOpen":hexOpen}]];
    }
    
    
    
    self.supplementsCount = [Supplements objectsWhere:[NSString stringWithFormat:@"day = '%d' && partOfDay = 'fitapp-supplements-snack' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
    DLog(@"Result Object Hadi::::: %@",self.supplementsCount);
    
    if([self.supplementsCount count] > 0) {
        _checkedCount = (int)[_supplementsCount count];
    } else {
        _checkedCount = 0;
    }
    // SNACK LABELS DISPLAY LOOP
    countDistance += self.breakfastChecklist.count;
    
    for (int i = 0; i < self.snackChecklist.count; ++i) {
        if (i == 0){
            //Label Creation
            UILabel *header = [[UILabel alloc] init]; // Initialitze the UILabel
            header.translatesAutoresizingMaskIntoConstraints = NO;
            header.textColor = [self programColor];
            header.font = [UIFont fontWithName:@"SanFranciscoText-Bold" size:19];
            header.backgroundColor = [UIColor clearColor];
            header.numberOfLines = 0;
            header.text = @"Snack";
            [self.scrollViewContainer addSubview:header];
            
            [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[header]-(10)-|" options:0 metrics:nil views:@{@"header":header}]];
            
            [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[header]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:((countDistance * 50) + 26)]} views:@{@"header":header}]];
        }
        UILabel *label = [[UILabel alloc] init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.textColor = [UIColor colorWithRed:(74.0/255.0) green:(74.0/255.0) blue:(74.0/255.0) alpha:1];
        label.font = [UIFont fontWithName:@"SanFranciscoText-Bold" size:14];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        label.text = self.snackChecklist[i][@"name"];
        label.adjustsFontSizeToFitWidth=YES;
        label.minimumScaleFactor=0.5;
        
        UIImageView *hexOpen = [[UIImageView  alloc] init];
        if (i < _checkedCount) {
            [self programImageUpdate:hexOpen withImageName:@"hexagonon"];
        } else if ([[self.snackChecklist[i][@"components"] valueForKey:@"interval"] boolValue]) {
            [self programImageUpdate:hexOpen withImageName:@"waitthirtyminutesicon"];
        } else {
            [self programImageUpdate:hexOpen withImageName:@"hexagonoff"];
        }
        hexOpen.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.scrollViewContainer addSubview:hexOpen];
        [self.scrollViewContainer addSubview:label];
        [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[hexOpen]-(12)-[label]-(10)-|" options:0 metrics:nil views:@{@"hexOpen": hexOpen, @"label":label}]];
        [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[label]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:((countDistance * 50) + 50 + (i * 40))]} views:@{@"label":label}]];
        [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[hexOpen]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:((countDistance * 50) + 45 + (i * 40))]} views:@{@"hexOpen":hexOpen}]];
    }
    countDistance += self.snackChecklist.count;
    
    
    
    self.supplementsCount = [Supplements objectsWhere:[NSString stringWithFormat:@"day = '%d' && partOfDay = 'fitapp-supplements-lunch' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
    DLog(@"Result Object Hadi::::: %@",self.supplementsCount);
    
    if([self.supplementsCount count] > 0) {
        _checkedCount = (int)[_supplementsCount count];
    } else {
        _checkedCount = 0;
    }
    // LUNCH LABELS DISPLAY LOOP
    for (int i = 0; i < self.lunchChecklist.count; ++i) {
        if (i == 0){
            //Label Creation
            UILabel *header = [[UILabel alloc] init];
            header.translatesAutoresizingMaskIntoConstraints = NO;
            header.textColor = [self programColor];
            header.font = [UIFont fontWithName:@"SanFranciscoText-Bold" size:19];
            header.backgroundColor = [UIColor clearColor];
            header.numberOfLines = 0;
            header.text = @"Lunch"; // big test to test
            [self.scrollViewContainer addSubview:header];
            
            [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[header]-(10)-|" options:0 metrics:nil views:@{@"header":header}]];
            
            [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[header]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:((countDistance * 50) + 40)]} views:@{@"header":header}]];
        }
        UILabel *label = [[UILabel alloc] init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.textColor = [UIColor colorWithRed:(74.0/255.0) green:(74.0/255.0) blue:(74.0/255.0) alpha:1];
        label.font = [UIFont fontWithName:@"SanFranciscoText-Bold" size:14];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        label.text = self.lunchChecklist[i][@"name"];
        label.adjustsFontSizeToFitWidth=YES;
        label.minimumScaleFactor=0.5;
        
        UIImageView *hexOpen = [[UIImageView  alloc] init];
        if (i < _checkedCount) {
            [self programImageUpdate:hexOpen withImageName:@"hexagonon"];
        } else if ([[self.lunchChecklist[i][@"components"] valueForKey:@"interval"] boolValue]) {
            [self programImageUpdate:hexOpen withImageName:@"waitthirtyminutesicon"];
        } else {
            [self programImageUpdate:hexOpen withImageName:@"hexagonoff"];
        }
        hexOpen.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.scrollViewContainer addSubview:hexOpen];
        [self.scrollViewContainer addSubview:label];
        [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[hexOpen]-(12)-[label]-(10)-|" options:0 metrics:nil views:@{@"hexOpen": hexOpen, @"label":label}]];
        [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[label]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:((countDistance * 50) + 67 + (i * 40))]} views:@{@"label":label}]];
        [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[hexOpen]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:((countDistance * 50) + 58 + (i * 40))]} views:@{@"hexOpen":hexOpen}]];
    }
    countDistance += self.lunchChecklist.count;
    
    
    
    
    
    self.supplementsCount = [Supplements objectsWhere:[NSString stringWithFormat:@"day = '%d' && partOfDay = 'fitapp-supplements-dinner' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
    DLog(@"Result Object Hadi::::: %@",self.supplementsCount);
    
    if([self.supplementsCount count] > 0) {
        _checkedCount = (int)[_supplementsCount count];
    } else {
        _checkedCount = 0;
    }
    // DINNER LABELS DISPLAY LOOP
    for (int i = 0; i < self.dinnerChecklist.count; ++i) {
        if (i == 0){
            //Label Creation
            UILabel *header = [[UILabel alloc] init];
            header.translatesAutoresizingMaskIntoConstraints = NO;
            header.textColor = [self programColor];
            header.font = [UIFont fontWithName:@"SanFranciscoText-Bold" size:19];
            header.backgroundColor = [UIColor clearColor];
            header.numberOfLines = 0;
            header.text = @"Dinner";
            [self.scrollViewContainer addSubview:header];
            
            [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[header]-(10)-|" options:0 metrics:nil views:@{@"header":header}]];
            
            [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[header]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:((countDistance * 50) + 40)]} views:@{@"header":header}]];
        }
        UILabel *label = [[UILabel alloc] init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.textColor = [UIColor colorWithRed:(74.0/255.0) green:(74.0/255.0) blue:(74.0/255.0) alpha:1];
        label.font = [UIFont fontWithName:@"SanFranciscoText-Bold" size:14];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        label.text = self.dinnerChecklist[i][@"name"];
        label.adjustsFontSizeToFitWidth=YES;
        label.minimumScaleFactor=0.5;
        
        UIImageView *hexOpen = [[UIImageView  alloc] init];
        if (i < _checkedCount) {
            [self programImageUpdate:hexOpen withImageName:@"hexagonon"];
        } else if ([[self.breakfastChecklist[i][@"components"] valueForKey:@"interval"] boolValue]) {
            [self programImageUpdate:hexOpen withImageName:@"waitthirtyminutesicon"];
        } else {
            [self programImageUpdate:hexOpen withImageName:@"hexagonoff"];
        }
        hexOpen.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.scrollViewContainer addSubview:hexOpen];
        [self.scrollViewContainer addSubview:label];
        [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[hexOpen]-(12)-[label]-(10)-|" options:0 metrics:nil views:@{@"hexOpen": hexOpen, @"label":label}]];
        [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[label]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:((countDistance * 50) + 67 + (i * 40))]} views:@{@"label":label}]];
        [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[hexOpen]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:((countDistance * 50) + 58 + (i * 40))]} views:@{@"hexOpen":hexOpen}]];
    }
    countDistance += self.dinnerChecklist.count;
    
    
    if (self.day < 3) {
        self.supplementsCount = [Supplements objectsWhere:[NSString stringWithFormat:@"day = '%d' && partOfDay = 'fitapp-supplements-evening' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
        DLog(@"Result Object Hadi::::: %@",self.supplementsCount);
        
        if([self.supplementsCount count] > 0) {
            _checkedCount = (int)[_supplementsCount count];
        } else {
            _checkedCount = 0;
        }
        // EVENING LABELS DISPLAY LOOP
        for (int i = 0; i < self.eveningChecklist.count; ++i) {
            if (i == 0){
                //Label Creation
                UILabel *header = [[UILabel alloc] init];
                header.translatesAutoresizingMaskIntoConstraints = NO;
                header.textColor = [self programColor];
                header.font = [UIFont fontWithName:@"SanFranciscoText-Bold" size:19];
                header.backgroundColor = [UIColor clearColor];
                header.numberOfLines = 0;
                header.text = @"Evening";
                [self.scrollViewContainer addSubview:header];
                
                [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[header]-(10)-|" options:0 metrics:nil views:@{@"header":header}]];
                
                [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[header]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:((countDistance * 50) + 30)]} views:@{@"header":header}]];
            }
            UILabel *label = [[UILabel alloc] init];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            label.textColor = [UIColor colorWithRed:(74.0/255.0) green:(74.0/255.0) blue:(74.0/255.0) alpha:1];
            label.font = [UIFont fontWithName:@"SanFranciscoText-Bold" size:14];
            label.backgroundColor = [UIColor clearColor];
            label.numberOfLines = 0;
            label.text = self.eveningChecklist[i][@"name"];
            label.adjustsFontSizeToFitWidth=YES;
            label.minimumScaleFactor=0.5;
            
            UIImageView *hexOpen = [[UIImageView  alloc] init];
            if (i < _checkedCount) {
                [self programImageUpdate:hexOpen withImageName:@"hexagonon"];
            } else if ([[self.breakfastChecklist[i][@"components"] valueForKey:@"interval"] boolValue]) {
                [self programImageUpdate:hexOpen withImageName:@"waitthirtyminutesicon"];
            } else {
                [self programImageUpdate:hexOpen withImageName:@"hexagonoff"];
            }
            hexOpen.translatesAutoresizingMaskIntoConstraints = NO;
            
            [self.scrollViewContainer addSubview:hexOpen];
            [self.scrollViewContainer addSubview:label];
            [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[hexOpen]-(12)-[label]-(10)-|" options:0 metrics:nil views:@{@"hexOpen": hexOpen, @"label":label}]];
            [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[label]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:((countDistance * 50) + 57 + (i * 40))]} views:@{@"label":label}]];
            [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[hexOpen]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:((countDistance * 50) + 48 + (i * 40))]} views:@{@"hexOpen":hexOpen}]];
        }
        
        
        countDistance += self.eveningChecklist.count;
    }
    
    
    self.waterCount = [Water objectsWhere:[NSString stringWithFormat:@"day = '%d' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
    DLog(@"Result Object Hadi::::: %@",self.waterCount);
    
    if([self.waterCount count] > 0) {
        _waterCheckedCount = [[self.waterCount firstObject][@"count"] intValue];
    } else {
        _waterCheckedCount = 0;
    }
    
    
    
    
    //Label Creation
    UILabel *header = [[UILabel alloc] init];
    header.translatesAutoresizingMaskIntoConstraints = NO;
    header.textColor = [self programColor];
    header.font = [UIFont fontWithName:@"SanFranciscoText-Bold" size:19];
    header.backgroundColor = [UIColor clearColor];
    header.numberOfLines = 0;
    header.text = @"8 Glasses of water";
    [self.scrollViewContainer addSubview:header];
    
    [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[header]-(10)-|" options:0 metrics:nil views:@{@"header":header}]];
    
    [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[header]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:((countDistance * 50) + 40)]} views:@{@"header":header}]];
    
    
    
    UIImageView *hexOpen = [[UIImageView  alloc] init];
    if (_waterCheckedCount == 8) {
        [self programImageUpdate:hexOpen withImageName:@"hexagonon"];
    } else {
        [self programImageUpdate:hexOpen withImageName:@"hexagonoff"];
    }
    hexOpen.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    // WATER LABELS DISPLAY LOOP
    for (int i = 0; i <= 7 ; ++i) {
        
        
        UIImageView *waterGlassImage;
        
        if(i < _waterCheckedCount) {
            waterGlassImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"glassfull"]];
        } else {
            waterGlassImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"glassempty"]];
        }
        
        waterGlassImage.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        [self.scrollViewContainer addSubview:hexOpen];
        [self.scrollViewContainer addSubview:waterGlassImage];
        [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[hexOpen]-(padding)-[label]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:(i * 20) + 15]} views:@{@"hexOpen": hexOpen, @"label":waterGlassImage}]];
        
        [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[label]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:((countDistance * 50) + 67)]} views:@{@"label":waterGlassImage}]];
        [self.scrollViewContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(padding)-[hexOpen]" options:0 metrics:@{@"padding":[NSNumber numberWithInt:((countDistance * 50) + 58)]} views:@{@"hexOpen":hexOpen}]];
    }
    
    
    
    _scrollViewContainerHeight.constant = countDistance * 65;
    [self.scrollViewContainer layoutIfNeeded];
    
}

@end
