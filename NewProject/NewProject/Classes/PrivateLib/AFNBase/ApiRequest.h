//
//  ApiRequest.h
//  NewProject
//
//  Created by jiangshiju on 2017/3/3.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiRequest : NSObject

@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL okSelector;
@property (nonatomic, assign) SEL errSelector;
@property (nonatomic, assign) NSTimeInterval timeoutValue;
@property (nonatomic, strong) NSMutableDictionary *postValue;

+ (id)requestWithURL:(NSURL *)url;
- (void)setTarget:(id)target okSelector:(SEL)okSelector errSelector:(SEL)errSelector;
- (void)setDefaultUA:(NSString *)uaString;
- (BOOL)bindToken;
- (void)setTimeoutValue:(NSTimeInterval)timeOutValue;
- (void)addPostValue:(id)value forKey:(NSString *)key;

@end
