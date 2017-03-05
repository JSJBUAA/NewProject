//
//  ProjectBaseTextField.m
//  NewProject
//
//  Created by jiangshiju on 2017/3/5.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "ProjectBaseTextField.h"

@implementation ProjectBaseTextField

- (instancetype)initWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder andDelegate:(id<UITextFieldDelegate>)delegate
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        UIColor *lightGrayColor = [ProjectUtility colorWithHexString:@"#8d95af" alpha:0.6f];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSForegroundColorAttributeName:lightGrayColor}];
        self.delegate = delegate;
        self.textColor = [ProjectUtility colorWithHexString:@"#2c3349"];
        self.textAlignment = NSTextAlignmentLeft;
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.font = [UIFont systemFontOfSize:15.0f];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5f, frame.size.width, 0.5f)];
        lineView.backgroundColor = [ProjectUtility colorWithHexString:@"#8d95af"];
        lineView.alpha = 0.6f;
        [self addSubview:lineView];
    }
    return self;
}

@end
