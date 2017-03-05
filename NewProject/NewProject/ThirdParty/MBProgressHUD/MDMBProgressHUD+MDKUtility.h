//
//  MDMBProgressHUD+MDKUtility.h
//  libMomoSDK
//
//  Created by jiangshiju on 16/6/2.
//  Copyright © 2016年 immomo. All rights reserved.
//

#import "MDMBProgressHUD.h"

@interface MDMBProgressHUD (MDKUtility)

+ (void)MDshowWarningWithText:(NSString *)text;
+ (void)MDshowWarningWithText:(NSString *)text delegate:(id<MDMBProgressHUDDelegate>)delegate;

@end
