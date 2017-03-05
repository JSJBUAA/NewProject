//
//  TestApi.h
//  NewProject
//
//  Created by jiangshiju on 2017/3/3.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "AFNApiBase.h"

@interface TestApi : AFNApiBase

+ (id)defaultTest;
- (ApiRequest *)getNearByGroupsInfoWithTarget:(id)target
                                   okSelector:(SEL)okSelector
                                errorSelector:(SEL)errorSelector;

@end
