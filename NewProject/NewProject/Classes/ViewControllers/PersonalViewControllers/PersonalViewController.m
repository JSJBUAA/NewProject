//
//  PersonalViewController.m
//  NewProject
//
//  Created by jiangshiju on 17/2/26.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalSettingViewController.h"
#import "PersonalHeaderView.h"
#import "TableSelectView.h"
#import "NSArray+Safe.h"

@interface PersonalViewController () <TableSelectViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PersonalHeaderView *headerView;
@property (nonatomic, strong) TableSelectView *selectView;
@property (nonatomic, strong) NSMutableArray *friendsArray;
@property (nonatomic, strong) NSMutableArray *followedArray;
@property (nonatomic, strong) NSMutableArray *fansArray;

@end

@implementation PersonalViewController

#pragma TODO - 个人页中使用TableSelectView添加内容，使用一个tableView的header展示头像，使用footer展示TableSelectView，没有cell

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
    self.friendsArray = [NSMutableArray array];
    self.followedArray = [NSMutableArray array];
    self.fansArray = [NSMutableArray array];
}

#pragma mark --------------------------- 注册通知及回调 ---------------------------
- (void)registerNotifyAndCallback
{
    
}

#pragma mark --------------------------- 布局UI ---------------------------
- (void)configUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.selectView;
    [self requestForFollowed];
    [self requestForFriends];
    [self requestForFans];
    [self.selectView setSelectedButtonIndex:1];
}

#pragma mark --------------------------- Getter ---------------------------
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [ProjectUtility getScreenWidth], [ProjectUtility getScreenHeight] - kPhoneNavigationBarHeight - kPhoneTabBarItemHeight) style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor whiteColor];
        _tableView = tableView;
    }
    return _tableView;
}

- (PersonalHeaderView *)headerView
{
    if (!_headerView) {
        PersonalHeaderView *headerView = [[PersonalHeaderView alloc] initWithFrame:CGRectMake(0, 0, [ProjectUtility getScreenWidth], 130.0f)];
        headerView.backgroundColor = [UIColor whiteColor];
        _headerView = headerView;
    }
    return _headerView;
}

- (TableSelectView *)selectView
{
    if (!_selectView) {
        NSMutableArray *titleArray = [NSMutableArray arrayWithCapacity:3];
        [titleArray md_addObjectSafe:@"好友"];
        [titleArray md_addObjectSafe:@"关注"];
        [titleArray md_addObjectSafe:@"粉丝"];
        TableSelectView *selectView = [[TableSelectView alloc] initWithFrame:CGRectMake(0.0f, 0, [ProjectUtility getScreenWidth], self.tableView.frame.size.height - self.headerView.frame.size.height) delegate:self buttonTitleArray:titleArray];
        //这页不需要开启下拉刷新
        _selectView = selectView;
    }
    return _selectView;
}

#pragma mark --------------------------- 点击方法 ---------------------------
- (void)rightButtonClicked:(UIButton *)button
{
    PersonalSettingViewController *settingViewController = [[PersonalSettingViewController alloc] initWithTitle:@"设置" leftButtonTitle:@"取消" rightButtonTitle:@"保存"];
    [self fetchCustomTabBar];
    [self.navigationController pushViewController:settingViewController animated:YES];
}

#pragma mark --------------------------- 网络请求 ---------------------------
- (void)requestForFriends
{
    for (int i = 0; i < 15; i++) {
        [self.friendsArray md_addObjectSafe:@"好友"];
    }
    [self.selectView reloadDataWithTableViewIndex:1];
}

- (void)requestForFollowed
{
    for (int i = 0; i< 26; i++) {
        [self.followedArray md_addObjectSafe:@"关注"];
    }
    [self.selectView reloadDataWithTableViewIndex:2];
}

- (void)requestForFans
{
    for (int i = 0 ; i < 37; i++) {
        [self.fansArray md_addObjectSafe:@"粉丝"];
    }
    [self.selectView reloadDataWithTableViewIndex:3];
}

#pragma mark --------------------------- 代理方法 ---------------------------
#pragma mark - TableSelectViewDelegate
- (NSInteger)numberForTableView:(UITableView *)tableView atIndex:(NSInteger)tableViewIndex
{
    switch (tableViewIndex) {
        case 1:
            return self.friendsArray.count;
            break;
        case 2:
            return self.followedArray.count;
            break;
        case 3:
            return self.fansArray.count;
            break;
            
        default:
            return 0;
            break;
    }
}

#pragma TODO - 自定义cell，封装对应Model
- (UITableViewCell *)tableViewCellForTableView:(UITableView *)tableView atIndex:(NSInteger)tableViewIndex row:(NSInteger)row
{
    static NSString *testCellID = @"testCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:testCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:testCellID];
    }
    switch (tableViewIndex) {
        case 1:
            cell.textLabel.text = [self.friendsArray md_objectAtIndex:row defaultValue:@"Default"];
            break;
        case 2:
            cell.textLabel.text = [self.followedArray md_objectAtIndex:row defaultValue:@"Default"];
            break;
        case 3:
            cell.textLabel.text = [self.fansArray md_objectAtIndex:row defaultValue:@"Default"];
            break;
            
        default:
            return nil;
            break;
    }
    return cell;
}

- (void)didSelectTableView:(RefreshAndLoadTableView *)tableView atIndex:(NSInteger)tableViewIndex row:(NSInteger)row
{
    
}

#pragma mark --------------------------- 公开方法 ---------------------------

#pragma mark --------------------------- 私有方法 ---------------------------

@end
