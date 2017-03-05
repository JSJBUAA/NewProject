//
//  LocationModel.m
//  NewProject
//
//  Created by jiangshiju on 2017/3/5.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "LocationModel.h"

@implementation LocationModel

+ (LocationModel *)locationWithLatitude:(double)latitude
                            longitude:(double)longitude
                             accuracy:(double)accuracy
                                 time:(NSTimeInterval)time
{
    LocationModel *location = [[LocationModel alloc] init];
    location.latitude = latitude;
    location.longitude = longitude;
    location.accuracy = accuracy;
    location.time = time;
#pragma TODO - 默认没有纠偏，这里需要根据需求改动
    location.hasRevised = NO;
    
    return location;
}

@end
