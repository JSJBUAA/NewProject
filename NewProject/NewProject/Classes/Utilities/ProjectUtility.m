//
//  ProjectUtility.m
//  NewProject
//
//  Created by jiangshiju on 17/2/21.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "ProjectUtility.h"

@implementation ProjectUtility

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:(float) r / 255.0f green:(float) g / 255.0f blue:(float) b / 255.0f alpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:(float) r / 255.0f green:(float) g / 255.0f blue:(float) b / 255.0f alpha:alpha];
}

+ (CGFloat)getScreenWidth
{
    if ([UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height) {
        return [UIScreen mainScreen].bounds.size.width;
    } else {
        return [UIScreen mainScreen].bounds.size.height;
    }
}

+ (CGFloat)getScreenHeight
{
    if ([UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height) {
        return [UIScreen mainScreen].bounds.size.height;
    } else {
        return [UIScreen mainScreen].bounds.size.width;
    }
}

+ (UIImage *)getSnapShot
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    CGSize size = window.frame.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGRect rec = CGRectMake(0, 0, window.frame.size.width, window.frame.size.height);
    
    [window drawViewHierarchyInRect:rec afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    //图片尺寸
    CGRect rect = CGRectMake(0, 0, 10, 10);
    //填充画笔
    UIGraphicsBeginImageContext(rect.size);
    //根据所传颜色绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    //显示区域
    CGContextFillRect(context, rect);
    // 得到图片信息
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //消除画笔
    UIGraphicsEndImageContext();
    return image;
}

@end
