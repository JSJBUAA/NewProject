//
//  ProjectBaseTableView.m
//  NewProject
//
//  Created by jiangshiju on 17/3/1.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "ProjectBaseTableView.h"

@implementation ProjectBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style totalDelegate:(id)delegate
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = delegate;
        self.dataSource = delegate;
        self.backgroundColor = [UIColor whiteColor];
        UIView *view = [[UIView alloc] init];
        self.tableFooterView = view;
    }
    return self;
}

@end
