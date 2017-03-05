//
//  NSString+Utility.m
//  NewProject
//
//  Created by jiangshiju on 17/2/21.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "NSString+Utility.h"

@implementation NSString (Utility)

- (BOOL)isNotEmpty
{
    // 如果是nil调用时必定是NO，因此只需要判断empty
    return [self isKindOfClass:[NSString class]] && [self length] > 0;
}

- (BOOL)isTelephoneNumber
{
    
    NSString *telePhoneNumber = @"^1[0-9]{10}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",telePhoneNumber];
    return [predicate evaluateWithObject:self];
}

- (BOOL)containsNumberOnly
{
    if (self == nil) {
        return NO;
    }
    if ([self length] == 0) {
        return NO;
    }
    BOOL flag = YES;
    for (int i = 0 ; i < [self length]; i++) {
        if ([self characterAtIndex:i] > '9' || [self characterAtIndex:i] < '0') {
            flag = NO;
        }
    }
    return flag;
}

@end
