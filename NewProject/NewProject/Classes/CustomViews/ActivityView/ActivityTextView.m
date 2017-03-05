//
//  ActivityView.m
//  NewProject
//
//  Created by jiangshiju on 17/2/25.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "ActivityTextView.h"
#import "NSString+Utility.h"

@interface ActivityTextView () <UITextViewDelegate>

@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, weak) id<ActivityTextViewDelegate> agent;

@end

@implementation ActivityTextView

- (instancetype)initWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder agent:(id<ActivityTextViewDelegate>)agent
{
    if (self = [super initWithFrame:frame]) {
        self.placeHolder     = placeHolder;
        self.text            = self.placeHolder;
        self.backgroundColor = [UIColor whiteColor];
        self.textColor       = [ProjectUtility colorWithHexString:@"#8d95af" alpha:0.6f];
        self.delegate        = self;
        self.agent           = agent;
        
        self.textAlignment             = NSTextAlignmentLeft;
        self.autocapitalizationType    = UITextAutocapitalizationTypeNone;
        self.autocorrectionType        = UITextAutocorrectionTypeNo;
        self.spellCheckingType         = UITextSpellCheckingTypeNo;
        self.keyboardType              = UIKeyboardTypeDefault;
        self.returnKeyType             = UIReturnKeyDone;
        self.font                      = [UIFont systemFontOfSize:14.0f];
        
    }
    return self;
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.textColor isEqual:[ProjectUtility colorWithHexString:@"#8d95af" alpha:0.6f]]) {
        self.text = @"";
        self.textColor = [UIColor blackColor];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (![self.text isNotEmpty]) {
        self.text = self.placeHolder;
        self.textColor = [ProjectUtility colorWithHexString:@"#8d95af" alpha:0.6f];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if ([self.agent respondsToSelector:@selector(activityTextViewShouldReturn:)]) {
            return [self.agent activityTextViewShouldReturn:self];
        }
    }
    return YES;
}

@end
