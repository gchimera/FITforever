//
//  AwardsViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "AwardsViewController.h"
#import "AwardsTableViewCell.h"
#import "Supplements.h"
#import "FITAwardCompleted.h"
#import "Exercise.h"
#import "Water.h"
#import "FITAwardsItemVC.h"

@interface AwardsViewController ()

@end

@implementation AwardsViewController
RLMResults *awardsList;
RLMResults *achieveList;
NSMutableArray* achievedDetail;



- (void)viewDidLoad {
    [super viewDidLoad];

    _selCell = [[NSMutableArray alloc]init];
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    DLog(@"%ld",(long)self.day);
    
    
    DLog(@"%@",self.currentCourse.programName);
    
    awardsList = [FITAwards objectsWhere:[NSString stringWithFormat:@"programName = '%@'", [self checkProgram:self.currentCourse.programName]]];
    
    achieveList = [FITAwardCompleted objectsWhere:[NSString stringWithFormat:@"programID = '%@'", self.currentCourse.userProgramId]];
    
    DLog(@"%@",awardsList);
    
    achievedDetail = [[NSMutableArray alloc]init];
    

    // Check exercises awards
//        NSInteger day = [components day];
//        NSInteger week = [components month];
//        NSInteger year = [components year];
//        NSString *stringDate = [NSString stringWithFormat:@"%ld.%ld.%ld", (long)day, (long)week, (long)year];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self programImageUpdate:self.topShape withImageName:@"topshapes"];
}


#pragma LOADING AWARDS TABLE CONTENT

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return awardsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   AwardsTableViewCell *cell = (AwardsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"awardCell"];
    
    cell.awardTitle.text = [[awardsList valueForKey:@"name"]objectAtIndex:indexPath.row];

    @try {
        [cell.awardImage setImage:[UIImage imageNamed:[[awardsList valueForKey:@"icon"]objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    
    
    RLMResults* hh=  [achieveList objectsWhere: [NSString stringWithFormat:@"awardID = '%@' AND day = '%d'",[[awardsList valueForKey:@"awrdsId"]objectAtIndex:indexPath.row], self.day]];
    
    if(hh.count!=0)
    {
            
            [self checkAwardAchived:tableView cell:cell achieved:YES];
            
            cell.awardDesc.text = [[awardsList valueForKey:@"awardAchievedMessage"]objectAtIndex:indexPath.row];
        
        [achievedDetail addObject:[[awardsList valueForKey:@"awrdsId"]objectAtIndex:indexPath.row]];
        
        }
        else
        {
            [self checkAwardAchived:tableView cell:cell achieved:NO];
            
           cell.awardDesc.text = [[awardsList valueForKey:@"instructionsForAchieving"]objectAtIndex:indexPath.row];

            [achievedDetail addObject:@"NO"];

        }


 
    
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"INDEX NUM: %ld",(long)indexPath.row);
    
        //    AwardsTableViewCell *selectedCell =[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row  inSection:0]];

    AwardsTableViewCell *selectedCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row  inSection:0]];
    
        DLog(@"%@", selectedCell.awardTitle.text);
    
    
    
  //  if Achieved...
    
    if (![[achievedDetail objectAtIndex:indexPath.row] isEqualToString:@"NO"])
    {
        RLMResults* dateAchieved = [FITAwardCompleted objectsWhere:[NSString stringWithFormat:@"awardID = '%@'",[achievedDetail objectAtIndex:indexPath.row]]];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:PROGRAM_STORYBOARD bundle:nil];
        
        FITAwardsItemVC *itemVC = (FITAwardsItemVC *)[storyboard instantiateViewControllerWithIdentifier:@"selectedAwards"];
        NSDictionary *awardDetails = @{
                                       
                                       @"image": [awardsList objectAtIndex:indexPath.row][@"icon"],
                                       @"title": [awardsList objectAtIndex:indexPath.row][@"title"],
                                       @"subtitle":[NSString stringWithFormat:@"WON on %@",[[dateAchieved valueForKey:@"dateAchieved"]firstObject]],
                                       @"message": [awardsList objectAtIndex:indexPath.row][@"awardAchievedMessage"],
                                       @"date" : [NSDate date],
                                       };
        
        itemVC.awardDetails = awardDetails;
        
        [self.navigationController pushViewController:itemVC animated:YES];
        
    }else{
        
        //  if NOT Achieved...

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:PROGRAM_STORYBOARD bundle:nil];
        
        FITAwardsItemVC *itemVC = (FITAwardsItemVC *)[storyboard instantiateViewControllerWithIdentifier:@"notselectedAwards"];
        
        
        NSDictionary *awardDetails = @{
                                       
                                       @"image": [awardsList objectAtIndex:indexPath.row][@"icon"],
                                       @"title": [awardsList objectAtIndex:indexPath.row][@"title"],
                                       @"subtitle":[NSString stringWithFormat:@"Not yet acheived"] ,
                                       @"message":[awardsList objectAtIndex:indexPath.row][@"instructionsForAchieving"],
                                       @"date" : [NSDate date],
                                       };
        
        itemVC.awardDetails = awardDetails;
        [self.navigationController pushViewController:itemVC animated:YES];
    }

    
    
}


-(AwardsTableViewCell*)checkAwardAchived:(UITableView *)tableView cell:(AwardsTableViewCell*)cell achieved:(BOOL)checked
{

    
    if (checked)
    {
        
        [self programButtonUpdate:cell.awardImage buttonMode:1 inSection:@"" forKey:@""];
        
    }else{
        

        [self programButtonUpdateNotAchived: cell.awardImage buttonMode:1 inSection:@"" forKey:@""];
 
    }
    
    return cell;
}


- (BOOL)isEndDateIsSmallerThanCurrent:(NSDate *)checkEndDate
{
    bool check = NO;
    
    NSDate *now =  [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger comps = (NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear);
    
    NSDateComponents *date1Components = [calendar components:comps
                                                    fromDate: now];
    
    NSDateComponents *date2Components = [calendar components:comps
                                                    fromDate: checkEndDate];
    
    now = [calendar dateFromComponents:date1Components];
    checkEndDate = [calendar dateFromComponents:date2Components];
    
    NSComparisonResult result = [now compare:checkEndDate];
    if (result == NSOrderedAscending)
    {
        DLog(@"");
        check = NO;


    } else if (result == NSOrderedDescending)
    {
        DLog(@"");
        check = NO;


    }
    else
    {
        DLog(@"Ok");
        check = YES;
    }
    
    return check;
}


-(NSString*)checkProgram:(NSString*)fixProgram
{
    if ([fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED1] || [fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED2])
    {
        fixProgram = @"F15 Advanced";
        
        
    }
    else if ([fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE2] || [fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE2])
    {
        fixProgram = @"F15 Intermediate";
    }
    else if
        
        ([fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER1] || [fixProgram isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER2])
    {
        fixProgram = @"F15 Beginner";
    }
    else
    {
        fixProgram = @"C9";
    }
    
    return fixProgram;
}
@end
