//
//  NSObject+MFDictionaryAdapter.m
//  MomoChat
//
//  Created by Latermoon on 12-9-16.
//  Copyright (c) 2012年 wemomo.com. All rights reserved.
//

#import "NSObject+MFDictionaryAdapter.h"
#import "MFDictionaryAccessor.h"

@implementation NSObject (MFDictionaryAdapter)

#pragma mark - Wrap for objectForKey:aKey
- (id)md_objectForKey:(NSString *)aKey defaultValue:(id)value
{
    /* 协议检查 */
    if ([self conformsToProtocol:@protocol(MFDictionaryAccessor)]) {
        id obj = [(id<MFDictionaryAccessor>)self objectForKey:(id)aKey];
        return obj != nil ? obj : value;
    } else if ([self isKindOfClass:[NSDictionary class]]) {
        id obj = [(NSDictionary *)self objectForKey:aKey];
        return obj != nil ? obj : value;
    } else {
        NSLog(@"Error, %@ not conformsToProtocol MFDictionaryAccessor", self);
        return nil;
    }
}

- (NSString *)md_stringForKey:(NSString *)aKey defaultValue:(NSString *)value
{
//    id returnObj = [self md_objectForKey:aKey defaultValue:value];
//    if ([returnObj isKindOfClass:[NSString class]]) {
//        return returnObj;
//    } else {
//        NSLog(@"Error, stringForKey returnObj is error value = %@, key = %@", returnObj, aKey);
//        return value;
//    }
    //兼容任何类型
    return [NSString stringWithFormat:@"%@",[self md_objectForKey:aKey defaultValue:value]];
}

- (NSArray *)md_arrayForKey:(NSString *)aKey defaultValue:(NSArray *)value
{
    id returnObj = [self md_objectForKey:aKey defaultValue:value];
    if ([returnObj isKindOfClass:[NSArray class]]) {
        return returnObj;
    } else {
        NSLog(@"Error, arrayForKey returnObj is error value = %@, key = %@", returnObj, aKey);
        return value;
    }
}

- (NSDictionary *)md_dictionaryForKey:(NSString *)aKey defaultValue:(NSDictionary *)value
{
    id returnObj = [self md_objectForKey:aKey defaultValue:value];
    if ([returnObj isKindOfClass:[NSDictionary class]]) {
        return returnObj;
    } else {
        NSLog(@"Error, dictionaryForKey returnObj is error value = %@, key = %@", returnObj, aKey);
        return value;
    }
}

- (NSData *)md_dataForKey:(NSString *)aKey defaultValue:(NSData *)value
{
    id returnObj = [self md_objectForKey:aKey defaultValue:value];
    if ([returnObj isKindOfClass:[NSData class]]) {
        return returnObj;
    } else {
        NSLog(@"Error, dataForKey returnObj is error value = %@, key = %@", returnObj, aKey);
        return value;
    }
}

- (NSNumber *)md_numberForKey:(NSString *)aKey defaultValue:(NSNumber *)value
{
    id returnObj = [self md_objectForKey:aKey defaultValue:value];
    if ([returnObj isKindOfClass:[NSNumber class]]) {
        return returnObj;
    } else {
        NSLog(@"Error, numberForKey returnObj is error value = %@, key = %@", returnObj, aKey);
        return value;
    }
}

- (NSUInteger)md_unsignedIntegerForKey:(NSString *)aKey defaultValue:(NSUInteger)value
{
    NSInteger returnNum = [self md_integerForKey:aKey defaultValue:value];
    if (returnNum >= 0) {
        return returnNum;
    } else {
        NSLog(@"Error, unsignedIntegerForKey returnObj is error value = %d, key = %@", (int)returnNum, aKey);
        return value;
    }
}

- (NSInteger)md_integerForKey:(NSString *)aKey defaultValue:(NSInteger)value
{
    id returnObj = [self md_objectForKey:aKey defaultValue:nil];
    if ([returnObj isKindOfClass:[NSNumber class]] || [returnObj isKindOfClass:[NSString class]]) {
        return [returnObj integerValue];
    } else {
        NSLog(@"Error, integerForKey returnObj is error value = %@, key = %@", returnObj, aKey);
        return value;
    }
}

- (float)md_floatForKey:(NSString *)aKey defaultValue:(float)value
{
    id returnObj = [self md_objectForKey:aKey defaultValue:nil];
    if ([returnObj isKindOfClass:[NSNumber class]] || [returnObj isKindOfClass:[NSString class]]) {
        return [returnObj floatValue];
    } else {
        NSLog(@"Error, floatForKey returnObj is error value = %@, key = %@", returnObj, aKey);
        return value;
    }
}

- (double)md_doubleForKey:(NSString *)aKey defaultValue:(double)value
{
    id returnObj = [self md_objectForKey:aKey defaultValue:nil];
    if ([returnObj isKindOfClass:[NSNumber class]] || [returnObj isKindOfClass:[NSString class]]) {
        return [returnObj doubleValue];
    } else {
        NSLog(@"Error, doubleForKey returnObj is error value = %@, key = %@", returnObj, aKey);
        return value;
    }
}

- (long long)md_longLongValueForKey:(NSString *)aKey defaultValue:(long long)value
{
    id returnObj = [self md_objectForKey:aKey defaultValue:nil];
    if ([returnObj isKindOfClass:[NSNumber class]] || [returnObj isKindOfClass:[NSString class]]) {
        return [returnObj longLongValue];
    } else {
        NSLog(@"Error, longLongValueForKey returnObj is error value = %@, key = %@", returnObj, aKey);
        return value;
    }
}

- (BOOL)md_boolForKey:(NSString *)aKey defaultValue:(BOOL)value
{
    id returnObj = [self md_objectForKey:aKey defaultValue:nil];
    if ([returnObj isKindOfClass:[NSNumber class]] || [returnObj isKindOfClass:[NSString class]]) {
        return [returnObj boolValue];
    } else {
        NSLog(@"Error, boolForKey returnObj is error value = %@, key = %@", returnObj, aKey);
        return value;
    }
}

- (NSDate *)md_dateForKey:(NSString *)aKey defaultValue:(NSDate *)value
{
    id returnObj = [self md_objectForKey:aKey defaultValue:nil];
    if ([returnObj isKindOfClass:[NSDate class]]) {
        return returnObj;
    } else {
        NSLog(@"Error, boolForKey returnObj is error value = %@, key = %@", returnObj, aKey);
        return value;
    }
}

#pragma mark - Wrap for setObject:value forKey:aKey
- (void)md_setObjectSafe:(id)value forKey:(id)aKey
{
    if (!value || !aKey) {
//        //DLog(DT_all, @"nil value(%@) or key(%@)", value, aKey);
        return;
    }
    if ([self conformsToProtocol:@protocol(MFDictionaryAccessor)]) {
        [(id<MFDictionaryAccessor>)self setObject:(id)value forKey:(id)aKey];
    } else if ([self isKindOfClass:[NSMutableDictionary class]]) {
        [(NSMutableDictionary *)self setObject:(id)value forKey:(id)aKey];
    } else {
        NSLog(@"Error, %@ not conformsToProtocol MFDictionaryAccessor", self);
    }
}

- (void)md_setString:(NSString *)value forKey:(NSString *)aKey
{
    [self md_setObjectSafe:value forKey:aKey];
}

- (void)md_setNumber:(NSNumber *)value forKey:(NSString *)aKey
{
    [self md_setObjectSafe:value forKey:aKey];
}

- (void)md_setInteger:(NSInteger)value forKey:(NSString *)aKey
{
    [self md_setNumber:[NSNumber numberWithInteger:value] forKey:aKey];
}

- (void)md_setFloat:(float)value forKey:(NSString *)aKey
{
    [self md_setNumber:[NSNumber numberWithFloat:value] forKey:aKey];
}

- (void)md_setDouble:(double)value forKey:(NSString *)aKey
{
    [self md_setNumber:[NSNumber numberWithDouble:value] forKey:aKey];
}

- (void)md_setLongLongValue:(long long)value forKey:(NSString *)aKey
{
    [self md_setNumber:[NSNumber numberWithLongLong:value] forKey:aKey];
}

- (void)md_setBool:(BOOL)value forKey:(NSString *)aKey
{
    [self md_setNumber:[NSNumber numberWithBool:value] forKey:aKey];
}

@end
