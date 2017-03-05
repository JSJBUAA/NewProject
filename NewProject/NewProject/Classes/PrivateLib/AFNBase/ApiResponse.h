//
//  ApiResponse.h
//  NewProject
//
//  Created by jiangshiju on 2017/3/3.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiRequest.h"
#import "MFDictionaryAccessor.h"

@interface ApiResponse : NSObject <MFDictionaryAccessor>

@property (nonatomic, copy) NSString *responseString;
@property (nonatomic, strong) NSDictionary *responseDic;
@property (nonatomic, strong) NSDictionary *userInfo;

- (id)initWithRequest:(ApiRequest *)request data:(NSData *)data;
- (id)initWithRequest:(ApiRequest *)request jsonObject:(id)jsonObject;

- (BOOL)ok;
- (NSInteger)errorCode;
- (NSString *)errorMessage;

- (id)objectForKey:(id)aKey;

@end
