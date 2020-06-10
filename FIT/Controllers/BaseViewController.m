//
//  BaseViewController.m
//  FIT
//
//  Created by Hamid Mehmood on 01/03/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                     [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:17.0], NSFontAttributeName,nil]];
    
//    [self.progressHUD setDefaultStyle:SVProgressHUDStyleCustom];
//    [self.progressHUD setDefaultMaskType: SVProgressHUDMaskTypeGradient];
//    [self.progressHUD setBackgroundColor:[THM C9Color]];
//    [self.progressHUD setForegroundColor:[UIColor whiteColor]];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) showProgressView {
    
//    [self.progressHUD show];
}

- (void) dismissProgressView {
    
//    [self.progressHUD dismiss];
}

#pragma mark FITButton (HEXBUTTON) ACTION
- (void)languageAndButtonUIUpdate:(UIButton *)button buttonMode:(int)buttonMode inSection:(NSString *) section forKey:(NSString *) key backgroundColor:(UIColor*)color{
    UIImage *img = [FITButton  returnImageWithColor:color andFrame:button.frame buttonMode:buttonMode];
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:img forState:UIControlStateNormal];
    
    NSString *title = [self localisedStringForSection:section andKey:key];
    if (title != nil) {
        [button setTitle:title forState:UIControlStateNormal];
    }
}

- (void)languageAndLabelUIUpdate:(UILabel *)label inSection:(NSString *) section forKey:(NSString *) key {
    
    NSString *text = [self localisedStringForSection:section andKey:key];
    
    if (text != nil) {
        label.text = text;
    }
}

- (void)languageHTMLLabelUIUpdate:(UILabel *)label inSection:(NSString *) section forKey:(NSString *) key {
    
    NSString *text = [self localisedStringForSection:section andKey:key];
    NSData *HTMLData = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:HTMLData options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:NULL error:NULL];
    label.text = attrString.string;
}

- (void)languageAndTextFieldUIUpdate:(UITextField *)textField inSection:(NSString *) section forKey:(NSString *) key {
    
    NSString *text = [self localisedStringForSection:section andKey:key];
    if (text != nil) {
        textField.text = text;
    }
}

- (void)switchToController:(NSString *) controller inStoryboard:(NSString *) storyboard{
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboard bundle:nil];
    UIViewController *viewController = [sb instantiateViewControllerWithIdentifier:controller];
    
    [self presentViewController:viewController animated:YES completion:nil];
    
    
}

- (void)switchToControllerInSameStoryBoard:(NSString *) controller inStoryboard:(NSString *) storyboard{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboard bundle:nil];
    UIViewController *viewController = [sb instantiateViewControllerWithIdentifier:controller];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
    
}
- (NSString *)localisedStringForSection:(NSString *)section
                                 andKey:(NSString *)key {
    NSString *result = [Content contentValueForSection:section andKey:key];
    return result != nil ? result : @"";
}

- (NSString *)localisedHTMLForSection:(NSString *)section
                               andKey:(NSString *)key {
    
    //    NSString *result = [Content contentValueForSection:section andKey:key];
    NSString *text = [self localisedStringForSection:section andKey:key];
    NSData *HTMLData = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:HTMLData options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:NULL error:NULL];
    NSString *plainString = attrString.string;
    if(plainString != nil) {
        
    }
    return plainString != nil ? plainString : @"";
}

- (NSAttributedString *)localisedAttributedStringHTMLForSection:(NSString *)section
                               andKey:(NSString *)key {
    
    NSString *text = [self localisedStringForSection:section andKey:key];
    NSData *HTMLData = [text dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *attrDict = @{
//                               NSFontAttributeName : [UIFont fontWithName: @"SanFranciscoDisplay-Regular.otf" size:17.0],
//                               };

    NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:HTMLData options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:NULL error:NULL];

    return attrString != nil ? attrString : @"";
}


@end
