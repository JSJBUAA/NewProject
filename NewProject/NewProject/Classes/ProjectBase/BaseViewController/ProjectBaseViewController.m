//
//  ProjectBaseViewController.m
//  NewProject
//
//  Created by jiangshiju on 17/2/21.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "ProjectBaseViewController.h"
#import "NSString+Utility.h"
#import "CustomTabBarViewController.h"

@interface ProjectBaseViewController ()

@property (nonatomic, copy) NSString *mainTitle;
@property (nonatomic, copy) NSString *leftButtonTitle;
@property (nonatomic, copy) NSString *rightButtonTitle;
@property (nonatomic, strong) UILabel *mainTitleLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation ProjectBaseViewController

#pragma mark --------------------------- View生命周期 ---------------------------
/*初始化方法，title传空不展示，无左右侧按钮*/
- (id)initWithTitle:(NSString *)title
{
    return [self initWithTitle:title leftButtonTitle:nil rightButtonTitle:nil];
}

/*初始化方法，title传空串不展示，左右按钮传空串或nil则不添加按钮*/
- (id)initWithTitle:(NSString *)title
    leftButtonTitle:(NSString *)leftButtonTitle
   rightButtonTitle:(NSString *)rightButtonTitle
{
    if (self = [super init]) {
        self.mainTitle = title;
        self.leftButtonTitle = leftButtonTitle;
        self.rightButtonTitle = rightButtonTitle;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initBaseData];
    [self configBaseUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark --------------------------- 初始化Data ---------------------------
- (void)initBaseData
{
    
}

#pragma mark --------------------------- 注册通知及回调 ---------------------------
/*开启或关闭键盘通知*/
- (void)registerKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    self.view.bounds = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.view.bounds = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

#pragma mark --------------------------- 布局UI ---------------------------
- (void)configBaseUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (!self.navigationController.navigationBar.hidden) {
        self.navigationController.navigationBar.hidden = YES;
    }
    
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.mainView];
    [self configNavigationView];
}

- (void)configNavigationView
{
    if ([self.leftButtonTitle isNotEmpty]) {
        [self.navigationView addSubview:self.leftButton];
    }
    if ([self.rightButtonTitle isNotEmpty]) {
        [self.navigationView addSubview:self.rightButton];
    }
    [self.navigationView addSubview:self.mainTitleLabel];
}

#pragma mark --------------------------- Getter ---------------------------
- (UIView *)navigationView
{
    if (!_navigationView) {
        UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, kPhoneNavigationBarHeight)];
        navigationView.backgroundColor = [ProjectUtility colorWithHexString:@"#4d4dff"];
        _navigationView = navigationView;
    }
    return _navigationView;
}

- (UIView *)mainView
{
    if (!_mainView) {
        UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationView.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.navigationView.frame))];
        mainView.backgroundColor = [UIColor clearColor];
        _mainView = mainView;
    }
    return _mainView;
}

- (UILabel *)mainTitleLabel
{
    if (!_mainTitleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2.0f - 60.0f, 10.0f + kPhoneStatusBarHeight, 120.0f, 30.0f)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:17.0f];
        label.text = self.mainTitle;
        _mainTitleLabel = label;
    }
    return _mainTitleLabel;
}

- (UIButton *)leftButton
{
    if (!_leftButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(20.0f, 10.0f + kPhoneStatusBarHeight, 80.0f, 30.0f);
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:self.leftButtonTitle forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton = button;
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake([ProjectUtility getScreenWidth] - 100.0f, 10.0f + kPhoneStatusBarHeight, 80.0f, 30.0f);
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:self.rightButtonTitle forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton = button;
    }
    return _rightButton;
}

#pragma mark --------------------------- 点击方法 ---------------------------
/*左按钮点击响应，一般是页面回退，开放给子类覆写*/
//如果作用只是回退可以不覆写
- (void)leftButtonClicked:(UIButton *)button
{
    if (self.navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/*右按钮点击响应，开放给子类覆写*/
- (void)rightButtonClicked:(UIButton *)button
{
    
}

#pragma mark --------------------------- 网络请求 ---------------------------

#pragma mark --------------------------- 代理方法 ---------------------------

#pragma mark --------------------------- 公开方法 ---------------------------
- (void)resetLeftButtonTitle:(NSString *)leftButtonTitle
{
    self.leftButtonTitle = leftButtonTitle;
    self.leftButton.titleLabel.text = self.leftButtonTitle;
}

- (void)resetRightButtonTitle:(NSString *)rightButtonTitle
{
    self.rightButtonTitle = rightButtonTitle;
    self.rightButton.titleLabel.text = self.rightButtonTitle;
}

- (void)hideTabBar
{
    if (self.navigationController.tabBarController) {
        if (!((CustomTabBarViewController *)self.navigationController.tabBarController).customTabBar.hidden) {
            ((CustomTabBarViewController *)self.navigationController.tabBarController).customTabBar.hidden = YES;
        }
    }
}

- (void)showTabBar
{
    if (self.navigationController.tabBarController) {
        if (((CustomTabBarViewController *)self.navigationController.tabBarController).customTabBar.hidden) {
            ((CustomTabBarViewController *)self.navigationController.tabBarController).customTabBar.hidden = NO;
        }
    }
}

/*当前控制器获取或交换TabBar*/
- (void)fetchCustomTabBar
{
    [self.view addSubview:((CustomTabBarViewController *)self.navigationController.tabBarController).customTabBar];
}

- (void)transferCustomBarToTabBarController
{
    CustomTabBarViewController *tabBarController = (CustomTabBarViewController *)self.navigationController.tabBarController;
    [tabBarController.view addSubview:tabBarController.customTabBar];
}

#pragma mark --------------------------- 私有方法 ---------------------------


@end
