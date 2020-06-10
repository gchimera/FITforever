//
//  FITBurgerMenu.m
//  FIT
//
//  Created by Hamid Mehmood on 14/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "FITBurgerMenu.h"
#import "DrawerView.h"
#import "Content.h"
#import "ContentCostants.h"
#import "ThemeManager.h"
#import "FITProgramsListViewController.h"

#define SHAWDOW_ALPHA 0.5
#define MENU_DURATION 0.3
#define MENU_TRIGGER_VELOCITY 350

@interface FITBurgerMenu ()

@property (nonatomic) BOOL isOpen;
@property (nonatomic) float meunHeight;
@property (nonatomic) float menuWidth;
@property (nonatomic) CGRect outFrame;
@property (nonatomic) CGRect inFrame;
@property (strong, nonatomic) UIView *shawdowView;
@property (strong, nonatomic) DrawerView *drawerView;

@end

@implementation FITBurgerMenu

#pragma mark - VC lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    menuArray = [[NSArray alloc]initWithObjects:
                 [Content contentValueForSection:CONTENT_MENU_SECTION andKey:CONTENT_MENU_YOURPROFILE],
                 [Content contentValueForSection:CONTENT_MENU_SECTION andKey:CONTENT_MENU_YOURPROGRAMS],
                 [Content contentValueForSection:CONTENT_MENU_SECTION andKey:CONTENT_MENU_EXERCISES],
                 [Content contentValueForSection:CONTENT_MENU_SECTION andKey:CONTENT_MENU_RECIPES],
                 [Content contentValueForSection:CONTENT_MENU_SECTION andKey:CONTENT_MENU_SETTINGS],
                 [Content contentValueForSection:CONTENT_MENU_SECTION andKey:CONTENT_MENU_PROGRAM_SETTING],
                 nil];
    [self setUpDrawer];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - push & pop

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    // disable gesture in next vc
    [self.pan_gr setEnabled:NO];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    
    // enable gesture in root vc
    if ([self.viewControllers count]==1){
        [self.pan_gr setEnabled:YES];
    }
    return vc;
}

#pragma mark - drawer

- (void)setUpDrawer
{
    self.isOpen = NO;
    
    // load drawer view
    self.drawerView = [[[NSBundle mainBundle] loadNibNamed:@"DrawerView" owner:self options:nil] objectAtIndex:0];
    
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString* versionNo = [infoDict objectForKey:@"CFBundleShortVersionString"];
    NSString* build = [infoDict objectForKey:@"CFBundleVersion"];
    
    
    self.drawerView.version.text = [NSString stringWithFormat:@"© FITAPP Version %@(%@)",versionNo,build];
    //    NSLog(@"© FITAPP Version %@(%@)",versionNo,build);
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    self.meunHeight = self.view.frame.size.height;
    self.menuWidth = self.drawerView.frame.size.width;
    self.outFrame = CGRectMake(screenWidth ,0,self.menuWidth,self.meunHeight);
    self.inFrame = CGRectMake (screenWidth - self.menuWidth,0,self.menuWidth,self.meunHeight);
    
    // drawer shawdow and assign its gesture
    self.shawdowView = [[UIView alloc] initWithFrame:self.view.frame];
    self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    self.shawdowView.hidden = YES;
    UITapGestureRecognizer *tapIt = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(tapOnShawdow:)];
    [self.shawdowView addGestureRecognizer:tapIt];
    self.shawdowView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.shawdowView];
    
    // add drawer view
    [self.drawerView setFrame:self.outFrame];
    [self.view addSubview:self.drawerView];
    
    // drawer list
    [self.drawerView.drawerTableView setContentInset:UIEdgeInsetsMake(50, 0, 0, 0)]; // statuesBarHeight+navBarHeight
    self.drawerView.drawerTableView.dataSource = self;
    self.drawerView.drawerTableView.delegate = self;
    
    // gesture on self.view
    self.pan_gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveDrawer:)];
    self.pan_gr.maximumNumberOfTouches = 1;
    self.pan_gr.minimumNumberOfTouches = 1;
    //self.pan_gr.delegate = self;
    [self.view addGestureRecognizer:self.pan_gr];
    
    [self.view bringSubviewToFront:self.navigationBar];
    
    //    for (id x in self.view.subviews){
    //        NSLog(@"%@",NSStringFromClass([x class]));
    //    }
}

- (void)drawerToggle
{
    if (!self.isOpen) {
        [self openNavigationDrawer];
    }else{
        [self closeNavigationDrawer];
    }
}

#pragma open and close action

- (void)openNavigationDrawer{
    //    NSLog(@"open x=%f",self.menuView.center.x);
    float duration = MENU_DURATION/self.menuWidth*fabs(self.drawerView.center.x)+MENU_DURATION/2; // y=mx+c
    
    // shawdow
    self.shawdowView.hidden = NO;
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:SHAWDOW_ALPHA];
                     }
                     completion:nil];
    
    // drawer
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.drawerView.frame = self.inFrame;
                     }
                     completion:nil];
    
    self.isOpen= YES;
}

- (void)closeNavigationDrawer{
    //    NSLog(@"close x=%f",self.menuView.center.x);
    float duration = MENU_DURATION/self.menuWidth*fabs(self.drawerView.center.x)+MENU_DURATION/2; // y=mx+c
    
    // shawdow
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0f];
                     }
                     completion:^(BOOL finished){
                         self.shawdowView.hidden = YES;
                     }];
    
    // drawer
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.drawerView.frame = self.outFrame;
                     }
                     completion:nil];
    self.isOpen= NO;
}

#pragma gestures

- (void)tapOnShawdow:(UITapGestureRecognizer *)recognizer {
    [self closeNavigationDrawer];
}

-(void)moveDrawer:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)recognizer velocityInView:self.view];
    //    NSLog(@"velocity x=%f",velocity.x);
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateBegan) {
        //        NSLog(@"start");
        if ( velocity.x > MENU_TRIGGER_VELOCITY && !self.isOpen) {
            [self openNavigationDrawer];
        }else if (velocity.x < -MENU_TRIGGER_VELOCITY && self.isOpen) {
            [self closeNavigationDrawer];
        }
    }
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateChanged) {
        //        NSLog(@"changing");
        float movingx = self.drawerView.center.x + translation.x;
        if ( movingx > -self.menuWidth/2 && movingx < self.menuWidth/2){
            
            self.drawerView.center = CGPointMake(movingx, self.drawerView.center.y);
            [recognizer setTranslation:CGPointMake(0,0) inView:self.view];
            
            float changingAlpha = SHAWDOW_ALPHA/self.menuWidth*movingx+SHAWDOW_ALPHA/2; // y=mx+c
            self.shawdowView.hidden = NO;
            self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:changingAlpha];
        }
    }
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateEnded) {
        //        NSLog(@"end");
        if (self.drawerView.center.x>0){
            [self openNavigationDrawer];
        }else if (self.drawerView.center.x<0){
            [self closeNavigationDrawer];
        }
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return menuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    
    // Configure the cell...
    cell.textLabel.text =menuArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font  = [UIFont fontWithName: @"SanFranciscoDisplay-Bold.otf" size: 20.0];
    cell.textLabel.font = [UIFont fontWithDescriptor:[cell.textLabel.font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold]
                                                size:cell.textLabel.font.pointSize];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Draw top border only on first cell
    if (indexPath.row > 0) {
        UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(16, 0, 190, 1)];
        topLineView.backgroundColor = [THM LearnMoreButtonColor];
        [cell.contentView addSubview:topLineView];
    }
    
    //    [NSString stringWithFormat:@"row %li",(long)[indexPath row]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [self.FITNavDrawerDelegate FITNavDrawerSelection:[indexPath row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BOOL *enabled = YES;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    UIViewController *controllerMenuDestination;
    switch (indexPath.row) {
        case 0:
            controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_PROFILE];
            break;
        case 1:
            controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_PROGRAM_LIST];
            break;
        case 2:
            controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_EXERCISES_LIST];
          //  enabled = NO;
            break;
        case 3:
            controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_RECIPES_LIST];
          //  enabled = NO;
            break;
        case 4:
            controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_SETTINGS];
            break;
        case 5:
            controllerMenuDestination = [storyboard instantiateViewControllerWithIdentifier:MENU_PROGRAM_SETTINS];
            
            RLMResults *currentProgram = [UserCourse objectsWhere:@"status = %d",1];
            
            if([currentProgram count] > 0){
                enabled = YES;
            } else {
                enabled = NO;
            }
            break;
    }
    
    if(enabled){
        [[self navigationController] pushViewController:controllerMenuDestination animated:YES];
        [self pushViewController:controllerMenuDestination animated:YES];
    }
    
    [self closeNavigationDrawer];
}

@end
