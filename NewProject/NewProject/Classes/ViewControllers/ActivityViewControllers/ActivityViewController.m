//
//  ActivityViewController.m
//  NewProject
//
//  Created by jiangshiju on 17/2/22.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "ActivityViewController.h"
#import "LaunchActivityViewController.h"
#import "TableSelectView.h"
#import "NSArray+Safe.h"

@interface ActivityViewController () <TableSelectViewDelegate>

@property (nonatomic, strong) TableSelectView *selectView;
@property (nonatomic, strong) NSMutableArray *appliedArray;
@property (nonatomic, strong) NSMutableArray *availableArray;

@end

@implementation ActivityViewController

#pragma mark --------------------------- View生命周期 ---------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self configUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self transferCustomBarToTabBarController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark --------------------------- 初始化Data ---------------------------
- (void)initData
{
    self.appliedArray = [NSMutableArray array];
    self.availableArray = [NSMutableArray array];
}

#pragma mark --------------------------- 注册通知及回调 ---------------------------
- (void)registerNotifyAndCallback
{
    
}

#pragma mark --------------------------- 布局UI ---------------------------
- (void)configUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:self.selectView];
    [self requestForAppliedActivities];
    [self requestForAvailableActivities];
    [self.selectView setSelectedButtonIndex:1];
}

#pragma mark --------------------------- Getter ---------------------------
- (TableSelectView *)selectView
{
    if (!_selectView) {
        NSMutableArray *titleArray = [NSMutableArray arrayWithCapacity:2];
        [titleArray md_addObjectSafe:@"已报名"];
        [titleArray md_addObjectSafe:@"可参加"];
        TableSelectView *selectView = [[TableSelectView alloc] initWithFrame:CGRectMake(0.0f, 0, [ProjectUtility getScreenWidth], [ProjectUtility getScreenHeight] - kPhoneNavigationBarHeight - kPhoneTabBarItemHeight) delegate:self buttonTitleArray:titleArray];
        [selectView enablePulldownRefresh:YES pullupLoad:YES tableViewIndex:1];
        [selectView enablePulldownRefresh:YES pullupLoad:YES tableViewIndex:2];
        _selectView = selectView;
    }
    return _selectView;
}

#pragma mark --------------------------- 点击方法 ---------------------------
- (void)rightButtonClicked:(UIButton *)button
{
    LaunchActivityViewController *launchActivityViewController = [[LaunchActivityViewController alloc] initWithTitle:@"发起活动" leftButtonTitle:@"取消" rightButtonTitle:@"下一步"];
    [self fetchCustomTabBar];
    [self.navigationController pushViewController:launchActivityViewController animated:YES];
}

#pragma mark --------------------------- 网络请求 ---------------------------
//请求“已报名”数据
- (void)requestForAppliedActivities
{
    for (int i = 0 ; i < 5; i++) {
        [self.appliedArray addObject:@"AppliedActivity"];
    }
    [self performSelector:@selector(testMethod1) withObject:nil afterDelay:2.0f];
}

#pragma warning - 测试数据
- (void)testMethod1
{
    [self.selectView reloadDataWithTableViewIndex:1];
    [self.selectView endPulldownRefreshWithTableViewIndex:1];
}

- (void)testMethod2
{
    [self.selectView reloadDataWithTableViewIndex:2];
    [self.selectView endPulldownRefreshWithTableViewIndex:2];
}

- (void)testMethod3
{
    [self.selectView reloadDataWithTableViewIndex:1];
    [self.selectView endPullupLoadWithTableViewIndex:1];
}

- (void)testMethod4
{
    [self.selectView reloadDataWithTableViewIndex:2];
    [self.selectView endPullupLoadWithTableViewIndex:2];
}

//请求“可参加”数据
- (void)requestForAvailableActivities
{
    for (int i = 0 ; i < 6; i++) {
        [self.availableArray addObject:@"AvailableActivity"];
    }
    [self performSelector:@selector(testMethod2) withObject:nil afterDelay:2.0f];
}

#pragma mark --------------------------- 代理方法 ---------------------------
#pragma mark - TableSelectViewDelegate
- (NSInteger)numberForTableView:(UITableView *)tableView atIndex:(NSInteger)tableViewIndex
{
    switch (tableViewIndex) {
        case 1:
            return self.appliedArray.count;
            break;
        case 2:
            return self.availableArray.count;
            break;
            
        default:
            return 0;
            break;
    }
}

#pragma TODO - 自定义cell，封装活动Model

- (UITableViewCell *)tableViewCellForTableView:(UITableView *)tableView atIndex:(NSInteger)tableViewIndex row:(NSInteger)row
{
    static NSString *testCellID = @"testCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:testCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:testCellID];
    }
    switch (tableViewIndex) {
        case 1:
            cell.textLabel.text = [self.appliedArray md_objectAtIndex:row defaultValue:@"Default"];
            break;
        case 2:
            cell.textLabel.text = [self.availableArray md_objectAtIndex:row defaultValue:@"Default"];
            break;
            
        default:
            return nil;
            break;
    }
    return cell;
}

- (void)shouldPulldownRefreshWithTableView:(RefreshAndLoadTableView *)tableView atIndex:(NSInteger)tableViewIndex
{
    switch (tableViewIndex) {
        case 1:
            [self requestForAppliedActivities];
            break;
        case 2:
            [self requestForAvailableActivities];
            break;
            
        default:
            break;
    }
}

- (void)shouldPullupLoadWithTableView:(RefreshAndLoadTableView *)tableView atIndex:(NSInteger)tableViewIndex
{
    switch (tableViewIndex) {
        case 1:
            [self requestForAppliedActivities];
            break;
        case 2:
            [self requestForAvailableActivities];
            break;
            
        default:
            break;
    }
}

- (void)didSelectTableView:(RefreshAndLoadTableView *)tableView atIndex:(NSInteger)tableViewIndex row:(NSInteger)row
{
    
}

#pragma mark --------------------------- 公开方法 ---------------------------

#pragma mark --------------------------- 私有方法 ---------------------------

@end
