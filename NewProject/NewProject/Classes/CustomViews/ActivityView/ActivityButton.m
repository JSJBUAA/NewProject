//
//  ActivityButton.m
//  NewProject
//
//  Created by jiangshiju on 17/2/24.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "ActivityButton.h"

@implementation ActivityButton

+ (ActivityButton *)buttonWithFrame:(CGRect)frame
                              title:(NSString *)title
                             target:(id)target
                             action:(SEL)action
{
    ActivityButton *button = [ActivityButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [button setBackgroundImage:[ProjectUtility createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)setButtonSelected:(BOOL)buttonSelected
{
    _buttonSelected = buttonSelected;
    if (buttonSelected) {
        [self setBackgroundImage:[ProjectUtility createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateNormal];
    } else {
        [self setBackgroundImage:[ProjectUtility createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    }
}

@end
