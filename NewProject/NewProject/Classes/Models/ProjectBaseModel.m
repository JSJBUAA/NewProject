//
//  ProjectBaseModel.m
//  NewProject
//
//  Created by jiangshiju on 17/2/28.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "ProjectBaseModel.h"
#import <objc/runtime.h>

@implementation ProjectBaseModel

#pragma mark -- 通过运行时获取当前对象的所有属性的名称，以数组的形式返回
- (NSArray *)allPropertyNames
{
    //存储所有的属性名称
    NSMutableArray *allNames = [NSMutableArray array];
    
    //存储属性的个数
    unsigned int propertyCount = 0;
    
    //通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    
    //把属性放到数组中
    for (NSInteger i = 0; i < propertyCount; i ++)
    {
        //取出第一个属性
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    //释放
    free(propertys);
    
    return allNames;
}

#pragma mark -- 通过字符串来创建该字符串的Getter方法，并返回
- (SEL)creatGetterWithPropertyName:(NSString *)propertyName
{
    //1.返回get方法: oc中的get方法就是属性的本身
    return NSSelectorFromString(propertyName);
}

#pragma mark -- 重写Description方法
- (NSString *)description
{
    //获取实体类的属性名
    NSArray *array = [self allPropertyNames];
    
    //拼接参数
    NSMutableString *resultString = [NSMutableString string];
    
    for (NSInteger i = 0; i < array.count; i ++)
    {
        //获取get方法
        SEL getSel = [self creatGetterWithPropertyName:array[i]];
        
        if ([self respondsToSelector:getSel])
        {
            //获得类和方法的签名
            NSMethodSignature *signature = [self methodSignatureForSelector:getSel];
            //从签名获得调用对象
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            //设置target
            [invocation setTarget:self];
            //设置selector
            [invocation setSelector:getSel];
            //调用
            [invocation invoke];
            
            //接收返回的值
            NSObject *__unsafe_unretained returnValue = nil;
            //获取属性类型
            const char *methodReturnType = [[invocation methodSignature] methodReturnType];
            
            if ( !strcmp(methodReturnType, @encode(id)) )
            {
                //接收返回值
                [invocation getReturnValue:&returnValue];
            }
            else
            {
                //返回值长度
                NSUInteger length = [[invocation methodSignature] methodReturnLength];
                //根据长度申请内存
                void *buffer = (void *)malloc(length);
                //为变量赋值
                [invocation getReturnValue:buffer];
                
                if( !strcmp(methodReturnType, @encode(BOOL)) ) {
                    returnValue = [NSNumber numberWithBool:*((BOOL*)buffer)];
                }
                else if( !strcmp(methodReturnType, @encode(int)) ){
                    returnValue = [NSNumber numberWithInteger:*((int*)buffer)];
                }
                else if( !strcmp(methodReturnType, @encode(NSInteger)) ){
                    returnValue = [NSNumber numberWithInteger:*((NSInteger*)buffer)];
                }
                else if( !strcmp(methodReturnType, @encode(double)) ) {
                    returnValue = [NSNumber numberWithDouble:*((double*)buffer)];
                }
                
                free(buffer);
            }
            [resultString appendFormat:@"%@ = %@ \n ",array[i],returnValue];
        }
    }
    
    return resultString;
}

@end
