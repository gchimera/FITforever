//
//  FITFoodCreateMeal.m
//  fitapp
//
//  Created by Hadi Roohian on 28/12/2016.
//  Copyright © 2016 B60 Apps. All rights reserved.
//

#import "FITFoodCreateMealVC.h"
#import "Realm/Realm.h"
#import "FITFoodMealOptionsVC.h"
#import "CustomRecipe.h"

@interface FITFoodCreateMealVC ()
@property int day;
@property RLMResults *result;
@property UITapGestureRecognizer *tapRecognizer;
@property NSNumber *editingFoodID;
@property NSInteger program;
@property NSNumber *recipeType;


@end

@implementation FITFoodCreateMealVC
@synthesize tapRecognizer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"%@",self.mealSelected);
    
    if ([self.mealSelected isEqualToString:@"Breakfast"]) {
        self.navigationItem.title = @"Shake";
        self.titleLabel.text = @"Create your own shake";
    } else {

    }
    
    
    
    
    self.program = [self.currentCourse.courseType integerValue];
    
            switch ([self.currentCourse.courseType integerValue]) {
    
            case F15Advance1:
                    [self.portionBtn setHidden:NO];
                    break;
                    
            case F15Advance2:
                   [self.portionBtn setHidden:NO];
                    break;
            default:
                [self.portionBtn setHidden:YES];
                break;
        }
    
    switch (self.courseMapNumber) {
        case 2:
            self.recipeType = @1;
            break;
            
        default:
            self.recipeType = @0;
            break;
    }
    
    self.day = (int)[[Utils sharedUtils] getCurrentDayWithStartDate:self.currentCourse.startDate];
    NSLog(@"%ld",(long)self.day);

    self.mealDictionary = [[NSMutableDictionary alloc] init];
    [self programButtonUpdate:self.saveBtn buttonMode:3 inSection:CONTENT_FIT_F15_MEALS_SECTION forKey:CONTENT_BUTTON_SAVE];
    [self programButtonUpdate:self.cancelBtn buttonMode:3 inSection:CONTENT_FIT_F15_MEALS_SECTION forKey:CONTENT_BUTTON_CANCEL];
    [self programButtonUpdate:self.portionBtn buttonMode:3 inSection:CONTENT_FIT_F15_CREATE_MEALS_SECTION forKey:CONTENT_BUTTON_PORTION_SIZES];
    [self programImageUpdate:self.topShapeView withImageName:@"topshapes"];
    
    //text multilanguage
    self.titleLabel.text = [self localisedStringForSection:CONTENT_FIT_C9_MEALS_SECTION andKey:CONTENT_LABEL_CREATE_YOUR_OWN_MEAL];
    self.mealNameLabel.text = [self localisedStringForSection:CONTENT_FIT_C9_MEALS_SECTION andKey:CONTENT_LABEL_NAME];
    self.calorieLabel.text = [self localisedStringForSection:CONTENT_FIT_C9_MEALS_SECTION andKey:CONTENT_LABEL_CALORIES];
    self.descriptionLabel.text = [self localisedStringForSection:CONTENT_FIT_C9_MEALS_SECTION andKey:CONTENT_LABEL_DESCRIPTION];
    
    if([self.currentCourse.courseType integerValue] == C9){
        self.titleLabel.textColor = [THM C9Color];
    } else {
        self.titleLabel.textColor = [THM BMColor];
    }
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:
     UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(didTapAnywhere:)];
    
}


- (void) keyboardWillShow:(NSNotification *) note {
    [self.view addGestureRecognizer:tapRecognizer];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    if(!([self.nameTxtField.text isEqualToString:@""])){
//        NSLog(@"WE'RE EDITING");
        [self removeLastInsertedRow];
//    }
    
    
    
}



-(void) keyboardWillHide:(NSNotification *) note {
    [self.view removeGestureRecognizer:tapRecognizer];

}

-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {
    [_nameTxtField resignFirstResponder];
    [_caloriesTxtField resignFirstResponder];
    [_descTxtField resignFirstResponder];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    _scrollView.scrollEnabled = TRUE;
    _scrollViewBottomConstraint.constant = 130;
    [_scrollView setNeedsLayout];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [_scrollView setContentOffset: CGPointMake(0, _scrollView.frame.origin.x) animated:YES];
    _scrollViewBottomConstraint.constant = 0;
    _scrollView.scrollEnabled = FALSE;
    [_scrollView setNeedsLayout];
}



- (IBAction)saveBtnTapped:(id)sender {

        
    if (!([self.nameTxtField.text isEqualToString:@""])) {
        [self.mealDictionary setDictionary:@{
                                             @"name":self.nameTxtField.text,
                                             @"estimatedCalories":self.caloriesTxtField.text,
                                             @"desc":self.descTxtField.text,
                                             }];
        
        
        [self persistDataInRealm:@{
           @"name":self.mealDictionary[@"name"],
           @"estimatedCalories":self.mealDictionary[@"estimatedCalories"],
           @"ingredients":self.mealDictionary[@"desc"],
           @"programID":self.currentCourse.userProgramId
           }];

        NSLog(@"dicts = %@",self.mealDictionary.debugDescription);
        
        [self performSegueWithIdentifier:@"FITFoodEditMealVC" sender:self.mealDictionary];
        
    } else {
        //Alert To Fill The Form Completely.
        NSLog(@"HADI Error: at least one of the fields is empty!");
        
//        FITSettings* alert = [[FITSettings alloc]init];
        [self showAlertViewControllerWithMessage:@"Please Fill in all the required fields" andTitle:@"Error"];
    }
        
    
}

- (void)persistDataInRealm:(NSDictionary *)mealDictionary {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    NSLog(@"%@",self.editingFoodID);
    NSNumber *recipeId = @0;
    RLMResults *recipes = [CustomRecipe allObjects];
    if(self.editingFoodID != nil) {
        
        [CustomRecipe createOrUpdateInRealm:realm withValue:@{
        @"isSynced" : @NO,
        @"recipeID": self.editingFoodID,
        @"name" : mealDictionary[@"name"],
        @"estimatedCalories" : mealDictionary[@"estimatedCalories"],
        @"description" : mealDictionary[@"ingredients"],
        @"programType" : self.currentCourse.courseType,
        @"recipeType" : self.recipeType
        }];
        
        
    } else {
                
        
        [CustomRecipe createOrUpdateInRealm:realm withValue:@{
              @"isSynced" : @NO,
              @"recipeID" : recipeId,
              @"name" : mealDictionary[@"name"],
              @"estimatedCalories" : mealDictionary[@"estimatedCalories"],
              @"description" : mealDictionary[@"ingredients"],
              @"programType" : self.currentCourse.courseType,
              @"recipeType" : self.recipeType
              }];
        
                
    }
    
    [realm commitWriteTransaction];
    [self sendReceipe:[recipes lastObject]];
}


-(void)sendReceipe:(CustomRecipe *) recipe {
    NSString *recipeType = @"Meal";
    if([recipe.recipeType integerValue] == TYPE_MEAL)
        recipeType = @"Meal";
    else
        recipeType = @"Shake";
    /// TODO HAMID
    NSDictionary *ingredients = @{
                                  
                                  };
    
    NSDictionary *rec = @{
                          @"recipe_id":recipe.serverId != nil ? recipe.serverId : @"",
                          @"name": recipe.name,
                          @"description":recipe.description,
                          @"type": recipeType,
                          @"calories":recipe.estimatedCalories,
                          @"ingredients": ingredients,
                          };
    
    NSArray* recipeArray = [[NSArray alloc] initWithObjects:rec, nil];
    
    
    [[FITAPIManager sharedManager] sendRecipe:recipeArray success:^(int *status) {
        
        
    } failure:^(NSError *error) {
        
        
    }];
    
    
    
    
    
}

- (void)removeLastInsertedRow {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
//    self.editingFoodID = [[CustomRecipe objectsWhere:[NSString stringWithFormat:@"programType = %ld && name = '%@'", [self.currentCourse.courseType integerValue], self.nameTxtField.text]] lastObject][@"recipeID"];
    
    self.editingFoodID = [[CustomRecipe objectsWhere:[NSString stringWithFormat:@"name = '%@'", self.nameTxtField.text]] lastObject][@"recipeID"];
    
    [realm commitWriteTransaction];
}

- (void) dismissController {
    //    [[self navigationController] popViewControllerAnimated:YES];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        
        //Do not forget to import AnOldViewController.h
        if ([controller isKindOfClass:[FITFoodMealOptionsVC class]]) {
            
            [self.navigationController popToViewController:controller
                                                  animated:YES];
            break;
        }
    }
}








- (void)showAlertViewControllerWithMessage:(NSString*)message andTitle:(NSString*)title
{
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction* cancelAction= [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){
//        [alert dismissViewControllerAnimated:YES completion:nil];
//    }];
//    
//    [alert addAction:cancelAction];
//    [self presentViewController:alert animated:YES completion:nil];
    
    [[Utils sharedUtils] showAlertViewWithMessage:message buttonTitle:@"OK"];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"FITFoodEditMealVC"])
    {
        FITFoodEditMealVC *vc = [segue destinationViewController];
        [vc setMealDictionary:self.mealDictionary];
        vc.sender = self.mealSelected;
        
        
        vc.mealSelected = self.mealSelected;
        vc.courseMapNumber = self.courseMapNumber;
//        vc.foodDisplayMode = self.foodDisplayMode;
    }
}


#pragma mark - burger delegate

-(void)FITNavDrawerSelection:(NSInteger)selectionIndex
{
    NSLog(@"FITNavDrawerSelection = %li", (long)selectionIndex);
}

- (IBAction)cancelBtnTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)portionBtnTapped:(id)sender {
}
@end
