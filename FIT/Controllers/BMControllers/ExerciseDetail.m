//
//  ExerciseDetail.m
//  FIT
//
//  Created by Guglielmo Chimera on 03/04/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "ExerciseDetail.h"
#import "Realm/Realm.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "FITRecipes.h"
#import "UIImageView+WebCache.h"
#import "Player.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@import MediaPlayer;


@import AVFoundation;
@import AVKit;


@interface ExerciseDetail ()

@end

@implementation ExerciseDetail


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



@synthesize videoURL;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@",self.name];

    NSLog(@"%@",_imglink);
    NSLog(@"%@",self.videoURL);
    [self displayeLoadedDataOnScreen:self.descExercise];
    
    if(_imglink.length != 0)
    {

         NSURL *url = [NSURL URLWithString:_imglink];
        
    [self.pictureImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.gif"]];
    self.videoPlayBtn.hidden = YES;
    
    }else{
        NSURL *url = [NSURL URLWithString:[self localisedStringForSection:CONTENT_FITAPP_LABELS_IMAGES_SECTION andKey:CONTENT_EXERCISES_PLACEHOLDER]];
        [self.pictureImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.gif"]];
    }
    
    
    [self languageAndButtonUIUpdate:self.doneBtn buttonMode:3 inSection:CONTENT_FITAPP_SETTINGS_SECTION forKey:CONTENT_BUTTON_DONE backgroundColor:[THM BMColor]];

 }



-(IBAction)back:(id)sender
{

    [self.navigationController popViewControllerAnimated:YES];

}




-(void) displayeLoadedDataOnScreen: (NSString*)desc {

    
    NSError *err;
    self.ingredientsLbl.attributedText = [[NSAttributedString alloc] initWithData: [desc dataUsingEncoding:NSUTF8StringEncoding] options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes: nil error: &err];

}



-(UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}



- (IBAction)doneBtnTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

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
 NSURL *url = [NSURL URLWithString:self.videoURL];
        self.playerVC.player = [AVPlayer playerWithURL:url];
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
