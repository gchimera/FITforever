//
//  ExerisesMenuViewDetailController.m
//  FIT
//
//  Created by Bruce Cresanta on 3/24/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "RecipesMenuViewDetailController.h"
#import "RecipeCell.h"
#import "recipeDetail.h"

@interface RecipesMenuViewDetailController ()

@end
@implementation RecipesMenuViewDetailController
@synthesize sectionName;
@synthesize table;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", sectionName);
    if([sectionName isEqualToString:@"C9"]){
    recipeResult = [FITRecipes objectsWhere:@"programF15Beginner1 = 0 AND programF15Beginner2 = 0 AND programF15Intermediate1 = 0 AND programF15Intermediate2 = 0 AND programF15Advanced1 = 0 AND programF15Advanced2 = 0 "];
    } else {
        NSLog(@"%@",[FITRecipes objectsWhere:[NSString stringWithFormat:@"program%@ = 1",sectionName]]);
        recipeResult = [FITRecipes objectsWhere:[NSString stringWithFormat:@"program%@ = 1",sectionName]];
    }

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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [recipeResult count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecipeCell *cell = (RecipeCell*)[tableView dequeueReusableCellWithIdentifier:@"recipeCell"];
    
    NSLog(@"%@",[[recipeResult valueForKey:@"recipeName"]objectAtIndex:indexPath.row]);
    
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.recipeLB.text = [NSString stringWithFormat:@"%@",[[recipeResult valueForKey:@"title"]objectAtIndex:indexPath.row]];

    
    cell.unitLB.text = [NSString stringWithFormat:@"%@ cal",[[recipeResult valueForKey:@"estimatedCalories"]objectAtIndex:indexPath.row]];
    
    if ([cell.unitLB.text isEqual:nil]) {
        cell.unitLB.text = @" ";
    }
    
    cell.viewBT.tag = indexPath.row;
    
    
    return  cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 41.0;
}


-(IBAction)showDetail:(id)sender{
    
    NSLog(@"%ld", (long)[sender tag]);
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    
   recipeDetail *dealVC = (recipeDetail *)[storyboard instantiateViewControllerWithIdentifier:@"recipeDetail"];
   
    FITRecipes *recipe = [recipeResult objectAtIndex:(long)[sender tag]];
    dealVC.imglink = recipe.thumbnailImage;
    dealVC.descRecipe = recipe.desc;
    dealVC.nameRecipe = recipe.recipeName;
    dealVC.calories = recipe.estimatedCalories;
    dealVC.ingredients = recipe.ingredients;
    

    
    [self.navigationController pushViewController:dealVC animated:YES];
}

@end
