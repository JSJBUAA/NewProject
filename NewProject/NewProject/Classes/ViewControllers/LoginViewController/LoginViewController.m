//
//  LoginViewController.m
//  NewProject
//
//  Created by jiangshiju on 2017/3/5.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UserInputView.h"
#import "MDMBProgressHUD+MDKUtility.h"
#import "ProjectBaseTextField.h"
#import "AppDelegate.h"
#import "ProjectBaseButton.h"

@interface LoginViewController () <UserInputViewDelegate>

@property (nonatomic, strong) UserInputView *inputView;
@property (nonatomic, strong) ProjectBaseButton *questionButton;
@property (nonatomic, strong) ProjectBaseButton *registerButton;

@end

@implementation LoginViewController

#pragma mark --------------------------- View生命周期 ---------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self configUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark --------------------------- 初始化Data ---------------------------
- (void)initData
{
    
}

#pragma mark --------------------------- 注册通知及回调 ---------------------------
- (void)registerNotifyAndCallback
{
    
}

#pragma mark --------------------------- 布局UI ---------------------------
- (void)configUI
{
    [self.mainView addSubview:self.inputView];
    [self.mainView addSubview:self.questionButton];
    [self.mainView addSubview:self.registerButton];
}

#pragma mark --------------------------- Getter ---------------------------
- (UIView *)inputView
{
    if (!_inputView) {
        UserInputView *inputView = [[UserInputView alloc] initWithDelegate:self frame:CGRectMake(40.0f, 100.0f, [ProjectUtility getScreenWidth] - 40.0f * 2, 150.0f) confirmButtonTitle:@"登录"];
        _inputView = inputView;
    }
    return _inputView;
}

- (ProjectBaseButton *)questionButton
{
    if (!_questionButton) {
        ProjectBaseButton *button = [ProjectBaseButton singleUnderlinedButtonWithType:UIButtonTypeCustom frame:CGRectMake(40.0f, 250.0f, 100.0f, 30.0f) title:@"遇到问题?" target:self selector:@selector(questionButtonClicked:)];
        _questionButton = button;
    }
    return _questionButton;
}

- (ProjectBaseButton *)registerButton
{
    if (!_registerButton) {
        ProjectBaseButton *button = [ProjectBaseButton singleUnderlinedButtonWithType:UIButtonTypeCustom frame:CGRectMake([ProjectUtility getScreenWidth] - 40.0f - 100.0f, 300.0f, 100.0f, 30.0f) title:@"注册账号" target:self selector:@selector(registerButtonClicked:)];
        _registerButton = button;
    }
    return _registerButton;
}

#pragma mark --------------------------- 点击方法 ---------------------------

#pragma mark --------------------------- 网络请求 ---------------------------

#pragma mark --------------------------- 代理方法 ---------------------------
#pragma mark - UserInputViewDelegate
- (void)didClickConfirmButton
{
    if ([self.inputView.securityCodeTextField.text isEqualToString:@"123456"]) {
        [((AppDelegate *)[UIApplication sharedApplication].delegate) transferRootToTabBarController];
    } else {
        [MDMBProgressHUD MDshowWarningWithText:@"验证码错误"];
    }
}

#pragma mark --------------------------- 公开方法 ---------------------------

#pragma mark --------------------------- 私有方法 ---------------------------

@end
