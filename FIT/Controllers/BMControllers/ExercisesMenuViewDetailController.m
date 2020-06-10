//
//  ExerisesMenuViewDetailController.m
//  FIT
//
//  Created by Bruce Cresanta on 3/24/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ExercisesMenuViewDetailController.h"
#import "FITWorkoutDetailsRLM.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import "FITFoodDetails.h"
#import "ExerciseDetail.h"

@interface ExercisesMenuViewDetailController ()

@end

@implementation ExercisesMenuViewDetailController
@synthesize sectionName;
@synthesize table;
RLMResults *exerciseResult;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", sectionName);
    
    NSLog(@"%@", self.stringPassed);

    
    
    // exerciseResult = [FITWorkoutDetailsRLM objectsWhere:[NSString stringWithFormat:@"uid = '%@'",sectionName]];

     exerciseResult = [FITWorkoutDetailsRLM objectsWhere:[NSString stringWithFormat:@"systemName CONTAINS '%@' OR systemName CONTAINS 'cool-down' OR systemName CONTAINS 'warm-up'",self.stringPassed]];
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
    return exerciseResult.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExerciseCell *cell = (ExerciseCell*)[tableView dequeueReusableCellWithIdentifier:@"exerciseCell"];

     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   cell.excerciseLabel.text = [[exerciseResult valueForKey:@"sectionName"]objectAtIndex:indexPath.row];
    
    NSString* thumbnailString = [[exerciseResult valueForKey:@"thumbnailImage"]objectAtIndex:indexPath.row];
    
    if (![thumbnailString isEqual:[NSNull null]]) {
        
        NSURL *url = [NSURL URLWithString:thumbnailString];

        [cell.excerciseImageView sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"placeholder.gif"]];
    }else{
        NSURL *url = [NSURL URLWithString:[self localisedStringForSection:CONTENT_FITAPP_LABELS_IMAGES_SECTION andKey:CONTENT_EXERCISES_PLACEHOLDER]];
        [cell.excerciseImageView sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"placeholder.gif"]];
    }
    
    
    
    
    

    
     
    return  cell;
}


- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", [[exerciseResult valueForKey:@"desc"]objectAtIndex:indexPath.row]);
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    
    ExerciseDetail *dealVC = (ExerciseDetail *)[storyboard instantiateViewControllerWithIdentifier:@"video"];
    
    FITWorkoutDetailsRLM* exerc = [exerciseResult objectAtIndex:indexPath.row];
    
    // if video link exists..
    if (exerc.workoutVideo.length != 0 ) {
        
        dealVC.videoURL = exerc.workoutVideo;

    }else{
        dealVC.videoURL = @"";

    }
    dealVC.imglink = exerc.thumbnailImage;
    dealVC.descExercise = exerc.desc;
    
    dealVC.nameLbl.text = @"Main Workout";
    
    dealVC.name = exerc.name;
    
    
    [self.navigationController pushViewController:dealVC animated:YES];
}







@end
