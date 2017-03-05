//
//  AFNApiBase.m
//  NewProject
//
//  Created by jiangshiju on 2017/3/3.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "AFNApiBase.h"

@implementation AFNApiBase

#pragma TODO - 确定数据格式和错误码等后这里需要修改

#pragma mark - RequestFactory
- (ApiRequest *)requestInGetWithURLString:(NSString *)urlString timeout:(NSTimeInterval)timeout
{
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ApiRequest *request = [ApiRequest requestWithURL:url];
    //需要设置UA的话这里需要添加
    //[request setDefaultUA:[MDKUtility uaString]];
    //[request setDefaultUserAgent];
    //需要绑定令牌的话这里添加
    [request bindToken];
    if (timeout > 0) {
        request.timeoutValue = timeout;
    }
    return request;
}

- (ApiRequest *)requestInPostWithURLString:(NSString *)urlString timeout:(NSTimeInterval)timeout
{
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ApiRequest *request = [ApiRequest requestWithURL:url];
    //需要设置UA的话这里需要添加
    //[request setDefaultUA:[MDKUtility uaString]];
    //[request setDefaultUserAgent];
    //需要绑定令牌的话这里添加
    [request bindToken];
    if (timeout > 0) {
        request.timeoutValue = timeout;
    }
    return request;
}

- (ApiRequest *)sendApiRequest:(ApiRequest *)request
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = request.timeoutValue;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"text/json",@"application/json",nil];
    [manager GET:[request.url absoluteString] parameters:request.postValue progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ApiResponse *response = [[ApiResponse alloc] initWithRequest:request jsonObject:responseObject];
        SEL okSelector = request.okSelector;
        if ([request.target respondsToSelector:okSelector]) {
            [request.target performSelector:okSelector withObject:response];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //解析error为自身的一个errorModel类
        NSLog(@"%@",error);
    }];
    return  request;
}

@end
