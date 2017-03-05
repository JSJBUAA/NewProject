//
//  DebugLog.m
//  NewProject
//
//  Created by jiangshiju on 17/3/1.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "DebugLog.h"

void printLog(DebugLogType logType, NSString *format, ...)
{
    va_list args;
    va_start(args, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    NSString *logTypeStr = nil;
    switch (logType) {
        case DebugLogTypeError:
            logTypeStr = @"Error";      //失败、错误等信息
            break;
        case DebugLogTypeWarning:
            logTypeStr = @"Warning";    //异常、警告等信息
            break;
        case DebugLogTypeNotice:
            logTypeStr = @"Notice";     //运行提示信息,比如登录、退出、跳转...
            break;
        case DebugLogTypeUnknown:
            logTypeStr = @"Unkown";     //未知
            break;
        default:
            logTypeStr = @"Unkown";
            break;
    }
    
    NSLog(@" \n----------------------------- MDKLog ---------------------------- \n     LogType : %@. \n Description : %@. \n----------------------------------------------------------------- \n", logTypeStr, string);
}
