//
//  CustomTabBarItem.h
//  NewProject
//
//  Created by jiangshiju on 17/2/21.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBarItem : UIView

@property (nonatomic, assign) NSUInteger index;

- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage
                        title:(NSString *)title;

- (void)addTarget:(id)target touchInsideAction:(SEL)action;

/*设置为选中状态，外部调用通常用于开启后第一屏的选中（这时候用户还没有点击）*/
- (void)setSelectedStatus;
/*取消选中状态，点击一个新的后，将旧的选中状态取消*/
- (void)cancelSelectedStatus;

@end
