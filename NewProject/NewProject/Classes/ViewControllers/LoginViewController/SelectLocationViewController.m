//
//  SelectLocationViewController.m
//  NewProject
//
//  Created by jiangshiju on 2017/3/5.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "SelectLocationViewController.h"
#import "SelectLocationHeaderView.h"
#import "NSArray+Safe.h"

@interface SelectLocationViewController ()

@end

@implementation SelectLocationViewController

#pragma mark --------------------------- View生命周期 ---------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    [self configUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark --------------------------- 初始化Data ---------------------------
- (void)initData
{
    for (int i = 0; i < 5; i++) {
        [self.dataArray md_addObjectSafe:@"小区"];
    }
}

#pragma mark --------------------------- 注册通知及回调 ---------------------------
- (void)registerNotifyAndCallback
{
    
}

#pragma mark --------------------------- 布局UI ---------------------------
- (void)configUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    SelectLocationHeaderView *headerView = [[SelectLocationHeaderView alloc] initWithFrame:CGRectMake(0, 0, [ProjectUtility getScreenWidth], 200)];
    self.mainTableView.tableHeaderView = headerView;
}

#pragma mark --------------------------- Getter ---------------------------

#pragma mark --------------------------- 点击方法 ---------------------------

#pragma mark --------------------------- 网络请求 ---------------------------

#pragma mark --------------------------- 代理方法 ---------------------------

#pragma mark --------------------------- 公开方法 ---------------------------

#pragma mark --------------------------- 私有方法 ---------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"selectLocationViewControllerTestCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [self.dataArray md_objectAtIndex:indexPath.row defaultValue:@"test"];
    return cell;
}

@end
