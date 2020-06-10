//
//  BaseTableViewCell.m
//  FIT
//
//  Created by Bruce Cresanta on 3/19/17.
//  Copyright © 2017 B60 Limited. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    RLMResults *currentProgram = [UserCourse objectsWhere:@"status = %d",1];
    
    if([currentProgram count] > 0){
        self.currentCourse = [[UserCourse alloc] init];
        self.currentCourse = [currentProgram objectAtIndex:0];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
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
    NSData *HTMLData = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:HTMLData options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:NULL error:NULL];
    NSString *plainString = attrString.string;
    
    if (text != nil) {
        label.text = text;
    }
}

- (void)languageHTMLLabelUIUpdate:(UILabel *)label inSection:(NSString *) section forKey:(NSString *) key {
    
    NSString *text = [self localisedStringForSection:section andKey:key];
    NSData *HTMLData = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:HTMLData options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:NULL error:NULL];
    NSString *plainString = attrString.string;
    
    if (text != nil) {
        NSString *textString = text;
        NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                initWithData: [text dataUsingEncoding:NSUTF8StringEncoding]
                                                options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                documentAttributes: nil
                                                error: nil
                                                ];
        label.text = plainString;
    }
}

- (void)languageAndTextFieldUIUpdate:(UITextField *)textField inSection:(NSString *) section forKey:(NSString *) key {
    
    NSString *text = [self localisedStringForSection:section andKey:key];
    if (text != nil) {
        textField.text = text;
    }
}


- (NSString *)localisedStringForSection:(NSString *)section
                                 andKey:(NSString *)key {
    NSString *result = [Content contentValueForSection:section andKey:key];
    return result != nil ? result : @"";
}

- (NSString *)localisedHTMLForSection:(NSString *)section
                               andKey:(NSString *)key {
    
    NSString *result = [Content contentValueForSection:section andKey:key];
    if(result != nil) {
        
    }
    return result != nil ? result : @"";
}

- (void)programButtonUpdate:(UIButton *)button
                 buttonMode:(int)buttonMode
                  inSection:(NSString *)section
                     forKey:(NSString *)key
                  withColor:(UIColor *) color {
    [self languageAndButtonUIUpdate:button buttonMode:buttonMode inSection:section forKey:key backgroundColor:color];
}




@end
