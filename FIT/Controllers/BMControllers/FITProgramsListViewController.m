//
//  FITProgramsListViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 16/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "FITProgramsListViewController.h"
#import "Dashboard.h"

@interface FITProgramsListViewController ()

@end

@implementation FITProgramsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isSwitched = NO;
    
    self.comingColor = [[UIColor alloc] init];
    self.screenWidth = [[UIScreen mainScreen] bounds].size.width;
    self.scrollView.delegate = self;
    [self fetchAllProgramsFromRealm];
    
    self.currentProgramLabel.text = [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS andKey:CONTENT_LABEL_CURRENT_PROGRAMS];
    self.completeProgramLabel.text = [self localisedStringForSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS andKey:CONTENT_LABEL_COMPLETED_PROGRAMS];
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.comingColor = [[[self navigationController] navigationBar] barTintColor];
    
    [self languageAndButtonUIUpdate:self.closeBtn buttonMode:3 inSection:CONTENT_FITAPP_LABELS_PROGRAM_SCREENS forKey:CONTENT_BUTTON_CLOSE backgroundColor:[THM BMColor]];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(!(_isSwitched)) {
        [[[self navigationController] navigationBar] setBarTintColor:self.comingColor];
    }
}

- (IBAction)closeBtnTapped:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)addProgramBtnTapped:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:PROGRAM_STORYBOARD bundle:nil];
    
    Dashboard *setCreateProgram = [storyboard instantiateViewControllerWithIdentifier:MAIN_DASHBOARD];
    setCreateProgram.isCreateNewProgram = YES;
    [[self navigationController] pushViewController:setCreateProgram animated:YES];
    
}

#pragma mark - SCROLLVIEW CONTENT AND DAYS ACTION
#pragma mark - LOOP ON REALM DB TO SHOW LABELS
- (void)fetchAllProgramsFromRealm {
    
    self.programResults  = [UserCourse objectsWhere:[NSString stringWithFormat:@"status <> 3"]];
    float btnWidth = (self.screenWidth / 4);
    for (int i = 0; [_programResults count] > i; i++) {
        NSLog(@"%@",_programResults[i]);
        
        FITButton * btn;
        
        btn = [FITButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont fontWithName:@"SanFranciscoText-Bold" size:40.0];
        [btn setTitle:[NSString stringWithFormat:@"%@", _programResults[i][@"programName"]] forState:UIControlStateNormal];
        btn.frame = CGRectMake((i * btnWidth), 0, btnWidth, btnWidth * 1.2);
        
        NSString *key;
        UIColor *buttonColor = [[UIColor alloc] init];
        if ([_programResults[i][@"programName"] isEqualToString:COURSE_PROGRAM_NAME_C9]) {
            
            [btn setTitle:[NSString stringWithFormat:@"C9"] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor colorWithRed:(92.0/255.0) green:(38.0/255.0) blue:(132.0/255.0) alpha:1]];
            [btn setTag:1];
            key = CONTENT_C9_PROGRAM_NAME;
            buttonColor = [THM C9Color];
        } else if ([_programResults[i][@"programName"] isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER1] || [_programResults[i][@"programName"] isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER2]) {
            
            [btn setTitle:[NSString stringWithFormat:@"F15"] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor colorWithRed:(137.0/255.0) green:(189.0/255.0) blue:(36.0/255.0) alpha:1]];
            [btn setTag:2];
            key = CONTENT_F15_PROGRAM_NAME;
            buttonColor = [THM F15BeginnerColor];
            
        } else if ([_programResults[i][@"programName"] isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE1] || [_programResults[i][@"programName"] isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE2]) {
            
            [btn setTitle:[NSString stringWithFormat:@"F15"] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor colorWithRed:(246.0/255.0) green:(164.0/255.0) blue:(0/255.0) alpha:1]];
            [btn setTag:3];
            key = CONTENT_F15_PROGRAM_NAME;
            buttonColor = [THM F15IntermidiateColor];
            
        } else if ([_programResults[i][@"programName"] isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED1] || [_programResults[i][@"programName"] isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED2]) {
            
            [btn setTitle:[NSString stringWithFormat:@"F15"] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor colorWithRed:(206.0/255.0) green:(54.0/255.0) blue:(47.0/255.0) alpha:1]];
            [btn setTag:4];
            
            key = CONTENT_F15_PROGRAM_NAME;
            buttonColor = [THM F15AdvanceColor];
        }
        
        UserCourse *program = _programResults[i];
        if([program.status integerValue] == STATUS_IN_PROGRESS){
            [self languageAndButtonUIUpdate:btn buttonMode:1 inSection:CONTENT_LEARN_MORE_SECTION forKey:key backgroundColor:buttonColor];
        } else {
            [self languageAndButtonUIUpdate:btn buttonMode:1 inSection:CONTENT_LEARN_MORE_SECTION forKey:key backgroundColor:[THM GreyColor]];
        }
        
        [btn addTarget:self action:@selector(programButtonTappedInScrollview:) forControlEvents:UIControlEventTouchUpInside];
        [btn setAccessibilityIdentifier:[NSString stringWithFormat:@"%@",_programResults[i][@"userProgramId"]]];
        [self.scrollView addSubview:btn];
        
        [self.scrollView setContentSize:CGSizeMake(btnWidth * [_programResults count], btnWidth * 1.2)];
        NSLog(@"%f",self.scrollView.frame.size.height);
    }
    
    
    //Competed
    RLMResults *completeProgram  = [UserCourse objectsWhere:[NSString stringWithFormat:@"status = 3"]];
//    float btnWidth = (self.screenWidth / 4);
    for (int i = 0; [completeProgram count] > i; i++) {
        NSLog(@"%@",completeProgram[i]);
        
        FITButton * btn;
        
        btn = [FITButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont fontWithName:@"SanFranciscoText-Bold" size:40.0];
        [btn setTitle:[NSString stringWithFormat:@"%@", completeProgram[i][@"programName"]] forState:UIControlStateNormal];
        btn.frame = CGRectMake((i * btnWidth), 0, btnWidth, btnWidth * 1.2);
        
        NSString *key;
        UIColor *buttonColor = [[UIColor alloc] init];
        if ([completeProgram[i][@"programName"] isEqualToString:COURSE_PROGRAM_NAME_C9]) {
            
            [btn setTitle:[NSString stringWithFormat:@"C9"] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor colorWithRed:(92.0/255.0) green:(38.0/255.0) blue:(132.0/255.0) alpha:1]];
            [btn setTag:1];
            key = CONTENT_C9_PROGRAM_NAME;
            buttonColor = [THM C9Color];
        } else if ([completeProgram[i][@"programName"] isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER1] || [completeProgram[i][@"programName"] isEqualToString:COURSE_PROGRAM_NAME_F15BEGINNER2]) {
            
            [btn setTitle:[NSString stringWithFormat:@"F15"] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor colorWithRed:(137.0/255.0) green:(189.0/255.0) blue:(36.0/255.0) alpha:1]];
            [btn setTag:2];
            key = CONTENT_F15_PROGRAM_NAME;
            buttonColor = [THM F15BeginnerColor];
            
        } else if ([completeProgram[i][@"programName"] isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE1] || [completeProgram[i][@"programName"] isEqualToString:COURSE_PROGRAM_NAME_F15INTERMEDIATE2]) {
            
            [btn setTitle:[NSString stringWithFormat:@"F15"] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor colorWithRed:(246.0/255.0) green:(164.0/255.0) blue:(0/255.0) alpha:1]];
            [btn setTag:3];
            key = CONTENT_F15_PROGRAM_NAME;
            buttonColor = [THM F15IntermidiateColor];
            
        } else if ([completeProgram[i][@"programName"] isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED1] || [completeProgram[i][@"programName"] isEqualToString:COURSE_PROGRAM_NAME_F15ADVANCED2]) {
            
            [btn setTitle:[NSString stringWithFormat:@"F15"] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor colorWithRed:(206.0/255.0) green:(54.0/255.0) blue:(47.0/255.0) alpha:1]];
            [btn setTag:4];
            
            key = CONTENT_F15_PROGRAM_NAME;
            buttonColor = [THM F15AdvanceColor];
        }
        
        [self languageAndButtonUIUpdate:btn buttonMode:1 inSection:CONTENT_LEARN_MORE_SECTION forKey:key backgroundColor:buttonColor];
        [self.completeScrollView addSubview:btn];
        
        [self.completeScrollView setContentSize:CGSizeMake(btnWidth * [completeProgram count], btnWidth * 1.2)];
        NSLog(@"%f",self.completeScrollView.frame.size.height);
    }
}


//ACTION WHEN USER SELECTS A DAY
-(void) programButtonTappedInScrollview:(UIButton *)sender {
    //    self.day = (int)(sender.tag);
    //    CGFloat newContentOffsetX = (self.scrollView.contentSize.width - self.scrollView.frame.size.width) / 2; // 73 is each button width
    //    [self.scrollView setContentOffset:CGPointMake(-newContentOffsetX + ( ((sender.tag) - 1 ) * (self.screenWidth / 5) ), 0) animated:YES];
    NSLog(@"Button ID ======= %@", [sender accessibilityIdentifier]);
    [self switchCurrentProgram:sender];
    
    UIViewController *destination = [[UIStoryboard storyboardWithName:PROGRAM_STORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:PROGRAM_DASHBOARD];
    _isSwitched = YES;
    
    [self.navigationController pushViewController:destination animated:YES];
}



-(void)switchCurrentProgram:(UIButton *)sender {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    RLMResults *currentProgram = [UserCourse objectsWhere:@"status = %d",1];
    if ([currentProgram count] > 0) {
        NSLog(@"ProgramID === %@",[currentProgram objectAtIndex:0][@"userProgramId"]);
        
        UserCourse *progUpdate = [[UserCourse alloc] init];
        progUpdate = [currentProgram objectAtIndex:0];
        progUpdate.status = @(STATUS_WAITING);
        [realm addOrUpdateObject:progUpdate];
    }
    
    RLMResults *progResult = [UserCourse objectsWhere:[NSString stringWithFormat:@"userProgramId = '%@'",sender.accessibilityIdentifier]];
    UserCourse *pr = [[UserCourse alloc] init];
    pr = [progResult objectAtIndex:0];
    pr.status = @(STATUS_IN_PROGRESS);
    
    [realm addOrUpdateObject:pr];
    [realm commitWriteTransaction];
}

#pragma mark - burger delegate
-(void)FITNavDrawerSelection:(NSInteger)selectionIndex
{
    NSLog(@"FITNavDrawerSelection = %li", (long)selectionIndex);
    //    self.selectionIdx.text = [NSString stringWithFormat:@"%li",(long)selectionIndex];
    
}

@end
