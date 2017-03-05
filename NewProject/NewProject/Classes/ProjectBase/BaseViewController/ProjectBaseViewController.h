//
//  ProjectBaseViewController.h
//  NewProject
//
//  Created by jiangshiju on 17/2/21.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

/*理论上所有ViewController的基类*/


#import <UIKit/UIKit.h>

@interface ProjectBaseViewController : UIViewController

@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) UIView *mainView;

/*初始化方法，title传空不展示，无左右侧按钮*/
- (id)initWithTitle:(NSString *)title;

/*初始化方法，title传空串不展示，左右按钮传空串或nil则不添加按钮*/
- (id)initWithTitle:(NSString *)title leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle;

- (void)resetLeftButtonTitle:(NSString *)leftButtonTitle;
- (void)resetRightButtonTitle:(NSString *)rightButtonTitle;

/*左按钮点击响应，一般是页面回退，开放给子类覆写*/
//如果作用只是回退可以不覆写
- (void)leftButtonClicked:(UIButton *)button;

/*右按钮点击响应，开放给子类覆写*/
- (void)rightButtonClicked:(UIButton *)button;

/*隐藏和显示TabBar*/
- (void)hideTabBar;
- (void)showTabBar;

/*当前控制器获取或交换TabBar*/
- (void)fetchCustomTabBar;
- (void)transferCustomBarToTabBarController;

/*开启或关闭键盘通知*/
//安全起见请成对使用，例如在ViewController的viewWillDisappear中remove
- (void)registerKeyboardNotification;
- (void)removeKeyboardNotification;

@end
