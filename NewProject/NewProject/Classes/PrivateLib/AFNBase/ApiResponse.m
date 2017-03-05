//
//  ApiResponse.m
//  NewProject
//
//  Created by jiangshiju on 2017/3/3.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "ApiResponse.h"
#import "NSObject+MFDictionaryAdapter.h"
#import "MDKJsonParse.h"

@implementation ApiResponse

- (id)initWithRequest:(ApiRequest *)request data:(NSData *)data
{
    if (self = [super init]) {
        self.userInfo = request.userInfo;
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.responseString = string;
        self.responseDic = [string MDKObjectFromJSONString];
    }
    return self;
}

- (id)initWithRequest:(ApiRequest *)request jsonObject:(id)jsonObject
{
    if (self = [super init]) {
        self.userInfo = request.userInfo;
        self.responseString = [jsonObject MDKJSONString];
        self.responseDic = [self.responseString MDKObjectFromJSONString];
    }
    return self;
}

#pragma warning - 添加解析以完善网络请求
- (BOOL)ok
{
    //添加状态码以及和服务器约定好的请求成功的校验
    return YES;
}

- (NSInteger)errorCode
{
    //设置错误码
    return 0;
}

- (NSString *)errorMessage
{
    //设置错误信息
    return @"";
}

- (id)objectForKey:(id)aKey
{
    return [self.responseDic md_objectForKey:aKey defaultValue:nil];
}

@end
