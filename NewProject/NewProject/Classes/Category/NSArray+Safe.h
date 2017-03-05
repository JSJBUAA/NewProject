//
//  NSArray+Safe.h
//  MomoChat
//
//  Created by 杨 红林 on 13-7-4.
//  Copyright (c) 2013年 wemomo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Safe)

- (id)md_objectAtIndex:(NSUInteger)index kindOfClass:(Class)aClass;
- (id)md_objectAtIndex:(NSUInteger)index memberOfClass:(Class)aClass;
- (id)md_objectAtIndex:(NSUInteger)index defaultValue:(id)value;
- (NSString *)md_stringAtIndex:(NSUInteger)index defaultValue:(NSString *)value;
- (NSNumber *)md_numberAtIndex:(NSUInteger)index defaultValue:(NSNumber *)value;
- (NSDictionary *)md_dictionaryAtIndex:(NSUInteger)index defaultValue:(NSDictionary *)value;
- (NSArray *)md_arrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)value;
- (NSData *)md_dataAtIndex:(NSUInteger)index defaultValue:(NSData *)value;
- (NSDate *)md_dateAtIndex:(NSUInteger)index defaultValue:(NSDate *)value;
- (float)md_floatAtIndex:(NSUInteger)index defaultValue:(float)value;
- (double)md_doubleAtIndex:(NSUInteger)index defaultValue:(double)value;
- (NSInteger)md_integerAtIndex:(NSUInteger)index defaultValue:(NSInteger)value;
- (NSUInteger)md_unintegerAtIndex:(NSUInteger)index defaultValue:(NSUInteger)value;
- (BOOL)md_boolAtIndex:(NSUInteger)index defaultValue:(BOOL)value;

@end

@interface NSMutableArray (Safe)

- (void)md_removeObjectAtIndexInBoundary:(NSUInteger)index;
- (void)md_insertObject:(id)anObject atIndexInBoundary:(NSUInteger)index;
- (void)md_replaceObjectAtInBoundaryIndex:(NSUInteger)index withObject:(id)anObject;
- (void)md_addObjectsFromArraySafe:(id)array;

// 排除nil 和 NSNull
- (void)md_addObjectSafe:(id)anObject;



@end

