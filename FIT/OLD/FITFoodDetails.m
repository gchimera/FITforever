//
//  FITFoodDetails.m
//  fitapp
//
//  Created by Guglielmo Chimera on 09/01/17.
//  Copyright © 2017 B60 Apps. All rights reserved.
//

#import "FITFoodDetails.h"
#import "Realm/Realm.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "FITRecipes.h"
#import "UIImageView+WebCache.h"
#import "Player.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CustomRecipe.h"
@import MediaPlayer;


@import AVFoundation;
@import AVKit;

@interface FITFoodDetails ()


@property RLMResults *defaultFoods;
@property RLMResults *customAddedFoods;
@property NSString *partOfDay;
@property int day;
@property NSURL *videoURL;
@property NSNumber *recipeType;


@end

@implementation FITFoodDetails
@synthesize videoURL;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    NSLog(@"%@",self.mealSelected);
    NSLog(@"%ld",_indexPassed);
    NSLog(@"%d",_isCustomMeal);
    NSLog(@"%ld",(long)self.day);


    
    switch (self.courseMapNumber) {
        case 2:
            self.recipeType = @1;
            self.navigationItem.title = @"Meal";
            [self programButtonUpdate:self.doneBtn buttonMode:3 inSection:CONTENT_FIT_F15_CREATE_MEALS_SECTION forKey:CONTENT_BUTTON_CLOSE];
            break;
            
        default:
            self.recipeType = @0;
            self.navigationItem.title = @"Shake";
            [self programButtonUpdate:self.doneBtn buttonMode:3 inSection:CONTENT_FIT_F15_CREATE_MEALS_SECTION forKey:CONTENT_BUTTON_CLOSE];
            break;
    }
    
    [self loadDataFromRealmIntoRLMResults];
    [self displayeLoadedDataOnScreen];
    
    [self programButtonUpdate:self.doneBtn buttonMode:3 inSection:CONTENT_FIT_F15_CREATE_MEALS_SECTION forKey:CONTENT_BUTTON_CLOSE];
    
 //   [self programButtonUpdate:self.caloriesHexBtn buttonMode:1 inSection:@"203" forKey:@"203"];
    
    [self programLabelColor:self.ingredientsSectionTitle inSection:CONTENT_FIT_F15_RECIPE_SECTION forKey:CONTENT_LABEL_INGREDIENTS];
    

    
}




-(void)loadDataFromRealmIntoRLMResults {
    NSString *recipeNameForUsingInRealmQuery;
    
    switch (self.courseMapNumber) {
        case 2:
            if ([self.mealSelected isEqualToString:@"Breakfast"]) {
                recipeNameForUsingInRealmQuery = @"fitapp-recipe-breakfast";
                
            } else if([self.mealSelected isEqualToString:@"Snack"]) {
                recipeNameForUsingInRealmQuery = @"fitapp-recipe-snack";
                
            } else if([self.mealSelected isEqualToString:@"Lunch"]) {
                recipeNameForUsingInRealmQuery = @"fitapp-recipe-lunch";
                
            } else if([self.mealSelected isEqualToString:@"Dinner"]) {
                recipeNameForUsingInRealmQuery = @"fitapp-recipe-dinner";
                
            } else if([self.mealSelected isEqualToString:@"EveningShake"]) {
                recipeNameForUsingInRealmQuery = @"fitapp-recipe-shakes";
                
            }
            break;
        case 3:
            recipeNameForUsingInRealmQuery = @"fitapp-recipe-shakes";
            break;
        case 4:
            recipeNameForUsingInRealmQuery = @"fitapp-recipe-shakes";
            break;
            
        default:
            break;
    }
    
    
    
    NSString *programNameForUsingInRealmQuery = @"";
    switch ([self.currentCourse.courseType integerValue]) {
            
        case F15Begginner1:
            programNameForUsingInRealmQuery = @"programF15Beginner1";
            break;
        case F15Begginner2:
            programNameForUsingInRealmQuery = @"programF15Beginner2";
            break;
            
        case F15Intermidiate1:
            programNameForUsingInRealmQuery = @"programF15Intermediate1";
            break;
            
        case F15Intermidiate2:
            programNameForUsingInRealmQuery = @"programF15Intermediate2";
            break;
            
        case F15Advance1:
            programNameForUsingInRealmQuery = @"programF15Advanced1";
            break;
            
        case F15Advance2:
            programNameForUsingInRealmQuery = @"programF15Advanced2";
            break;
            
        default:
            break;
    }
    
    
    if([programNameForUsingInRealmQuery isEqualToString:@""]) {
        self.defaultFoods = [FITRecipes objectsWhere:[NSString stringWithFormat:@"type = '%@' AND programF15Beginner1 = NO AND programF15Beginner2 = NO AND programF15Intermediate1 = NO AND programF15Intermediate2 = NO AND programF15Advanced1 = NO AND programF15Advanced2 = NO",recipeNameForUsingInRealmQuery]];
    } else {
        self.defaultFoods = [FITRecipes objectsWhere:[NSString stringWithFormat:@"type = '%@' AND %@ = YES",recipeNameForUsingInRealmQuery, programNameForUsingInRealmQuery]];
    }
//    self.customAddedFoods = [CustomRecipe objectsWhere:[NSString stringWithFormat:@"programType = %ld AND recipeType = %ld",[self.currentCourse.courseType integerValue], (long)[self.recipeType integerValue]]];
    self.customAddedFoods = [CustomRecipe objectsWhere:[NSString stringWithFormat:@"recipeType = %ld",(long)[self.recipeType integerValue]]];
    
    NSLog(@"%ld %ld",[self.currentCourse.courseType integerValue], (long)[self.recipeType integerValue]);
    
    
    
    if ([self.mealSelected isEqualToString:@"Breakfast"]) {
        self.partOfDay = @"fitapp-recipe-breakfast";
        
    } else if([self.mealSelected isEqualToString:@"Snack"]) {
        self.partOfDay = @"fitapp-recipe-snack";
        
    } else if([self.mealSelected isEqualToString:@"Lunch"]) {
        self.partOfDay = @"fitapp-recipe-lunch";
        
    } else if([self.mealSelected isEqualToString:@"Dinner"]) {
        self.partOfDay = @"fitapp-recipe-dinner";
        
    } else if([self.mealSelected isEqualToString:@"EveningShake"]) {
        self.partOfDay = @"fitapp-recipe-shakes";
        
    }
    
    
    
    
}




-(void) displayeLoadedDataOnScreen {
    RLMObject *selectedFoodDetails;
    if (_isCustomMeal) {
        NSURL *url = [NSURL URLWithString:[self localisedStringForSection:CONTENT_FITAPP_LABELS_IMAGES_SECTION andKey:CONTENT_RECIPES_PLACEHOLDER]];
        [self.pictureImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.gif"]];
        selectedFoodDetails = [_customAddedFoods objectAtIndex:self.indexPassed];
        self.ingredientsLbl.text = selectedFoodDetails[@"description"];
        self.videoPlayBtn.hidden = YES;
        
    } else {
        selectedFoodDetails = [_defaultFoods objectAtIndex:self.indexPassed];
        NSURL *url = [NSURL URLWithString:[self localisedStringForSection:CONTENT_FITAPP_LABELS_IMAGES_SECTION andKey:CONTENT_RECIPES_PLACEHOLDER]];
        [self.pictureImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.gif"]];
        
        
        if([selectedFoodDetails[@"image"] hasPrefix:@"http"]){
            [self.pictureImageView sd_setImageWithURL:selectedFoodDetails[@"image"] placeholderImage:[UIImage imageNamed:@"placeholder.gif"]];
            self.videoPlayBtn.hidden = YES;
        
        } else if ([selectedFoodDetails[@"shakeVideo"] hasPrefix:@"http"]) {
            
            
            if([selectedFoodDetails[@"thumbnailImage"] hasPrefix:@"http"]){
                [self.pictureImageView sd_setImageWithURL:selectedFoodDetails[@"thumbnailImage"] placeholderImage:[UIImage imageNamed:@"placeholder.gif"]];
                self.videoPlayBtn.hidden = YES;
                
            } else {
    
                NSURL *url = [NSURL URLWithString:[self localisedStringForSection:CONTENT_FITAPP_LABELS_IMAGES_SECTION andKey:CONTENT_RECIPES_PLACEHOLDER]];
                [self.pictureImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.gif"]];
            }
            self.videoPlayBtn.hidden = NO;
            self.videoURL = [NSURL URLWithString:selectedFoodDetails[@"shakeVideo"]];
            NSLog(@"%@",self.videoURL);
            
        } else {
            NSURL *url = [NSURL URLWithString:[self localisedStringForSection:CONTENT_FITAPP_LABELS_IMAGES_SECTION andKey:CONTENT_RECIPES_PLACEHOLDER]];
            [self.pictureImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.gif"]];
            self.videoPlayBtn.hidden = YES;
        }
        
        NSError *err;
        NSString *ingredientsTextWithFont = [NSString stringWithFormat:@"<span style=\"font-family: HelveticaNeue; font-size: 14\">%@</span>", selectedFoodDetails[@"ingredients"]];
        
        self.ingredientsLbl.attributedText = [[NSAttributedString alloc] initWithData: [ingredientsTextWithFont dataUsingEncoding:NSUTF8StringEncoding] options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes: nil error: &err];
    }
    
    self.nameLbl.text = selectedFoodDetails[@"name"];
    [self programLabelColor:self.nameLbl];
    if(!([selectedFoodDetails[@"estimatedCalories"] isEqualToString:@""] && [selectedFoodDetails[@"estimatedCalories"] isEqual:nil])) {
        [self programButtonUpdate:self.caloriesHexBtn buttonMode:1 inSection:@"" forKey:@""];
        [self.caloriesHexBtn setTitle:selectedFoodDetails[@"estimatedCalories"] forState:UIControlStateNormal];
        
    } else {
        [self.caloriesHexBtn setTitle:@"N/A" forState:UIControlStateNormal];
    }
}



-(UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}



- (IBAction)doneBtnTapped:(id)sender {
    UIViewController *home = [self.storyboard instantiateViewControllerWithIdentifier:PROGRAM_DASHBOARD];
    [self.navigationController pushViewController:home animated:YES];
}




- (IBAction)playBtnTapped:(id)sender {
    [self performSegueWithIdentifier:@"gotoAVPlayer" sender:self];

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSComparisonResult order = [[UIDevice currentDevice].systemVersion compare: @"9.3" options: NSNumericSearch];
    if (order == NSOrderedSame || order == NSOrderedDescending) {
        // OS version >=
        if ([segue.destinationViewController isKindOfClass:[AVPlayerViewController class]])
            
            if ([segue.destinationViewController isKindOfClass:[AVPlayerViewController class]])
                self.playerVC = segue.destinationViewController;
        NSLog(@"%@", self.videoURL);
        self.playerVC.player = [AVPlayer playerWithURL:self.videoURL];
        self.playerVC.showsPlaybackControls = YES;
        self.playerVC.view.frame = self.view.bounds;
        
    } else {
        
        // OS version <
        NSURL *movieURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.videoURL]];
       MPMoviePlayerViewController*  movieController = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
        [self presentMoviePlayerViewControllerAnimated:movieController];
        [movieController.moviePlayer play];
    }
    
    


    
    
    

    
}


@end
