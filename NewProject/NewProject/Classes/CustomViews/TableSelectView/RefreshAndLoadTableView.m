//
//  PulldownRefreshTableView.m
//  NewProject
//
//  Created by jiangshiju on 17/3/1.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "RefreshAndLoadTableView.h"
#import "MJRefresh.h"

@interface RefreshAndLoadTableView ()

@property (nonatomic, weak) id<RefreshAndLoadTableViewAgent> agent;

@end

@implementation RefreshAndLoadTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style totalDelegate:(id)delegate refreshAgent:(id)agent
{
    if (self = [super initWithFrame:frame style:style totalDelegate:delegate]) {
        self.agent = agent;
    }
    return self;
}

- (void)enablePulldownRefresh
{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if ([self.agent respondsToSelector:@selector(shouldStartPulldownRefreshWithTableView:)]) {
            [self.agent shouldStartPulldownRefreshWithTableView:self];
        } else {
            DebugLog(DebugLogTypeWarning, @"PulldownRefreshTableView的代理类没有实现shouldStartPulldownRefreshWithTableView:方法");
        }
    }];
}

- (void)enablePullupLoad
{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if ([self.agent respondsToSelector:@selector(shouldStartPullupLoadWithTableView:)]) {
            [self.agent shouldStartPullupLoadWithTableView:self];
        } else {
            DebugLog(DebugLogTypeWarning, @"PulldownRefreshTableView的代理类没有实现shouldStartPullupLoadWithTableView:方法");
        }
    }];
}

- (void)endPulldownRefresh
{
    [self.mj_header endRefreshing];
}

- (void)endPullupLoad
{
    [self.mj_footer endRefreshing];
}

@end
