//
//  UserInputView.h
//  NewProject
//
//  Created by jiangshiju on 2017/3/5.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserInputView;
@class ProjectBaseTextField;
@protocol UserInputViewDelegate <NSObject>

- (void)didClickConfirmButton;

@end

@interface UserInputView : UIView

@property (nonatomic, strong) ProjectBaseTextField *phoneNumberTextField;
@property (nonatomic, strong) ProjectBaseTextField *securityCodeTextField;

/*高度最少150*/
- (instancetype)initWithDelegate:(id<UserInputViewDelegate>)delegate frame:(CGRect)frame confirmButtonTitle:(NSString *)confirmButtonTitle;

@end
