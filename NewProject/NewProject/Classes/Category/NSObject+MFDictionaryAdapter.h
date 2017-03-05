//
//  NSObject+MFDictionaryAdapter.h
//  MomoChat
//
//  Created by Latermoon on 12-9-16.
//  Copyright (c) 2012年 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 实现了MFDictionaryAccessor协议的类可使用下列方法
 */
@interface NSObject (MFDictionaryAdapter)

#pragma mark - Wrap for objectForKey:aKey
- (id)md_objectForKey:(NSString *)aKey defaultValue:(id)value;
- (NSString *)md_stringForKey:(NSString *)aKey defaultValue:(NSString *)value;
- (NSArray *)md_arrayForKey:(NSString *)aKey defaultValue:(NSArray *)value;
- (NSDictionary *)md_dictionaryForKey:(NSString *)aKey defaultValue:(NSDictionary *)value;
- (NSData *)md_dataForKey:(NSString *)aKey defaultValue:(NSData *)value;
- (NSUInteger)md_unsignedIntegerForKey:(NSString *)aKey defaultValue:(NSUInteger)value;
- (NSInteger)md_integerForKey:(NSString *)aKey defaultValue:(NSInteger)value;
- (float)md_floatForKey:(NSString *)aKey defaultValue:(float)value;
- (double)md_doubleForKey:(NSString *)aKey defaultValue:(double)value;
- (long long)md_longLongValueForKey:(NSString *)aKey defaultValue:(long long)value;
- (BOOL)md_boolForKey:(NSString *)aKey defaultValue:(BOOL)value;
- (NSDate *)md_dateForKey:(NSString *)aKey defaultValue:(NSDate *)value;
- (NSNumber *)md_numberForKey:(NSString *)aKey defaultValue:(NSNumber *)value;

#pragma mark - Wrap for setObject:value forKey:aKey
- (void)md_setObjectSafe:(id)value forKey:(id)aKey;
- (void)md_setString:(NSString *)value forKey:(NSString *)aKey;
- (void)md_setNumber:(NSNumber *)value forKey:(NSString *)aKey;
- (void)md_setInteger:(NSInteger)value forKey:(NSString *)aKey;
- (void)md_setFloat:(float)value forKey:(NSString *)aKey;
- (void)md_setDouble:(double)value forKey:(NSString *)aKey;
- (void)md_setLongLongValue:(long long)value forKey:(NSString *)aKey;
- (void)md_setBool:(BOOL)value forKey:(NSString *)aKey;

@end
