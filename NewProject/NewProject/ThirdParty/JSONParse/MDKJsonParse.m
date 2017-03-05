//
//  MDKJsonParse.m
//  MDKJsonParsePro
//
//  Created by PanDehua on 15/10/29.
//  Copyright (c) 2015年 PanDehua. All rights reserved.
//

#import "MDKJsonParse.h"

@interface MDKJsonParse : NSObject

@end

@implementation MDKJsonParse

@end

#pragma mark  JsonString -> NSDictionary、NSArray
@implementation  NSString (MDKJSONDeserializing)

- (id)MDKObjectFromJSONString
{
    id object = [self objectFromJSONStringWithOptions:NSJSONReadingAllowFragments];
    
    return object;
}

- (id)MDKMutableObjectFromJSONString
{
    id object = [self objectFromJSONStringWithOptions:NSJSONReadingMutableContainers];
    
    return object;
}

- (id)objectFromJSONStringWithOptions:(NSJSONReadingOptions)option
{
    return [NSJSONSerialization JSONObjectWithData:[self MDKStringToData] options:option error:nil];
}

- (NSData *)MDKStringToData
{
    return  [self dataUsingEncoding:NSUTF8StringEncoding];
}

@end

#pragma mark  JsonData -> NSDictionary、NSArray
@implementation  NSData (MDKJSONDeserializing)

- (id)MDKObjectFromJSONData
{
    NSString *result = [[NSString alloc] initWithData:self  encoding:NSUTF8StringEncoding];
    
    id object = [result MDKObjectFromJSONString];
    
    return object;
}

- (id)MDKMutableObjectFromJSONData
{
    NSString *result = [[NSString alloc] initWithData:self  encoding:NSUTF8StringEncoding];
    
    id object = [result MDKMutableObjectFromJSONString];
    
    return object;
}

@end


#pragma mark NSDictionary -> Json
@implementation  NSDictionary (MDKJSONSerializing)

- (NSData *)MDKJSONData
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        return  [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    }
    return [NSData data];
}

- (NSString *)MDKJSONString
{
    NSString *jsonStr = [[NSString alloc] initWithData:[self MDKJSONData] encoding:NSUTF8StringEncoding];
    
    return [jsonStr stringByReplacingOccurrencesOfString:@"\n " withString:@""];
}

@end

#pragma mark NSArray -> Json
@implementation  NSArray (MDKJSONSerializing)

- (NSData *)MDKJSONData
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        return  [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    }
    return [NSData data];
}

- (NSString *)MDKJSONString
{
    NSString *jsonStr = [[NSString alloc] initWithData:[self MDKJSONData] encoding:NSUTF8StringEncoding];
    
    return [jsonStr stringByReplacingOccurrencesOfString:@"\n " withString:@""];
}

@end



