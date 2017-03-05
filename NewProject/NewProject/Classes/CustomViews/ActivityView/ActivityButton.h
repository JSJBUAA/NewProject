//
//  ActivityButton.h
//  NewProject
//
//  Created by jiangshiju on 17/2/24.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityButton : UIButton

@property (nonatomic, assign) BOOL buttonSelected;

+ (ActivityButton *)buttonWithFrame:(CGRect)frame
                              title:(NSString *)title
                             target:(id)target
                             action:(SEL)action;

@end
