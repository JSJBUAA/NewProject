//
//  Define.h
//  NewProject
//
//  Created by jiangshiju on 17/2/23.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#ifndef Define_h
#define Define_h

/*宽度高度部分*/
#define kPhoneTabBarItemWidth              [ProjectUtility getScreenWidth]/4.0f*3.0f/4.0f
#define kPhoneTabBarItemHeight             50.0f
#define kPhoneTabBarCentralItemWidth       [ProjectUtility getScreenWidth]/4.0f

#define kPhoneStatusBarHeight              [[UIApplication sharedApplication] statusBarFrame].size.height
#define kPhoneNavigationBarHeight          (kPhoneStatusBarHeight+50.0f)

/*域名*/
#define kAPIRequestDomain                  @"localhost"

#endif /* Define_h */
