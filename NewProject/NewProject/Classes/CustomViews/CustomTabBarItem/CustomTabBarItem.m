//
//  CustomTabBarItem.m
//  NewProject
//
//  Created by jiangshiju on 17/2/21.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "CustomTabBarItem.h"

@interface CustomTabBarItem ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, weak)   id target;
@property (nonatomic, assign)   SEL action;

@end

@implementation CustomTabBarItem

- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage
                        title:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        self.index = 0;
        self.image = image;
        self.selectedImage = selectedImage;
        self.title = title;
        self.backgroundColor = [ProjectUtility colorWithHexString:@"#e8e8ff"];
        [self configCustomTabBarUI];
    }
    return self;
}

#pragma warning - 需要用Masonry适配
- (UIImageView *)imageView
{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 30.0f) / 2.0f, 5.0f, 30.0f, 30.0f)];
        imageView.image = self.image;
        _imageView = imageView;
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 30.0f) / 2.0f, 37.5f, 30.0f, 10)];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:11.0f];
        label.text = self.title;
        _titleLabel = label;
    }
    return _titleLabel;
}

- (void)configCustomTabBarUI
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapInCustomTabBarItem:)];
    [self addGestureRecognizer:tap];
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
}

- (void)didTapInCustomTabBarItem:(UIGestureRecognizer *)gesture
{
    [self setSelectedStatus];
    SEL action = self.action;
    if ([self.target respondsToSelector:action]) {
        [self.target performSelector:action withObject:self];
    }
}

- (void)addTarget:(id)target touchInsideAction:(SEL)action
{
    self.target = target;
    self.action = action;
}

- (void)setSelectedStatus
{
    self.imageView.image = self.selectedImage;
    self.titleLabel.textColor = [ProjectUtility colorWithHexString:@"4d4dff"];
}

- (void)cancelSelectedStatus
{
    self.imageView.image = self.image;
    self.titleLabel.textColor = [UIColor lightGrayColor];
}

@end
