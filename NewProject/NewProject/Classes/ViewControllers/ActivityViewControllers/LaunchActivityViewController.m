//
//  LaunchActivityViewController.m
//  NewProject
//
//  Created by jiangshiju on 17/2/22.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "LaunchActivityViewController.h"
#import "ActivityTextView.h"
#import "MDKAssetsViewController.h"
#import "MDMBProgressHUD+MDKUtility.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "NSString+Utility.h"
#import "ActivitySettingViewController.h"
#import "NSArray+Safe.h"

@interface LaunchActivityViewController () <ActivityTextViewDelegate,MDKAssetsDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *subjectTextField;
@property (nonatomic, strong) ActivityTextView *descriptionTextView;
@property (nonatomic, strong) UIButton *addImageButton;
@property (nonatomic, strong) NSMutableArray *addedImagesArray;
@property (nonatomic, assign) NSUInteger maxCount;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation LaunchActivityViewController

#pragma mark --------------------------- View生命周期 ---------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self registerNotifyAndCallback];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self removeKeyboardNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark --------------------------- 初始化Data ---------------------------
- (void)initData
{
    self.maxCount = 6;
    self.addedImagesArray = [NSMutableArray array];
}

#pragma mark --------------------------- 注册通知及回调 ---------------------------
- (void)registerNotifyAndCallback
{
    [self registerKeyboardNotification];
}

#pragma mark --------------------------- 布局UI ---------------------------
- (void)configUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:self.titleLabel];
    [self.mainView addSubview:self.subjectTextField];
    [self.mainView addSubview:self.descriptionTextView];
    [self.mainView addSubview:self.addImageButton];
    
    [self.descriptionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descriptionTextView.superview.mas_top).with.offset(CGRectGetMaxY(self.subjectTextField.frame) + 20.0f);
        make.left.equalTo(self.descriptionTextView.superview.mas_left).with.offset(20.0f);
        make.right.equalTo(self.descriptionTextView.superview.mas_right).with.offset(-20.0f);
        make.bottom.equalTo(self.descriptionTextView.superview.mas_bottom).with.offset(-100.0f);
    }];
    
    [self.addImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addImageButton.superview.mas_bottom).with.offset(-25.0f);
        make.left.equalTo(self.addImageButton.superview.mas_right).with.offset(-90.0f);
        make.right.equalTo(self.addImageButton.superview.mas_right).with.offset(-10.0f);
        make.bottom.equalTo(self.addImageButton.superview.mas_bottom).with.offset(-5.0f);
    }];
}

#pragma mark --------------------------- Getter ---------------------------
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [ProjectUtility getScreenWidth], 40.0f)];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:17.0f];
        label.text = @"活动主题";
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UITextField *)subjectTextField
{
    if (!_subjectTextField) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(40.0f, CGRectGetMaxY(self.titleLabel.frame) + 10.0f, [ProjectUtility getScreenWidth] - 40.0f * 2, 30)];
        textField.placeholder = @"请输入活动主题";
        textField.textAlignment = NSTextAlignmentCenter;
        textField.backgroundColor = [UIColor whiteColor];
        textField.layer.borderWidth = 0.3f;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.cornerRadius = 3.0f;
        textField.layer.masksToBounds = YES;
        _subjectTextField = textField;
    }
    return _subjectTextField;
}

- (ActivityTextView *)descriptionTextView
{
    if (!_descriptionTextView) {
        ActivityTextView *textView = [[ActivityTextView alloc] initWithFrame:CGRectZero placeHolder:@"请输入活动内容" agent:self];
        textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textView.layer.borderWidth = 0.3f;
        textView.layer.cornerRadius = 5.0f;
        textView.layer.masksToBounds = YES;
        _descriptionTextView = textView;
    }
    return _descriptionTextView;
}

- (UIButton *)addImageButton
{
    if (!_addImageButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectZero;
        [button setTitle:@"添加照片" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [button addTarget:self action:@selector(addImageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _addImageButton = button;
    }
    return _addImageButton;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView = scrollView;
    }
    return _scrollView;
}

#pragma mark --------------------------- 点击方法 ---------------------------
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)addImageButtonClicked:(UIButton *)button
{
    if (self.addedImagesArray.count >= self.maxCount) {
        [MDMBProgressHUD MDshowWarningWithText:@"最多只允许添加6张图片"];
        return;
    } else {
        MDKAssetsViewController *assetsViewController = [[MDKAssetsViewController alloc] initWithDelegate:self photoPickType:MDKPhotoPickTypeMultiple maxCount:self.maxCount - self.addedImagesArray.count];
        [self presentViewController:assetsViewController animated:YES completion:nil];
    }
}

- (void)rightButtonClicked:(UIButton *)button
{
    if ([self.subjectTextField.text isNotEmpty] && [self.descriptionTextView.text isNotEmpty]) {
        ActivitySettingViewController *settingViewController = [[ActivitySettingViewController alloc] initWithTitle:@"活动设置" leftButtonTitle:@"上一步" rightButtonTitle:@"下一步"];
        [self.navigationController pushViewController:settingViewController animated:YES];
    } else {
        [MDMBProgressHUD MDshowWarningWithText:@"请输入活动主题及活动内容"];
    }
}

#pragma mark --------------------------- 网络请求 ---------------------------

#pragma mark --------------------------- 代理方法 ---------------------------
/*ActivityTextViewDelegate*/
- (BOOL)activityTextViewShouldReturn:(ActivityTextView *)textView
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    return NO;
}

- (void)assetsViewControllerDidCancel:(MDKAssetsViewController *)controller
{
    [self reloadScrollView];
}

- (void)assetsViewController:(MDKAssetsViewController *)controller didFinishPickingImagesArray:(NSArray *)pickedImagesArray
{
    [self.addedImagesArray md_addObjectsFromArraySafe:pickedImagesArray];
    [self reloadScrollView];
}

#pragma mark --------------------------- 公开方法 ---------------------------

#pragma mark --------------------------- 私有方法 ---------------------------
- (void)reloadScrollView
{
    if (self.addedImagesArray.count == 0) {
        return;
    }
    if (self.scrollView.subviews.count >= self.addedImagesArray.count) {
        return;
    }
    if (!self.scrollView.superview) {
        [self.mainView addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView.superview.mas_bottom).with.offset(-95.0f);
            make.left.equalTo(self.scrollView.superview.mas_left).with.offset(20.0f);
            make.right.equalTo(self.scrollView.superview.mas_right).with.offset(-20.0f);
            make.bottom.equalTo(self.scrollView.superview.mas_bottom).with.offset(-30.0f);
        }];
    }
    NSInteger count = 0;
    for (UIView *view in self.scrollView.subviews) {
        if (view.alpha != 0.0f) {
            count++;
        }
    }
    for (NSInteger i = count; i < self.addedImagesArray.count ; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * 70.0f + 10.0f, 2.5f, 60.0f, 60.0f)];
        ALAsset *asset = [self.addedImagesArray objectAtIndex:i];
        ALAssetRepresentation *representation = [asset defaultRepresentation];
        UIImage *fullResolutionImage = [UIImage imageWithCGImage:representation.fullResolutionImage
                                                           scale:1.0f
                                                     orientation:(UIImageOrientation)representation.orientation];
        imageView.image = fullResolutionImage;
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(self.addedImagesArray.count * 70.0f + 20.0f, 0.0f);
}

@end
