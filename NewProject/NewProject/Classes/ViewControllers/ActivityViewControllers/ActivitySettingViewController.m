//
//  ActivitySettingViewController.m
//  NewProject
//
//  Created by jiangshiju on 17/2/25.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "ActivitySettingViewController.h"
#import "NSArray+Safe.h"
#import "NSObject+MFDictionaryAdapter.h"

@interface ActivitySettingViewController ()

@end

@implementation ActivitySettingViewController

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
    NSDictionary *numberDic = [NSDictionary dictionaryWithObjectsAndKeys:@"5-50人",@"value",@"限制人数",@"key", nil];
    NSDictionary *costDic = [NSDictionary dictionaryWithObjectsAndKeys:@"50元",@"value",@"活动费用",@"key", nil];
    NSDictionary *joinedNumberDic = [NSDictionary dictionaryWithObjectsAndKeys:@"1-50",@"value",@"每人参与数",@"key", nil];
    NSDictionary *endTimeDic = [NSDictionary dictionaryWithObjectsAndKeys:@"2017-02-28 12:00:00",@"value",@"报名截止时间",@"key", nil];
    NSDictionary *launchTimeDic = [NSDictionary dictionaryWithObjectsAndKeys:@"2017-03-01 12:00:00",@"value",@"活动开始时间",@"key", nil];
    [self.dataArray md_addObjectSafe:numberDic];
    [self.dataArray md_addObjectSafe:costDic];
    [self.dataArray md_addObjectSafe:joinedNumberDic];
    [self.dataArray md_addObjectSafe:endTimeDic];
    [self.dataArray md_addObjectSafe:launchTimeDic];
}

#pragma mark --------------------------- 注册通知及回调 ---------------------------
- (void)registerNotifyAndCallback
{
    
}

#pragma mark --------------------------- 布局UI ---------------------------
- (void)configUI
{
    [self.mainTableView reloadData];
}

#pragma mark --------------------------- Getter ---------------------------

#pragma mark --------------------------- 点击方法 ---------------------------
- (void)rightButtonClicked:(UIButton *)button
{
    
}

#pragma mark --------------------------- 网络请求 ---------------------------

#pragma mark --------------------------- 代理方法 ---------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *activitySettingTableViewCellID = @"activitySettingTableViewCellID";
    ActivitySettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:activitySettingTableViewCellID];
    if (!cell) {
        cell = [[ActivitySettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activitySettingTableViewCellID];
    }
    NSDictionary *dic = [self.dataArray md_objectAtIndex:indexPath.row defaultValue:[NSDictionary dictionary]];
    [cell refreshWithDictionary:dic];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark --------------------------- 公开方法 ---------------------------

#pragma mark --------------------------- 私有方法 ---------------------------

@end

@implementation ActivitySettingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.keyLabel];
        [self.contentView addSubview:self.valueLabel];
        [self.contentView addSubview:self.arrowImageView];
    }
    return self;
}

- (UILabel *)keyLabel
{
    if (!_keyLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 7.0f, 100.0f, 30.0f)];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14.0f];
        _keyLabel = label;
    }
    return _keyLabel;
}

- (UILabel *)valueLabel
{
    if (!_valueLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([ProjectUtility getScreenWidth] - 20.0f - 10.0f - 140.0f - 20.0f, 7.0f, 140.0f, 30.0f)];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14.0f];
        _valueLabel = label;
    }
    return _valueLabel;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([ProjectUtility getScreenWidth] - 20.0f - 10.0f, 13.0f, 10.0f, 18.0f)];
        
        NSString *arrowImageFilePath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],@"IMAGE.bundle/newRightArrow"];
        imageView.image = [UIImage imageWithContentsOfFile:arrowImageFilePath];
        _arrowImageView = imageView;
    }
    return _arrowImageView;
}

- (void)refreshWithDictionary:(NSDictionary *)dictionary
{
    self.keyLabel.text = [dictionary md_stringForKey:@"key" defaultValue:@""];
    self.valueLabel.text = [dictionary md_stringForKey:@"value" defaultValue:@""];
}

@end
