//
//  MeasurementsViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "MeasurementsViewController.h"
#import "AppSettings.h"
#import "Measurement.h"


@interface MeasurementsViewController ()

@end

@implementation MeasurementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    NSLog(@"%ld",(long)self.day);
    
    if([self.currentCourse.courseType integerValue] == C9){
        [self programButtonUpdate:self.lbBtn buttonMode:1 inSection:CONTENT_PROGRESS_SCREEN forKey:@"" withColor:[THM GreyColor]];
        [self programButtonUpdate:self.inBtn buttonMode:1 inSection:CONTENT_PROGRESS_SCREEN forKey:@"" withColor:[THM GreyColor]];
        [self programButtonUpdate:self.enterTodayBtn buttonMode:3 inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_BUTTON_ENTER_TODAY withColor:[UIColor colorWithRed:(137.0/255.0) green:(82.0/255.0) blue:(138.0/255.0) alpha:1]];
    } else if ([self.currentCourse.courseType integerValue] == F15Begginner || [self.currentCourse.courseType integerValue] == F15Begginner1 || [self.currentCourse.courseType integerValue] == F15Begginner2){
        [self programButtonUpdate:self.lbBtn buttonMode:1 inSection:CONTENT_PROGRESS_SCREEN forKey:@"" withColor:[THM GreyColor]];
        [self programButtonUpdate:self.inBtn buttonMode:1 inSection:CONTENT_PROGRESS_SCREEN forKey:@"" withColor:[THM GreyColor]];
        
        [self programButtonUpdate:self.enterTodayBtn buttonMode:3 inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_BUTTON_ENTER_TODAY withColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1]];
    } else if ([self.currentCourse.courseType integerValue] == F15Intermidiate || [self.currentCourse.courseType integerValue] == F15Intermidiate1 || [self.currentCourse.courseType integerValue] == F15Intermidiate2){
        [self programButtonUpdate:self.lbBtn buttonMode:1 inSection:CONTENT_PROGRESS_SCREEN forKey:@"" withColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1]];
        [self programButtonUpdate:self.inBtn buttonMode:1 inSection:CONTENT_PROGRESS_SCREEN forKey:@"" withColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1]];
        
        [self programButtonUpdate:self.enterTodayBtn buttonMode:3 inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_BUTTON_ENTER_TODAY withColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1]];
        
    } else if ([self.currentCourse.courseType integerValue] == F15Advance || [self.currentCourse.courseType integerValue] == F15Advance1 || [self.currentCourse.courseType integerValue] == F15Advance2){
        [self programButtonUpdate:self.lbBtn buttonMode:1 inSection:CONTENT_PROGRESS_SCREEN forKey:@"" withColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1]];
        [self programButtonUpdate:self.inBtn buttonMode:1 inSection:CONTENT_PROGRESS_SCREEN forKey:@"" withColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1]];
        
        [self programButtonUpdate:self.enterTodayBtn buttonMode:3 inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_BUTTON_ENTER_TODAY withColor:[UIColor colorWithRed:(93.0/255.0) green:(95.0/255.0) blue:(86.0/255.0) alpha:1]];
        
    }
    [self programButtonUpdate:self.measurementBtn buttonMode:1 inSection:CONTENT_PROGRESS_SCREEN forKey:@""];
    [self programButtonUpdate:self.reviewBrogressBtn buttonMode:3 inSection:CONTENT_PROGRESS_SCREEN forKey:CONTENT_BUTTON_REVIEW_PROGRESS];
    
    NSString *gender;
    
    User* user = [User userInDB];
    
    if ([user.gender isEqualToString:@"m"]){
        [self programImageUpdate:self.personImgView withImageName:@"man"];
    } else {
        [self programImageUpdate:self.personImgView withImageName:@"woman"];
    }
    
    [self checkCurrentMeasurementDataInRealm];
    [self updateWeightAndMeasurementButtonTitle];
    
    [self.navigationItem setTitle:[self localisedStringForSection:CONTENT_PROGRESS_SCREEN andKey:CONTENT_PROGRESS_SCREEN_TITLE]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)checkCurrentMeasurementDataInRealm {
    
    self.result = [Measurement objectsWhere:[NSString stringWithFormat:@"day = '%d' && programID = '%@'",self.day, self.currentCourse.userProgramId]];
    NSLog(@"Result Object Hadi::::: %@",self.result);
}

-(void)updateWeightAndMeasurementButtonTitle {
    
    RLMResults *measurement = [Measurement objectsWhere:[NSString stringWithFormat:@"programID = '%@' && day = '%d'", self.currentCourse.userProgramId, self.day]];
    NSString *measurementStartingNumber = [measurement firstObject][@"totalMeasurements"];
    NSString *currentMesurement = [measurement firstObject][@"totalMeasurements"];
    int displayMeasurement = [currentMesurement intValue] - [measurementStartingNumber intValue];
    
    //    self.inBtn.titleLabel.text = [NSString stringWithFormat:@"%d in",displayMeasurement];
    [self.inBtn setTitle:[NSString stringWithFormat:@"%din",displayMeasurement] forState:UIControlStateNormal];
    User *user = [User userInDB];
    NSString *weightStartingNumber = [NSString stringWithFormat:@"%@",user.weight];
    NSString *currentWeight = [measurement firstObject][@"weight"];
    
    if(self.day == 1) {
        currentWeight = weightStartingNumber;
    }
    int displayWeight = [currentWeight intValue] - [weightStartingNumber intValue];
    
    //    self.lbBtn.titleLabel.text = [NSString stringWithFormat:@"%d Lbs",displayWeight];
    [self.lbBtn setTitle:[NSString stringWithFormat:@"%dlb",displayWeight] forState:UIControlStateNormal];

}

@end
