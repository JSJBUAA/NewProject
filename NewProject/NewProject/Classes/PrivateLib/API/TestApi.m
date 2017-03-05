//
//  TestApi.m
//  NewProject
//
//  Created by jiangshiju on 2017/3/3.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "TestApi.h"

@implementation TestApi

static TestApi *api = nil;

+ (id)defaultTest
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        api = [[TestApi alloc] init];
    });
    return api;
}

- (ApiRequest *)getNearByGroupsInfoWithTarget:(id)target
                                   okSelector:(SEL)okSelector
                                errorSelector:(SEL)errorSelector
{
    NSString *testStr = [NSString stringWithFormat:@"/nearbyGroups%d",arc4random()%3];
    ApiRequest *request = [self requestInPostWithURLString:HTTPURLString_API(testStr) timeout:kRequestTimeOutValue];
    [request setTarget:target okSelector:okSelector errSelector:errorSelector];
    return [self sendApiRequest:request];
}

@end
