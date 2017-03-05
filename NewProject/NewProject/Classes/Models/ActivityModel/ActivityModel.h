//
//  ActivityModel.h
//  NewProject
//
//  Created by jiangshiju on 17/2/22.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma TODO - 继承自BaseModel重写

@interface ActivityModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *launcherName;
@property (nonatomic, copy) NSString *launcherID;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *launchTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, assign) NSUInteger expectedPrice;
@property (nonatomic, assign) NSUInteger minNumber;
@property (nonatomic, assign) NSUInteger maxNumber;
@property (nonatomic, assign) NSUInteger currentNumber;
@property (nonatomic, assign) BOOL launchFromMe;
@property (nonatomic, assign) BOOL haveApplied;

@end
