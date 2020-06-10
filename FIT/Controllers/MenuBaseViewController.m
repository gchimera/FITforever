//
//  MenuBaseViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 16/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MenuBaseViewController.h"

@interface MenuBaseViewController ()

@end

@implementation MenuBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUIData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadUIData {
    
    // Do any additional setup after loading the view.
    self.navigationMenu = (FITBurgerMenu *)self.navigationController;
    [self.navigationMenu setFITNavDrawerDelegate:self];

    RLMResults *currentProgram = [UserCourse objectsWhere:@"status = %d",1];
    
    if([currentProgram count] > 0){
        self.currentCourseBM = [[UserCourse alloc] init];
        self.currentCourseBM = [currentProgram objectAtIndex:0];
    }

    [self.navigationController.navigationBar setBarTintColor:[THM BMColor]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadUIData];
}

#pragma mark - burger Menu delegate
-(void)FITNavDrawerSelection:(NSInteger)selectionIndex
{
    NSLog(@"FITNavDrawerSelection = %li", (long)selectionIndex);
}

- (IBAction)drawerToggle:(id)sender {
    [self.navigationMenu drawerToggle];
}


@end
