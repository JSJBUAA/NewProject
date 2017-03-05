//
//  DebugLog.h
//  NewProject
//
//  Created by jiangshiju on 17/3/1.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    DebugLogTypeError,
    DebugLogTypeNotice,
    DebugLogTypeWarning,
    DebugLogTypeUnknown,
} DebugLogType;

#ifdef DEBUG
#define DebugLog(logType,format,...) printLog(logType,format,##__VA_ARGS__)
#else
#define DebugLog(logType,format,...)
#endif

void printLog(DebugLogType logType, NSString *format, ...);
