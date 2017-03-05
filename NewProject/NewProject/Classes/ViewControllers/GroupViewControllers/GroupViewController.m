//
//  GroupViewController.m
//  NewProject
//
//  Created by jiangshiju on 2017/3/4.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "GroupViewController.h"
#import "TableSelectView.h"
#import "NSArray+Safe.h"
#import "GroupSearchViewController.h"
#import "TestApi.h"
#import "GroupTableViewCell.h"
#import "GroupModel.h"

@interface GroupViewController () <TableSelectViewDelegate>

@property (nonatomic, strong) TableSelectView *selectView;
@property (nonatomic, strong) NSMutableArray *myGroupsArray;
@property (nonatomic, strong) NSMutableArray *nearbyGroupsArray;

@end

@implementation GroupViewController

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
    self.myGroupsArray = [NSMutableArray array];
    self.nearbyGroupsArray = [NSMutableArray array];
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
    [self.selectView setSelectedButtonIndex:1];
    [self requestForMyGroups];
    [self requestForNearbyGroups];
}

#pragma mark --------------------------- Getter ---------------------------
- (TableSelectView *)selectView
{
    if (!_selectView) {
        NSMutableArray *titleArray = [NSMutableArray arrayWithCapacity:2];
        [titleArray md_addObjectSafe:@"我的群组"];
        [titleArray md_addObjectSafe:@"附近群组"];
        TableSelectView *selectView = [[TableSelectView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [ProjectUtility getScreenWidth], [ProjectUtility getScreenHeight] - kPhoneNavigationBarHeight - kPhoneTabBarItemHeight) delegate:self buttonTitleArray:titleArray];
        [selectView enablePulldownRefresh:NO pullupLoad:NO tableViewIndex:1];
        [selectView enablePulldownRefresh:YES pullupLoad:NO tableViewIndex:2];
        _selectView = selectView;
    }
    return _selectView;
}

#pragma mark --------------------------- 点击方法 ---------------------------
- (void)rightButtonClicked:(UIButton *)button
{
    GroupSearchViewController *groupSearchVC = [[GroupSearchViewController alloc] initWithTitle:@"搜索" leftButtonTitle:@"取消" rightButtonTitle:nil];
    [self fetchCustomTabBar];
    [self.navigationController pushViewController:groupSearchVC animated:YES];
}

#pragma mark --------------------------- 网络请求 ---------------------------
- (void)requestForMyGroups
{
    for (int i = 0 ; i < 5; i++) {
        [self.myGroupsArray md_addObjectSafe:@"我的群组"];
    }
    [self performSelector:@selector(test1) withObject:nil afterDelay:2.0f];
}

- (void)test1
{
    [self.selectView reloadDataWithTableViewIndex:1];
}

- (void)requestForNearbyGroups
{
    [[TestApi defaultTest] getNearByGroupsInfoWithTarget:self okSelector:@selector(getNearByGroupsSuccess:) errorSelector:@selector(getNearByGroupsError)];
}

- (void)getNearByGroupsSuccess:(ApiResponse *)response
{
    [self.nearbyGroupsArray removeAllObjects];
    NSArray *groupArray = [response objectForKey:@"groups"];
    for (NSDictionary *dic in groupArray) {
        GroupModel *model = [[GroupModel alloc] initWithDictionary:dic];
        [self.nearbyGroupsArray md_addObjectSafe:model];
    }
    [self.selectView reloadDataWithTableViewIndex:2];
    [self.selectView endPulldownRefreshWithTableViewIndex:2];
}

- (void)getNearByGroupsError
{
    
}

#pragma mark --------------------------- 代理方法 ---------------------------
#pragma mark - TableSelectViewDelegate
- (NSInteger)numberForTableView:(UITableView *)tableView atIndex:(NSInteger)tableViewIndex
{
    switch (tableViewIndex) {
        case 1:
            return self.myGroupsArray.count;
            break;
        case 2:
            return self.nearbyGroupsArray.count;
            break;
            
        default:
            return 0;
            break;
    }
}

#pragma TODO - 自定义cell，封装GroupModel

- (UITableViewCell *)tableViewCellForTableView:(UITableView *)tableView atIndex:(NSInteger)tableViewIndex row:(NSInteger)row
{
    switch (tableViewIndex) {
        case 1:
        {
            static NSString *testCellID = @"testCellID";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:testCellID];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:testCellID];
            }
            cell.textLabel.text = [self.myGroupsArray md_objectAtIndex:row defaultValue:@"Default"];
            return cell;
        }
            break;
        case 2:
        {
            static NSString *nearbyGroupCellID = @"nearbyGroupCellID";
            GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nearbyGroupCellID];
            if (!cell) {
                cell = [[GroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nearbyGroupCellID];
            }
            GroupModel *model = [self.nearbyGroupsArray md_objectAtIndex:row kindOfClass:[GroupModel class]];
            [cell refreshWithGroupModel:model];
            return cell;
        }
            break;
            
        default:
            return nil;
            break;
    }
}

- (CGFloat)cellHeightForTableView:(RefreshAndLoadTableView *)tableView anIndex:(NSInteger)tableViewIndex row:(NSInteger)row
{
    return 80.0f;
}

- (void)shouldPulldownRefreshWithTableView:(RefreshAndLoadTableView *)tableView atIndex:(NSInteger)tableViewIndex
{
    switch (tableViewIndex) {
        case 1:
            [self requestForMyGroups];
            break;
        case 2:
            [self requestForNearbyGroups];
            break;
            
        default:
            break;
    }
}

- (void)shouldPullupLoadWithTableView:(RefreshAndLoadTableView *)tableView atIndex:(NSInteger)tableViewIndex
{
    switch (tableViewIndex) {
        case 1:
            [self requestForMyGroups];
            break;
        case 2:
            [self requestForNearbyGroups];
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
