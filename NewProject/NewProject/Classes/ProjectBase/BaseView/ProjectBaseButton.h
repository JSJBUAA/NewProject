//
//  ProjectBaseButton.h
//  NewProject
//
//  Created by jiangshiju on 2017/3/5.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectBaseButton : UIButton

//圆角白色字样按钮，可用时蓝色底色，不可用时灰色底色
+ (ProjectBaseButton *)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame title:(NSString *)title target:(id)target selector:(SEL)selector;

//下划线蓝色字样button，无底色
+ (ProjectBaseButton *)singleUnderlinedButtonWithType:(UIButtonType)buttonType frame:(CGRect)frame title:(NSString *)title target:(id)target selector:(SEL)selector;

@end
