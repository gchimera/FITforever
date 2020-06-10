//
//  AddIngredientsViewController.m
//  FIT
//
//  Created by Hadi Roohian on 03/04/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "AddIngredientsViewController.h"
#import "IngredientCustomCell.h"

@interface AddIngredientsViewController ()
@property NSString *ingredientsTypeName;
@property RLMResults *carbohydrateIngredients;
@property RLMResults *fatsIngredients;
@property RLMResults *produceIngredients;
@property RLMResults *proteinIngredients;
@property UIColor *headerColor;
@property UIColor *oddColors;
@property UIColor *evenColors;
@property UIColor *highlightedColor;


@end

@implementation AddIngredientsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
     [self programButtonUpdate:self.saveBtn buttonMode:3 inSection:CONTENT_FIT_F15_SHAKE_SECTION forKey:CONTENT_BUTTON_SAVE];
    [self programButtonUpdate:self.cancelBtn buttonMode:3 inSection:CONTENT_FIT_F15_SHAKE_SECTION forKey:CONTENT_BUTTON_CANCEL];
    [self languageAndLabelUIUpdate:self.addYourOwnIngredientsLabel inSection:CONTENT_FIT_F15_MEALS_SECTION forKey:CONTENT_LABEL_ADD_YOUR_OWN_INGREDIENTS];

    switch ([self.currentCourse.courseType integerValue]) {
        case F15Begginner1:
            self.ingredientsTypeName = @"fit-ingredients-f15-beginner-";
            self.headerColor = [THM F15BeginnerColor];
            self.oddColors = [THM F15BeginnerColorWithSixtyPercentAlpha];
            self.evenColors = [THM F15BeginnerColorWithThirtyPercentAlpha];
            break;
        case F15Begginner2:
            self.ingredientsTypeName = @"fit-ingredients-f15-beginner-";
            self.headerColor = [THM F15BeginnerColor];
            self.oddColors = [THM F15BeginnerColorWithSixtyPercentAlpha];
            self.evenColors = [THM F15BeginnerColorWithThirtyPercentAlpha];
            break;
        case F15Intermidiate1:
            self.ingredientsTypeName = @"fit-ingredients-f15-intermediate-";
            self.headerColor = [THM F15IntermidiateColor];
            self.oddColors = [THM F15IntermidiateColorWithSixtyPercentAlpha];
            self.evenColors = [THM F15IntermidiateColorWithThirtyPercentAlpha];
            break;
        case F15Intermidiate2:
            self.ingredientsTypeName = @"fit-ingredients-f15-intermediate-";
            self.headerColor = [THM F15IntermidiateColor];
            self.oddColors = [THM F15IntermidiateColorWithSixtyPercentAlpha];
            self.evenColors = [THM F15IntermidiateColorWithThirtyPercentAlpha];
            break;
        case F15Advance1:
            self.ingredientsTypeName = @"fit-ingredients-f15-advanced-";
            self.headerColor = [THM F15AdvanceColor];
            self.oddColors = [THM F15AdvanceColorWithSixtyPercentAlpha];
            self.evenColors = [THM F15AdvanceColorWithThirtyPercentAlpha];
            break;
        case F15Advance2:
            self.ingredientsTypeName = @"fit-ingredients-f15-advanced-";
            self.headerColor = [THM F15AdvanceColor];
            self.oddColors = [THM F15AdvanceColorWithSixtyPercentAlpha];
            self.evenColors = [THM F15AdvanceColorWithThirtyPercentAlpha];
            break;
            
        default:
            break;
    }
    
    
    
    self.carbohydrateIngredients = [FLPIngredients objectsWhere:[NSString stringWithFormat:@"type = '%@carbohydrates'",self.ingredientsTypeName]];
    self.fatsIngredients = [FLPIngredients objectsWhere:[NSString stringWithFormat:@"type = '%@fats'",self.ingredientsTypeName]];
    self.produceIngredients = [FLPIngredients objectsWhere:[NSString stringWithFormat:@"type = '%@produce'",self.ingredientsTypeName]];
    self.proteinIngredients = [FLPIngredients objectsWhere:[NSString stringWithFormat:@"type = '%@protein'",self.ingredientsTypeName]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [self.carbohydrateIngredients count];
    } else if (section == 1) {
        return [self.fatsIngredients count];
    } else if (section == 2) {
        return [self.produceIngredients count];
    } else {
        return [self.proteinIngredients count];
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"+ Carbohydrates";
    } else if (section == 1) {
        return @"+ Fats";
    } else if (section == 2) {
        return @"+ Produce";
    } else {
        return @"+ Protein";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IngredientCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ingredientsCell"];
    
    
    if (indexPath.row % 2) {
        [cell setBackgroundColor:self.oddColors];
    } else {
        [cell setBackgroundColor:self.evenColors];
    }
    
    
    
    
    if (indexPath.section == 0) {
        cell.ingredientTitleLabel.text = [[self.carbohydrateIngredients objectAtIndex:indexPath.row] valueForKey:@"title"];
        cell.servingSizeLabel.attributedText = [self convertHtmlStringToAttributedString:[[self.carbohydrateIngredients objectAtIndex:indexPath.row] valueForKey:@"servingSize"]];
        
        cell.caloryLabel.text = [[self.carbohydrateIngredients objectAtIndex:indexPath.row] valueForKey:@"calories"];
        
        
        
    } else if (indexPath.section == 1) {
        cell.ingredientTitleLabel.text = [[self.fatsIngredients objectAtIndex:indexPath.row] valueForKey:@"title"];
        cell.servingSizeLabel.attributedText = [self convertHtmlStringToAttributedString:[[self.fatsIngredients objectAtIndex:indexPath.row] valueForKey:@"servingSize"]];
        cell.caloryLabel.text = [[self.fatsIngredients objectAtIndex:indexPath.row] valueForKey:@"calories"];
        
        
        
    } else if (indexPath.section == 2) {
        cell.ingredientTitleLabel.text = [[self.produceIngredients objectAtIndex:indexPath.row] valueForKey:@"title"];
        cell.servingSizeLabel.attributedText = [self convertHtmlStringToAttributedString:[[self.produceIngredients objectAtIndex:indexPath.row] valueForKey:@"servingSize"]];
        cell.caloryLabel.text = [[self.produceIngredients objectAtIndex:indexPath.row] valueForKey:@"calories"];
        
        
        
    } else if (indexPath.section == 3) {
        cell.ingredientTitleLabel.text = [[self.proteinIngredients objectAtIndex:indexPath.row] valueForKey:@"title"];
        cell.servingSizeLabel.attributedText = [self convertHtmlStringToAttributedString:[[self.proteinIngredients objectAtIndex:indexPath.row] valueForKey:@"servingSize"]];
        cell.caloryLabel.text = [[self.proteinIngredients objectAtIndex:indexPath.row] valueForKey:@"calories"];
        
        
        
    }
    
    
    if (cell.ingredientTitleLabel.text == (id)[NSNull null] || [cell.ingredientTitleLabel.text isEqual:nil] || cell.ingredientTitleLabel.text == nil || cell.ingredientTitleLabel.text.length == 0 ) cell.ingredientTitleLabel.text = @"";
    if (cell.servingSizeLabel.attributedText == (id)[NSNull null] || cell.servingSizeLabel.attributedText == nil || [cell.servingSizeLabel.attributedText isEqual:nil] || cell.servingSizeLabel.attributedText.length == 0 ) cell.servingSizeLabel.attributedText = [[NSAttributedString alloc] initWithString:@""];
    if (cell.caloryLabel.text == (id)[NSNull null] || cell.caloryLabel.text == nil || [cell.caloryLabel.text isEqual:nil] || cell.caloryLabel.text.length == 0 ) cell.caloryLabel.text = @"";
    
    return cell;
}

- (NSAttributedString *) convertHtmlStringToAttributedString:(NSString *)htmlString {
    NSError *err;
    NSString *ingredientsTextWithFont = [NSString stringWithFormat:@"<span style=\"font-family: HelveticaNeue; font-size: 14\">%@</span>",  htmlString];
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithData: [ingredientsTextWithFont dataUsingEncoding:NSUTF8StringEncoding] options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes: nil error: &err];
    
    return attributedText;
}


//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
//    
//    
//    if (section == 0) {
//        [headerView setText:@"Carbohydrates"];
//    } else if (section == 1) {
//        [headerView setText:@"Fats"];
//    } else if (section == 2) {
//        [headerView setText:@"Produce"];
//    } else {
//        [headerView setText:@"Protein"];
//    }
//    
//    
//    [headerView setBackgroundColor:[UIColor redColor]];
//    
//    return headerView;
//}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    header.contentView.backgroundColor = self.headerColor;
}

- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    for ( NSIndexPath* selectedIndexPath in tableView.indexPathsForSelectedRows ) {
        if ( selectedIndexPath.section == indexPath.section )
            [tableView deselectRowAtIndexPath:selectedIndexPath animated:NO] ;
    }
    return indexPath ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"Selected row will remain active for this section");
    
}

- (IBAction)saveBtnTapped:(id)sender {
    
    NSLog(@"All Selected rows in table : %@",self.tableView.indexPathsForSelectedRows);
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelBtnTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
