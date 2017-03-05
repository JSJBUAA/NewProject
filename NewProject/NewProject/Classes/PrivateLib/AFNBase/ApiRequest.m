//
//  ApiRequest.m
//  NewProject
//
//  Created by jiangshiju on 2017/3/3.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "ApiRequest.h"
#import "NSObject+MFDictionaryAdapter.h"

@interface ApiRequest ()

@end

@implementation ApiRequest

+ (id)requestWithURL:(NSURL *)url
{
    ApiRequest *request = [[ApiRequest alloc] init];
    request.url = url;
    return request;
}

- (void)setTarget:(id)target okSelector:(SEL)okSelector errSelector:(SEL)errSelector
{
    self.target = target;
    self.okSelector = okSelector;
    self.errSelector = errSelector;
}

#pragma warning - 添加UA等完善网络请求
- (void)setDefaultUA:(NSString *)uaString
{
    //设置默认UA，看需求
}

- (BOOL)bindToken
{
    //绑定登录令牌以请求接口，看需求
    return YES;
}

- (void)setTimeoutValue:(NSTimeInterval)timeOutValue
{
    if (_timeoutValue == timeOutValue) {
        return;
    } else {
        _timeoutValue = timeOutValue;
    }
}

- (NSMutableDictionary *)postValue
{
    if (!_postValue) {
        _postValue = [NSMutableDictionary dictionary];
    }
    return _postValue;
}

- (void)addPostValue:(id)value forKey:(NSString *)key
{
    [self.postValue md_setObjectSafe:value forKey:key];
}

@end
