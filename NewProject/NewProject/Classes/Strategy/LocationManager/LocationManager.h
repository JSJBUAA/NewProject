//
//  LocationManager.h
//  NewProject
//
//  Created by jiangshiju on 2017/3/5.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LocationModel;
@protocol LocationManagerDelegate <NSObject>

- (void)locationSuccess:(LocationModel *)location;
//如果定位失败会返回上一次定位的值
- (void)locationFailure:(LocationModel *)location;

@end

@interface LocationManager : NSObject

@end
