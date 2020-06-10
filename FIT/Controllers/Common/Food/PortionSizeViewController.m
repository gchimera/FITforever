//
//  PortionSizeViewController.m
//  FIT
//
//  Created by Hadi Roohian on 28/03/2017.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "PortionSizeViewController.h"

@interface PortionSizeViewController ()
@property (strong, nonatomic) FITBurgerMenu *rootNav;
@end

@implementation PortionSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.rootNav = (FITBurgerMenu *)self.navigationController;
    [self.rootNav setFITNavDrawerDelegate:self];
    
    [self programButtonUpdate:self.backgroundHexBtn1 buttonMode:1 inSection:@"" forKey:@"" withColor:[[ThemeManager getInstance] GreyColor]];
    [self programButtonUpdate:self.backgroundHexBtn2 buttonMode:1 inSection:@"" forKey:@"" withColor:[[ThemeManager getInstance] GreyColor]];
    [self programButtonUpdate:self.backgroundHexBtn3 buttonMode:1 inSection:@"" forKey:@"" withColor:[[ThemeManager getInstance] GreyColor]];
    [self programButtonUpdate:self.backgroundHexBtn4 buttonMode:1 inSection:@"" forKey:@"" withColor:[[ThemeManager getInstance] GreyColor]];
    [self programImageUpdate:self.topShapeView withImageName:@"topshapes"];
    [self programButtonUpdate:self.closeBtn buttonMode:3 inSection:CONTENT_FIT_C9_SHAKE_SECTION forKey:CONTENT_BUTTON_CLOSE];
    
    
}
- (IBAction)drawerToggle:(id)sender {
    [self.rootNav drawerToggle];
}

#pragma mark - burger delegate

-(void)FITNavDrawerSelection:(NSInteger)selectionIndex
{
    NSLog(@"FITNavDrawerSelection = %li", (long)selectionIndex);
    //    self.selectionIdx.text = [NSString stringWithFormat:@"%li",(long)selectionIndex];
}

- (IBAction)closeBtnTapped:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}
@end
