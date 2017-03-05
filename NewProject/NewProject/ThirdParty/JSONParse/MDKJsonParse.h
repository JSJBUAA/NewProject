//
//  MDKJsonParse.h
//  MDKJsonParsePro
//
//  Created by PanDehua on 15/10/29.
//  Copyright (c) 2015年 PanDehua. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark  Json -> NSDictionary、NSArray、NSData
@interface NSString (MDKJSONDeserializing)

/**
 * Json字符串 转换 不可变的对象
 *
 * 注意: 可解析最外层不是NSArray或者NSDictionary的字符串
 *
 */
- (id)MDKObjectFromJSONString;

/**
 * Json字符串 转换 可变的对象
 */
- (id)MDKMutableObjectFromJSONString;

@end

@interface NSData (MDKJSONDeserializing)

/**
 * JsonData 转换 不可变的对象
 *
 * 注意: 可解析最外层不是NSArray或者NSDictionary的字符串
 *
 */
- (id)MDKObjectFromJSONData;

/**
 * JsonData 转换 可变的对象
 */
- (id)MDKMutableObjectFromJSONData;

@end


#pragma mark  NSDictionary、NSArray、NSString -> Json
@interface NSDictionary (MDKJSONSerializing)

/**
 * NSDictionary 转换 JsonData
 *
 */
- (NSData *)MDKJSONData;

/**
 * NSDictionary 转换 JSONString
 *
 */
- (NSString *)MDKJSONString;

@end


@interface NSArray (MDKJSONSerializing)

/**
 * NSArray 转换 JsonData
 *
 */
- (NSData *)MDKJSONData;

/**
 * NSArray 转换 JSONString
 *
 */
- (NSString *)MDKJSONString;

@end
