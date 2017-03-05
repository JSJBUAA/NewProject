//
//  NSString+Utility.h
//  NewProject
//
//  Created by jiangshiju on 17/2/21.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utility)

/*字符串不为空*/
- (BOOL)isNotEmpty;

/*字符串是否是手机号的简单校验*/
- (BOOL)isTelephoneNumber;

/*字符串是否只含有数字*/
- (BOOL)containsNumberOnly;

@end
