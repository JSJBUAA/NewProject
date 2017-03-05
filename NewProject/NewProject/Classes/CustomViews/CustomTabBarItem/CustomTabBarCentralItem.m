//
//  CustomTabBarCentralItem.m
//  NewProject
//
//  Created by jiangshiju on 17/2/21.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "CustomTabBarCentralItem.h"

@implementation CustomTabBarCentralItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    CGFloat beginning_x = 0.0f;
    CGFloat beginning_y = 10.0f;
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    CGContextMoveToPoint(context, beginning_x, beginning_y);
    CGContextAddQuadCurveToPoint(context, width / 2.0f, -10.0f, width, 10.0f);
    CGContextAddLineToPoint(context, width, height);
    CGContextAddLineToPoint(context, 0.0f, height);
    
    CGContextClosePath(context);
    
    CGContextSetFillColorWithColor(context, [ProjectUtility colorWithHexString:@"#e8e8ff"].CGColor);
    CGContextFillPath(context);
}

@end
