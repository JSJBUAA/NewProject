//
//  AFNApiBase.h
//  NewProject
//
//  Created by jiangshiju on 2017/3/3.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "ApiRequest.h"
#import "ApiResponse.h"

#define kRequestTimeOutValue         10.0f

@interface AFNApiBase : NSObject

#pragma mark - RequestFactory
// 构建一条获得owner授权的请求, timeout单位为second，默认20s
- (ApiRequest *)requestInGetWithURLString:(NSString *)urlString timeout:(NSTimeInterval)timeout;
- (ApiRequest *)requestInPostWithURLString:(NSString *)urlString timeout:(NSTimeInterval)timeout;

#pragma mark - Send Request SEL
- (ApiRequest *)sendApiRequest:(ApiRequest *)request;

@end
