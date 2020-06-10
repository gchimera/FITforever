//
//  RecipesMenuViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 20/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "RecipesMenuViewController.h"

@interface RecipesMenuViewController ()

@end

@implementation RecipesMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(IBAction) setBtnC9Click:(id)btnC9
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    UIViewController *controllerMenuDestination;
    controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_RECIPES_LIST_DETAIL];
    
    [(RecipesMenuViewDetailController*) controllerMenuDestination setSectionName:@"C9"] ;
    [[self navigationController] pushViewController:controllerMenuDestination animated:YES];
    
    
}
-(IBAction) setBtnF15B1Click:(id)btnF15B1Click
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    UIViewController *controllerMenuDestination;
    controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_RECIPES_LIST_DETAIL];
    
    [(RecipesMenuViewDetailController*) controllerMenuDestination setSectionName:@"F15Beginner1"] ;
    
    
    [[self navigationController] pushViewController:controllerMenuDestination animated:YES];
}
-(IBAction) setBtnF15B2Click:(id)btnF15B2Click
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    UIViewController *controllerMenuDestination;
    controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_RECIPES_LIST_DETAIL];
    
    [(RecipesMenuViewDetailController*) controllerMenuDestination setSectionName:@"F15Beginner2"] ;
    [[self navigationController] pushViewController:controllerMenuDestination animated:YES];
    
    
}
-(IBAction) setBtnF15I1Click:(id)btnF15I1Click
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    UIViewController *controllerMenuDestination;
    controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_RECIPES_LIST_DETAIL];
    
    [(RecipesMenuViewDetailController*) controllerMenuDestination setSectionName:@"F15Intermediate1"] ;
    [[self navigationController] pushViewController:controllerMenuDestination animated:YES];
    
}
-(IBAction) setBtnF15I2Click:(id)btnF15I2Click{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    UIViewController *controllerMenuDestination;
    controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_RECIPES_LIST_DETAIL];
    
    [(RecipesMenuViewDetailController*) controllerMenuDestination setSectionName:@"F15Intermediate2"] ;
    [[self navigationController] pushViewController:controllerMenuDestination animated:YES];
    
}
-(IBAction) setBtnF15A1Click:(id)btnF15A1Click{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    UIViewController *controllerMenuDestination;
    controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_RECIPES_LIST_DETAIL];
    
    [(RecipesMenuViewDetailController*) controllerMenuDestination setSectionName:@"F15Advanced1"] ;
    [[self navigationController] pushViewController:controllerMenuDestination animated:YES];
}
-(IBAction) setBtnF15A2Click:(id)btnF15A2Click{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    UIViewController *controllerMenuDestination;
    controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_RECIPES_LIST_DETAIL];
    
    [(RecipesMenuViewDetailController*) controllerMenuDestination setSectionName:@"F15Advanced2"] ;
    
    [[self navigationController] pushViewController:controllerMenuDestination animated:YES];
    
    
}


@end
