//
//  ProjectUtility.h
//  NewProject
//
//  Created by jiangshiju on 17/2/21.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface ProjectUtility : NSObject

/*十六进制颜色色值字符串转换为UIColor*/
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;

+ (CGFloat)getScreenWidth;

+ (CGFloat)getScreenHeight;

/*在任意位置获取当前截屏*/
+ (UIImage *)getSnapShot;

/*根据颜色获取纯色的UIImage*/
+ (UIImage *)createImageWithColor:(UIColor *)color;

@end
