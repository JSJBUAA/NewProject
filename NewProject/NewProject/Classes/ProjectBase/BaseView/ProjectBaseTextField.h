//
//  ProjectBaseTextField.h
//  NewProject
//
//  Created by jiangshiju on 2017/3/5.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectBaseTextField : UITextField

- (instancetype)initWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder andDelegate:(id<UITextFieldDelegate>)delegate;

@end
