//
//  MDMBProgressHUD+MDKUtility.m
//  libMomoSDK
//
//  Created by jiangshiju on 16/6/2.
//  Copyright © 2016年 immomo. All rights reserved.
//

#import "MDMBProgressHUD+MDKUtility.h"

@implementation MDMBProgressHUD (MDKUtility)

+ (void)MDshowWarningWithText:(NSString *)text
{
    [MDMBProgressHUD MDshowWarningWithText:text delegate:nil];
}

+ (void)MDshowWarningWithText:(NSString *)text delegate:(id<MDMBProgressHUDDelegate>)delegate
{
    if (text && ![text isEqualToString:@""]) {
        
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        UIViewController *topVC = rootVC;
        while (topVC.presentedViewController) {
            topVC = topVC.presentedViewController;
        }
        
        //原来直接加在window上横屏会出现问题，window不关注横屏，展示以竖屏为准
        MDMBProgressHUD *hud = [MDMBProgressHUD showHUDAddedTo:topVC.view animated:YES];
        hud.delegate = delegate;
        hud.detailsLabelText = text;
        hud.mode = MDMBProgressHUDModeText;
        hud.dimBackground = NO;
        [hud hide:YES afterDelay:2.0];
    }
}

@end
