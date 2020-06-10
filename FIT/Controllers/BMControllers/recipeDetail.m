//
//  recipeDetail.m
//  FIT
//
//  Created by Guglielmo Chimera on 03/04/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "recipeDetail.h"
#import "UIImageView+WebCache.h"

@interface recipeDetail ()

@end

@implementation recipeDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if(_imglink.length != 0)
    {
        
        NSURL *url = [NSURL URLWithString:_imglink];
        
        [self.pictureImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.gif"]];
        
    }
    else {
        
        
        NSURL *url = [NSURL URLWithString:[self localisedStringForSection:CONTENT_FITAPP_LABELS_IMAGES_SECTION andKey:CONTENT_RECIPES_PLACEHOLDER]];
        [self.pictureImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.gif"]];
        
    }
    
    [self languageAndButtonUIUpdate:self.doneBtn buttonMode:3 inSection:CONTENT_FITAPP_SETTINGS_SECTION forKey:CONTENT_BUTTON_DONE backgroundColor:[THM BMColor]];
    
    [self languageAndButtonUIUpdate:self.caloriesBT buttonMode:1 inSection:@"" forKey:@"" backgroundColor:[THM F15Beginner1Color]];
    [self displayeLoadedDataOnScreen:self.descRecipe titleRecipe:self.nameRecipe ingredients:self.ingredients];
    
}


-(void) displayeLoadedDataOnScreen:(NSString*)desc titleRecipe:(NSString*)title ingredients:(NSString *)ingredients{
    
    
    NSError *err;
    NSMutableAttributedString *description = [[NSAttributedString alloc] initWithData: [desc dataUsingEncoding:NSUTF8StringEncoding] options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes: nil error: &err];
    NSMutableAttributedString *ingredient = [[NSAttributedString alloc] initWithData: [ingredients dataUsingEncoding:NSUTF8StringEncoding] options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes: nil error: &err];
    NSMutableAttributedString* result;
    if(description != nil){
        result = [description mutableCopy];
        [result appendAttributedString:ingredient];
    } else {
        result = [ingredient mutableCopy];
    }
    
    
    self.descRecipeLB.attributedText = result;
    
    self.nameLB.text = title;
    
    [self.caloriesBT setTitle:self.calories forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
