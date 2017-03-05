//
//  PulldownRefreshTableView.h
//  NewProject
//
//  Created by jiangshiju on 17/3/1.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "ProjectBaseTableView.h"

@class RefreshAndLoadTableView;
@protocol RefreshAndLoadTableViewAgent <NSObject>

@optional
- (void)shouldStartPulldownRefreshWithTableView:(RefreshAndLoadTableView *)tableView;
- (void)shouldStartPullupLoadWithTableView:(RefreshAndLoadTableView *)tableView;

@end

@interface RefreshAndLoadTableView : ProjectBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style totalDelegate:(id)delegate refreshAgent:(id<RefreshAndLoadTableViewAgent>)agent;

- (void)endPulldownRefresh;
- (void)endPullupLoad;
- (void)enablePulldownRefresh;
- (void)enablePullupLoad;

@end
