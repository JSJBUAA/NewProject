//
//  ProjectBaseButton.m
//  NewProject
//
//  Created by jiangshiju on 2017/3/5.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "ProjectBaseButton.h"

@implementation ProjectBaseButton

+ (ProjectBaseButton *)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame title:(NSString *)title target:(id)target selector:(SEL)selector
{
    ProjectBaseButton *button = [ProjectBaseButton buttonWithType:buttonType];
    button.frame = frame;
    [button setBackgroundImage:[ProjectUtility createImageWithColor:[ProjectUtility colorWithHexString:@"#86a1ff"]] forState:UIControlStateNormal];
    [button setBackgroundImage:[ProjectUtility createImageWithColor:[ProjectUtility colorWithHexString:@"#e6e6e6"]] forState:UIControlStateDisabled];
    button.layer.cornerRadius = frame.size.height / 2.0f;
    button.layer.masksToBounds = YES;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (ProjectBaseButton *)singleUnderlinedButtonWithType:(UIButtonType)buttonType frame:(CGRect)frame title:(NSString *)title target:(id)target selector:(SEL)selector
{
    ProjectBaseButton *button = [ProjectBaseButton buttonWithType:buttonType];
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    NSMutableAttributedString *titleAttributed = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[ProjectUtility colorWithHexString:@"#86a1ff"],NSFontAttributeName:[UIFont systemFontOfSize:13.0f],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
    [button setAttributedTitle:titleAttributed forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
