//
//  UserInputView.m
//  NewProject
//
//  Created by jiangshiju on 2017/3/5.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "UserInputView.h"
#import "ProjectBaseTextField.h"
#import "ProjectBaseButton.h"
#import "MDMBProgressHUD+MDKUtility.h"
#import "NSString+Utility.h"

#define kLoginPhoneNumberTextFieldTag     1001
#define kLoginSecurityCodeTextFieldTag    1002

@interface UserInputView () <UITextFieldDelegate>

@property (nonatomic, weak) id<UserInputViewDelegate> delegate;
@property (nonatomic, strong) UIButton *getCodeButton;
@property (nonatomic, strong) ProjectBaseButton *confirmButton;
@property (nonatomic, retain) NSTimer *countDownTimer;
@property (nonatomic, assign) NSInteger countDown;

@end

@implementation UserInputView

/*高度最少150*/
- (instancetype)initWithDelegate:(id<UserInputViewDelegate>)delegate frame:(CGRect)frame confirmButtonTitle:(NSString *)confirmButtonTitle
{
    if (self = [super initWithFrame:frame]) {
        self.delegate = delegate;
        self.countDown = 60;
        [self addSubview:self.phoneNumberTextField];
        [self addSubview:self.securityCodeTextField];
        [self addSubview:self.confirmButton];
        [self.confirmButton setTitle:confirmButtonTitle forState:UIControlStateNormal];
    }
    return self;
}

#pragma mark - Getter
- (ProjectBaseTextField *)phoneNumberTextField
{
    if (!_phoneNumberTextField) {
        ProjectBaseTextField *textField = [[ProjectBaseTextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, 30.0f) placeHolder:@"请输入手机号" andDelegate:self];
        textField.tag = kLoginPhoneNumberTextFieldTag;
        textField.rightView = self.getCodeButton;
        textField.rightViewMode = UITextFieldViewModeAlways;
        textField.keyboardType = UIKeyboardTypePhonePad;
        _phoneNumberTextField = textField;
    }
    return _phoneNumberTextField;
}

- (ProjectBaseTextField *)securityCodeTextField
{
    if (!_securityCodeTextField) {
        ProjectBaseTextField *textField = [[ProjectBaseTextField alloc] initWithFrame:CGRectMake(0.0f, 50.0f, self.frame.size.width, 30.0f) placeHolder:@"请输入验证码" andDelegate:self];
        textField.tag = kLoginSecurityCodeTextFieldTag;
        textField.keyboardType = UIKeyboardTypePhonePad;
        _securityCodeTextField = textField;
    }
    return _securityCodeTextField;
}

- (UIButton *)getCodeButton
{
    if (!_getCodeButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 80.0f,29.0f);
        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        button.backgroundColor = [UIColor clearColor];
        [button setTitleColor:[ProjectUtility colorWithHexString:@"#86a1ff"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(getSecurityCode:) forControlEvents:UIControlEventTouchUpInside];
        self.getCodeButton = button;
    }
    return _getCodeButton;
}

- (NSTimer *)countDownTimer
{
    if (!_countDownTimer) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
        self.countDownTimer = timer;
    }
    return _countDownTimer;
}

- (ProjectBaseButton *)confirmButton
{
    if (!_confirmButton) {
        //这里先不添加名字，由外部通过init来修改
        ProjectBaseButton *button = [ProjectBaseButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(20.0f, 100.0f, self.frame.size.width - 20.0f * 2, 50.0f) title:nil target:self selector:@selector(confirmButtonClicked:)];
        button.enabled = NO;
        _confirmButton = button;
    }
    return _confirmButton;
}

#pragma mark - TargetAction
- (void)getSecurityCode:(UIButton *)button
{
    if ([self.phoneNumberTextField.text isTelephoneNumber]) {
#pragma TODO - 获取验证码接口
        [self.countDownTimer fire];
        [button setTitle:@"重新发送(59s)" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
    } else {
        [MDMBProgressHUD MDshowWarningWithText:@"请输入正确格式的手机号"];
    }
}

- (void)countDown:(NSTimer *)timer
{
    self.countDown --;
    NSString *title = [NSString stringWithFormat:@"重新发送(%lds)",(long)self.countDown];
    [self.getCodeButton setTitle:title forState:UIControlStateNormal];
    
    if (self.countDown < 1) {
        self.countDown = 60;
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
        [self.getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.getCodeButton setTitleColor:[ProjectUtility colorWithHexString:@"#86a1ff"] forState:UIControlStateNormal];
        self.getCodeButton.userInteractionEnabled = YES;
    }
}

- (void)confirmButtonClicked:(ProjectBaseButton *)button
{
    if ([self.phoneNumberTextField.text isTelephoneNumber]) {
        if ([self.securityCodeTextField.text containsNumberOnly]) {
            if ([self.delegate respondsToSelector:@selector(didClickConfirmButton)]) {
                [self.delegate didClickConfirmButton];
            } else {
                DebugLog(DebugLogTypeError, @"UserInputView的代理类没有实现didClickConfirmButton方法");
            }
        } else {
            [MDMBProgressHUD MDshowWarningWithText:@"请输入正确格式的验证码"];
        }
    } else {
        [MDMBProgressHUD MDshowWarningWithText:@"请输入正确格式的手机号"];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phoneNumberTextField) {
        if (self.phoneNumberTextField.text.length >= 11) {
            [self.securityCodeTextField becomeFirstResponder];
            return YES;
        }
    } else {
        if (self.phoneNumberTextField.text.length >= 11 && self.securityCodeTextField.text.length >= 6) {
            if ([self.delegate respondsToSelector:@selector(didClickConfirmButton)]) {
                [self.delegate didClickConfirmButton];
            }
            return YES;
        }
    }
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.securityCodeTextField) {
        if ([string isEqualToString:@""]) {
            self.confirmButton.enabled = NO;
        } else {
            if (self.phoneNumberTextField.text.length >= 11 && self.securityCodeTextField.text.length >= 5) {
                self.confirmButton.enabled = YES;
            } else {
                self.confirmButton.enabled = NO;
            }
        }
        if (textField.text.length >= 6) {
            if ([string isEqualToString:@""]) {
                return YES;
            } else {
                return NO;
            }
        } else {
            return YES;
        }
    } else {
        if ([string isEqualToString:@""]) {
            self.confirmButton.enabled = NO;
        } else {
            if (self.phoneNumberTextField.text.length >= 10 && self.securityCodeTextField.text.length >= 6) {
                self.confirmButton.enabled = YES;
            } else {
                self.confirmButton.enabled = NO;
            }
        }
        if (textField.text.length >= 11) {
            if ([string isEqualToString:@""]) {
                return YES;
            } else {
                return NO;
            }
        } else {
            return YES;
        }
    }
}

@end
