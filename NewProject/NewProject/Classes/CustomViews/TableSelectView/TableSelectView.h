//
//  TableSelectView.h
//  NewProject
//
//  Created by jiangshiju on 17/2/28.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProjectBaseModel;
@class RefreshAndLoadTableView;

@protocol TableSelectViewDelegate <NSObject>

@required
- (NSInteger)numberForTableView:(RefreshAndLoadTableView *)tableView atIndex:(NSInteger)tableViewIndex;
- (UITableViewCell *)tableViewCellForTableView:(RefreshAndLoadTableView *)tableView atIndex:(NSInteger)tableViewIndex row:(NSInteger)row;

@optional
- (void)shouldPulldownRefreshWithTableView:(RefreshAndLoadTableView *)tableView atIndex:(NSInteger)tableViewIndex;
- (void)shouldPullupLoadWithTableView:(RefreshAndLoadTableView *)tableView atIndex:(NSInteger)tableViewIndex;
- (void)didSelectTableView:(RefreshAndLoadTableView *)tableView atIndex:(NSInteger)tableViewIndex row:(NSInteger)row;
- (CGFloat)cellHeightForTableView:(RefreshAndLoadTableView *)tableView anIndex:(NSInteger)tableViewIndex row:(NSInteger)row;

@end

@interface TableSelectView : UIView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<TableSelectViewDelegate>)delegate buttonTitleArray:(NSArray<NSString *> *)buttonTitleArray;

- (void)reloadDataWithTableViewIndex:(NSInteger)index;
- (void)setSelectedButtonIndex:(NSInteger)buttonIndex;
- (void)enablePulldownRefresh:(BOOL)pulldownEnabled pullupLoad:(BOOL)pullupEnabled tableViewIndex:(NSInteger)index;
- (void)endPulldownRefreshWithTableViewIndex:(NSInteger)index;
- (void)endPullupLoadWithTableViewIndex:(NSInteger)index;

@end
