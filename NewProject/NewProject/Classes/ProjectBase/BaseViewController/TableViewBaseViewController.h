//
//  TableViewBaseViewController.h
//  NewProject
//
//  Created by jiangshiju on 17/2/23.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

/*继承父类特性，自带一个TableView并实现其代理*/

#import "ProjectBaseViewController.h"

@interface TableViewBaseViewController : ProjectBaseViewController

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

/*留给子类覆写*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
