//
//  FreeFoodViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "FreeFoodViewController.h"
#import "FreeFoodTableViewCell.h"

@interface FreeFoodViewController ()
@property long countTable;
@property RLMResults *query;
@property (weak, nonatomic) IBOutlet UITableView *foodTable;

@end

@implementation FreeFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self languageAndButtonUIUpdate:self.freeFoodsBtn buttonMode:1 inSection:CONTENT_FIT_C9_FREE_FOODS_SECTION forKey:CONTENT_BUTTON_FREE_FOODS backgroundColor:[THM C9Color]];
    [self languageAndButtonUIUpdate:self.oneServingBtn buttonMode:1 inSection:CONTENT_FIT_C9_FREE_FOODS_SECTION forKey:CONTENT_BUTTON_ONE_SERVING_FOODS backgroundColor:[THM C9Color]];
    [self languageAndButtonUIUpdate:self.twoServingBtn buttonMode:1 inSection:CONTENT_FIT_C9_FREE_FOODS_SECTION forKey:CONTENT_BUTTON_TWO_SERVING_FOODS backgroundColor:[THM C9Color]];
    
    [self loadDataOne:self.freeFoodsBtn];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _countTable;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idcell = @"ccell";
    
    
    FreeFoodTableViewCell *ccell = [tableView dequeueReusableCellWithIdentifier:idcell];
    
    
    if(indexPath.row % 2 == 0){
        
        ccell.fruitLB.text = [[_query valueForKey:@"name"]objectAtIndex:indexPath.row];
        
        @try {
            
            ccell.sizeLB.text = [[_query valueForKey:@"size"]objectAtIndex:indexPath.row];
            
        } @catch (NSException *exception) {
            
            ccell.sizeLB.text = @"";
            
        }
        
        
        ccell.backgroundColor = [UIColor whiteColor];
        
        return ccell;
    }
    
    else
    {
        ccell.fruitLB.text = [[_query valueForKey:@"name"]objectAtIndex:indexPath.row];
        
        @try {
            ccell.sizeLB.text = [[_query valueForKey:@"size"]objectAtIndex:indexPath.row];
            
            
        } @catch (NSException *exception) {
            
            ccell.sizeLB.text = @"";
        }
        
        ccell.backgroundColor = [UIColor colorWithRed:220/255.0 green:210/255.0 blue:227/255.0 alpha:1];
        
        
        return ccell;
    }
    
    return nil;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33.33;
}




-(IBAction)loadDataOne:(id)sender{
    
    
    if (sender == self.oneServingBtn) {
        
        [self languageAndButtonUIUpdate:self.freeFoodsBtn buttonMode:1 inSection:CONTENT_FIT_C9_FREE_FOODS_SECTION forKey:CONTENT_BUTTON_FREE_FOODS backgroundColor:[THM C9Color]];
        [self languageAndButtonUIUpdate:self.oneServingBtn buttonMode:1 inSection:CONTENT_FIT_C9_FREE_FOODS_SECTION forKey:CONTENT_BUTTON_ONE_SERVING_FOODS backgroundColor:[THM C9ColorFreeFoodSelected]];
        [self languageAndButtonUIUpdate:self.twoServingBtn buttonMode:1 inSection:CONTENT_FIT_C9_FREE_FOODS_SECTION forKey:CONTENT_BUTTON_TWO_SERVING_FOODS backgroundColor:[THM C9Color]];
        
        _query = [FITFreeFood objectsWhere:@"type = 'fitapp-one-serving-foods'"];
        
        _countTable = [_query count];
        
        self.categoryDescriptionLbl.attributedText = [self localisedAttributedStringHTMLForSection:CONTENT_FIT_C9_FREE_FOODS_SECTION andKey:CONTENT_ONE_SERVING_FOODS_DESCRIPTION];
        self.categoryDescriptionLbl.textAlignment = NSTextAlignmentCenter;
        self.categoryDescriptionLbl.textColor = [UIColor colorWithRed:(92.0/255.0) green:(38.0/255.0) blue:(132.0/255.0) alpha:1];
        self.categoryDescriptionLbl.numberOfLines = 2;
    }
    else if (sender == self.twoServingBtn)
    {
        
        [self languageAndButtonUIUpdate:self.freeFoodsBtn buttonMode:1 inSection:CONTENT_FIT_C9_FREE_FOODS_SECTION forKey:CONTENT_BUTTON_FREE_FOODS backgroundColor:[THM C9Color]];
        [self languageAndButtonUIUpdate:self.oneServingBtn buttonMode:1 inSection:CONTENT_FIT_C9_FREE_FOODS_SECTION forKey:CONTENT_BUTTON_ONE_SERVING_FOODS backgroundColor:[THM C9Color]];
        [self languageAndButtonUIUpdate:self.twoServingBtn buttonMode:1 inSection:CONTENT_FIT_C9_FREE_FOODS_SECTION forKey:CONTENT_BUTTON_TWO_SERVING_FOODS backgroundColor:[THM C9ColorFreeFoodSelected]];
        _query = [FITFreeFood objectsWhere:[NSString stringWithFormat:@"type = 'fitapp-two-serving-foods'"]];
        
        _countTable = [_query count];
        
        self.categoryDescriptionLbl.attributedText = [self localisedAttributedStringHTMLForSection:CONTENT_FIT_C9_FREE_FOODS_SECTION andKey:CONTENT_TWO_SERVING_FOODS_DESCRIPTION];
        self.categoryDescriptionLbl.textAlignment = NSTextAlignmentCenter;
        self.categoryDescriptionLbl.textColor = [UIColor colorWithRed:(92.0/255.0) green:(38.0/255.0) blue:(132.0/255.0) alpha:1];
        self.categoryDescriptionLbl.numberOfLines = 2;
    }
    else if (sender == self.freeFoodsBtn)
    {
        
        [self languageAndButtonUIUpdate:self.freeFoodsBtn buttonMode:1 inSection:CONTENT_FIT_C9_FREE_FOODS_SECTION forKey:CONTENT_BUTTON_FREE_FOODS backgroundColor:[THM C9ColorFreeFoodSelected]];
        [self languageAndButtonUIUpdate:self.oneServingBtn buttonMode:1 inSection:CONTENT_FIT_C9_FREE_FOODS_SECTION forKey:CONTENT_BUTTON_ONE_SERVING_FOODS backgroundColor:[THM C9Color]];
        [self languageAndButtonUIUpdate:self.twoServingBtn buttonMode:1 inSection:CONTENT_FIT_C9_FREE_FOODS_SECTION forKey:CONTENT_BUTTON_TWO_SERVING_FOODS backgroundColor:[THM C9Color]];
        
        _query = [FITFreeFood objectsWhere:[NSString stringWithFormat:@"type = 'fitapp-free-foods'"]];
        
        _countTable = [_query count];
        
        self.categoryDescriptionLbl.attributedText = [self localisedAttributedStringHTMLForSection:CONTENT_FIT_C9_FREE_FOODS_SECTION andKey:CONTENT_FREE_FOODS_DESCRIPTION];
        self.categoryDescriptionLbl.textAlignment = NSTextAlignmentCenter;
        self.categoryDescriptionLbl.textColor = [UIColor colorWithRed:(92.0/255.0) green:(38.0/255.0) blue:(132.0/255.0) alpha:1];
        self.categoryDescriptionLbl.numberOfLines = 2;
        
    }
    
    
    [_foodTable reloadData];
    
}

#pragma mark - burger delegate

-(void)FITNavDrawerSelection:(NSInteger)selectionIndex
{
    NSLog(@"FITNavDrawerSelection = %li", (long)selectionIndex);
    //    self.selectionIdx.text = [NSString stringWithFormat:@"%li",(long)selectionIndex];
}

@end
