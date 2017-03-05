//
//  RegisterViewController.m
//  NewProject
//
//  Created by jiangshiju on 2017/3/5.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "RegisterViewController.h"
#import "SelectLocationViewController.h"
#import "UserInputView.h"
#import "ProjectBaseTextField.h"
#import "MDMBProgressHUD+MDKUtility.h"

@interface RegisterViewController () <UserInputViewDelegate>

@property (nonatomic, strong) UserInputView *inputView;

@end

@implementation RegisterViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:self.inputView];
}

#pragma mark --------------------------- Getter ---------------------------
- (UIView *)inputView
{
    if (!_inputView) {
        UserInputView *inputView = [[UserInputView alloc] initWithDelegate:self frame:CGRectMake(40.0f, 100.0f, [ProjectUtility getScreenWidth] - 40.0f * 2, 150.0f) confirmButtonTitle:@"下一步"];
        _inputView = inputView;
    }
    return _inputView;
}

#pragma mark --------------------------- 点击方法 ---------------------------
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark --------------------------- 网络请求 ---------------------------

#pragma mark --------------------------- 代理方法 ---------------------------
#pragma mark - UserInputViewDelegate
- (void)didClickConfirmButton
{
    if ([self.inputView.securityCodeTextField.text isEqualToString:@"123456"]) {
        SelectLocationViewController *selectLocationViewController = [[SelectLocationViewController alloc] initWithTitle:@"选择小区" leftButtonTitle:nil rightButtonTitle:@"下一步"];
        [self.navigationController pushViewController:selectLocationViewController animated:YES];
    } else {
        [MDMBProgressHUD MDshowWarningWithText:@"验证码错误"];
    }
}

#pragma mark --------------------------- 公开方法 ---------------------------

#pragma mark --------------------------- 私有方法 ---------------------------

@end
