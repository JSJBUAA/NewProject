//
//  ActivityTableView.m
//  NewProject
//
//  Created by jiangshiju on 17/2/24.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "ActivityTableView.h"

@implementation ActivityTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style totalDelegate:(id)delegate
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = delegate;
        self.dataSource = delegate;
        self.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [ProjectUtility getScreenWidth], 30.0f)];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:11.0f];
        label.text = @"没有更多了";
        self.tableFooterView = label;
    }
    return self;
}

@end
