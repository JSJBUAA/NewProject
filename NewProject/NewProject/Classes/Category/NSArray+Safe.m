//
//  NSArray+Safe.m
//  MomoChat
//
//  Created by 杨 红林 on 13-7-4.
//  Copyright (c) 2013年 wemomo.com. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

- (id)md_objectAtIndex:(NSUInteger)index kindOfClass:(Class)aClass
{
    if (index < [self count]) {
        id obj = [self objectAtIndex:index];
        return [obj isKindOfClass:aClass] ? obj : nil;
    } else {
        //DLog(DT_all, @"the index is out boundary of array");
    }
    
    return nil;
}

- (id)md_objectAtIndex:(NSUInteger)index memberOfClass:(Class)aClass
{
    if (index < [self count]) {
        id obj = [self objectAtIndex:index];
        return [obj isMemberOfClass:aClass] ? obj : nil;
    } else {
        //DLog(DT_all, @"the index is out boundary of array");
    }
    
    return nil;
}

- (id)md_objectAtIndex:(NSUInteger)index defaultValue:(id)value
{
    id obj = nil;
    if (index < [self count]) {
        obj = [self objectAtIndex:index];
        if (obj == [NSNull null]) {
            //DLog(DT_all, @"objct at index is null");
            return value;
        }
    }
    
    return nil == obj ? value : obj;
}

- (NSString *)md_stringAtIndex:(NSUInteger)index defaultValue:(NSString *)value
{
    NSString *str = [self md_objectAtIndex:index kindOfClass:[NSString class]];
    return nil == str ? value : str;
}

- (NSNumber *)md_numberAtIndex:(NSUInteger)index defaultValue:(NSNumber *)value
{
    NSNumber *number = [self md_objectAtIndex:index kindOfClass:[NSNumber class]];
    return nil == number ? value : number;
}
- (NSDictionary *)md_dictionaryAtIndex:(NSUInteger)index defaultValue:(NSDictionary *)value
{
    NSDictionary *dict = [self md_objectAtIndex:index kindOfClass:[NSDictionary class]];
    return nil == dict ? value : dict;
}
- (NSArray *)md_arrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)value
{
    NSArray *array = [self md_objectAtIndex:index kindOfClass:[NSArray class]];
    return nil == array ? value : array;
}

- (NSData *)md_dataAtIndex:(NSUInteger)index defaultValue:(NSData *)value
{
    NSData *data = [self md_objectAtIndex:index kindOfClass:[NSData class]];
    return nil == data ? value : data;
}

- (NSDate *)md_dateAtIndex:(NSUInteger)index defaultValue:(NSDate *)value
{
    NSDate *date = [self md_objectAtIndex:index kindOfClass:[NSDate class]];
    return nil == date ? value : date;
}

- (float)md_floatAtIndex:(NSUInteger)index defaultValue:(float)value
{
    float f = value;
    if (index < [self count]) {
        id obj = [self objectAtIndex:index];
        f = [obj respondsToSelector:@selector(floatValue)] ? [obj floatValue] : value;
    } else {
        //DLog(DT_all, @"the index is out of boundary of array");
    }
    
    return f;
}

- (double)md_doubleAtIndex:(NSUInteger)index defaultValue:(double)value
{
    double d = value;
    if (index < [self count]) {
        id obj = [self objectAtIndex:index];
        d = [obj respondsToSelector:@selector(doubleValue)] ? [obj doubleValue] : value;
    } else {
        //DLog(DT_all, @"the index is out of boundary of array");
    }
    
    return d;
}

- (NSInteger)md_integerAtIndex:(NSUInteger)index defaultValue:(NSInteger)value
{
    NSInteger i = value;
    if (index < [self count]) {
        id obj = [self objectAtIndex:index];
        i = [obj respondsToSelector:@selector(integerValue)] ? [obj integerValue] : value;
    } else {
        //DLog(DT_all, @"the index is out of boundary of array");
    }
    
    return i;
}

- (NSUInteger)md_unintegerAtIndex:(NSUInteger)index defaultValue:(NSUInteger)value
{
    NSUInteger u = value;
    if (index < [self count]) {
        id obj = [self objectAtIndex:index];
        u = [obj respondsToSelector:@selector(unsignedIntegerValue)] ? [obj unsignedIntegerValue] : value;
    } else {
        //DLog(DT_all, @"the index is out of boundary of array");
    }
    
    return u;
}

- (BOOL)md_boolAtIndex:(NSUInteger)index defaultValue:(BOOL)value
{
    BOOL b = value;
    if (index < [self count]) {
        id obj = [self objectAtIndex:index];
        b = [obj respondsToSelector:@selector(boolValue)] ? [obj boolValue] : value;
    } else {
        //DLog(DT_all, @"the index is out of boundary of array");
    }
    
    return b;
}

@end


@implementation NSMutableArray (Safe)

- (void)md_removeObjectAtIndexInBoundary:(NSUInteger)index
{
    if (index < [self count]) {
        [self removeObjectAtIndex:index];
    } else {
        //DLog(DT_app, @"the index to remove is out of array boundary");
    }
}

- (void)md_insertObject:(id)anObject atIndexInBoundary:(NSUInteger)index
{
    if (index > [self count]) {
        //DLog(DT_app, @"the index to insert is greater than count");
    } else {
        if (nil == anObject) {
            //DLog(DT_app, @"the anObject to be inserted is nil");
        } else {
            [self insertObject:anObject atIndex:index];
        }
    }
}

- (void)md_replaceObjectAtInBoundaryIndex:(NSUInteger)index withObject:(id)anObject
{
    if (index < [self count]) {
        if (nil == anObject) {
            //DLog(DT_app, @"the anObject to be replaced is nil");
        } else {
            [self replaceObjectAtIndex:index withObject:anObject];
        }
    } else {
            //DLog(DT_app, @"the index to replace is out of array boundary");
    }
}

- (void)md_addObjectSafe:(id)anObject
{
    if (anObject) {
        
        if ([anObject isKindOfClass:[NSNull class]]) {
            //DLog(DT_app, @"the anObject to be added is NSNull !");
        } else {
            [self addObject:anObject];
        }
    } else {
        //DLog(DT_app, @"the anObject to be added is nil");
    }
}

- (void)md_addObjectsFromArraySafe:(id)array
{
    if (array && [array isKindOfClass:[NSArray class]]) {
            [self addObjectsFromArray:array];
    } else {
        //DLog(DT_app, @"the array to be added is nil or not kind of NSArray");
    }
}
@end
