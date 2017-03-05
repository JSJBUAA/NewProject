//
//  LocationModel.h
//  NewProject
//
//  Created by jiangshiju on 2017/3/5.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "ProjectBaseModel.h"

@interface LocationModel : ProjectBaseModel

/**
 * @brief 纬度.
 */
@property (nonatomic, assign) double latitude;

/**
 * @brief 经度.
 */
@property (nonatomic, assign) double longitude;

/**
 * @brief 精确度.
 */
@property (nonatomic, assign) double accuracy;

/**
 * @brief 定位时间.
 */
@property (nonatomic, assign) NSTimeInterval time;

/**
 * @brief 是否纠偏.
 */
@property (nonatomic, assign) BOOL hasRevised;

/**
 * 默认定位数据没有纠偏.
 *
 * @brief MDKLocation便利构造器方法.
 *
 * @param latitude 纬度.
 * @param longitude 经度.
 * @param accuracy 精确度.
 * @param time 定位时间.
 *
 * @return MDKLocation实例对象.
 */
+ (LocationModel *)locationWithLatitude:(double)latitude
                            longitude:(double)longitude
                             accuracy:(double)accuracy
                                 time:(NSTimeInterval)time;

@end
