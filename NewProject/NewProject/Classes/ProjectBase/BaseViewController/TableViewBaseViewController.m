//
//  TableViewBaseViewController.m
//  NewProject
//
//  Created by jiangshiju on 17/2/23.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "TableViewBaseViewController.h"

@interface TableViewBaseViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation TableViewBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = [NSMutableArray array];
    [self.mainView addSubview:self.mainTableView];
}

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [ProjectUtility getScreenWidth], [ProjectUtility getScreenHeight] - kPhoneNavigationBarHeight) style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        UIView *view = [[UIView alloc] init];
        tableView.tableFooterView = view;
        _mainTableView = tableView;
    }
    return _mainTableView;
}

#pragma mark - UITalbeViewDelegate/DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
