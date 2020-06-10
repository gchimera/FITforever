//
//  ExercisesMenuViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 20/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ExercisesMenuViewController.h"

@interface ExercisesMenuViewController ()

@end

@implementation ExercisesMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//        
//    
//    
//}


-(IBAction) setBtnC9Click:(id)btnC9
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    ExercisesMenuViewDetailController *controllerMenuDestination;
    controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_EXERCISES_LIST_DETAIL];

    [(ExercisesMenuViewDetailController*)controllerMenuDestination setSectionName:@"C9"];
    
    controllerMenuDestination.stringPassed = @"c9";

    
    [[self navigationController] pushViewController:controllerMenuDestination animated:YES];
 
    
}
-(IBAction) setBtnF15B1Click:(id)btnF15B1Click
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    ExercisesMenuViewDetailController *controllerMenuDestination;
    controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_EXERCISES_LIST_DETAIL];
     [(ExercisesMenuViewDetailController*)controllerMenuDestination setSectionName:@"a1IK000000PfaFQMAZ"];
    
    controllerMenuDestination.stringPassed = @"beginner";

    
    [[self navigationController] pushViewController:controllerMenuDestination animated:YES];
}
-(IBAction) setBtnF15B2Click:(id)btnF15B2Click
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    ExercisesMenuViewDetailController *controllerMenuDestination;
    controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_EXERCISES_LIST_DETAIL];
       [(ExercisesMenuViewDetailController*)controllerMenuDestination setSectionName:@"F15Beginner2"];
    
    controllerMenuDestination.stringPassed = @"beginner";
    
    [[self navigationController] pushViewController:controllerMenuDestination animated:YES];
    
    
}
-(IBAction) setBtnF15I1Click:(id)btnF15I1Click
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    ExercisesMenuViewDetailController *controllerMenuDestination;
    controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_EXERCISES_LIST_DETAIL];
       [(ExercisesMenuViewDetailController*)controllerMenuDestination setSectionName:@"F15Intermediate1"];
    
    controllerMenuDestination.stringPassed = @"intermediate";

    [[self navigationController] pushViewController:controllerMenuDestination animated:YES];
    
}
-(IBAction) setBtnF15I2Click:(id)btnF15I2Click{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    ExercisesMenuViewDetailController *controllerMenuDestination;
    controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_EXERCISES_LIST_DETAIL];
    
          [(ExercisesMenuViewDetailController*)controllerMenuDestination setSectionName:@"F15Intermediate2"];
    
    controllerMenuDestination.stringPassed = @"intermediate";

    [[self navigationController] pushViewController:controllerMenuDestination animated:YES];
    
}
-(IBAction) setBtnF15A1Click:(id)btnF15A1Click{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    ExercisesMenuViewDetailController *controllerMenuDestination;
    controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_EXERCISES_LIST_DETAIL];
    
          [(ExercisesMenuViewDetailController*)controllerMenuDestination setSectionName:@"F15Advanced1"];
    
    controllerMenuDestination.stringPassed = @"advanced";

    [[self navigationController] pushViewController:controllerMenuDestination animated:YES];
}
-(IBAction) setBtnF15A2Click:(id)btnF15A2Click{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    ExercisesMenuViewDetailController *controllerMenuDestination;
    controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_EXERCISES_LIST_DETAIL];
    
          [(ExercisesMenuViewDetailController*)controllerMenuDestination setSectionName:@"F15Advanced2"];
    
    controllerMenuDestination.stringPassed = @"advanced";

    
    [[self navigationController] pushViewController:controllerMenuDestination animated:YES];
    
    
}

@end
