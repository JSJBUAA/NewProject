//
//  TableSelectView.m
//  NewProject
//
//  Created by jiangshiju on 17/2/28.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "TableSelectView.h"
#import "ActivityButton.h"
#import "NSArray+Safe.h"
#import "RefreshAndLoadTableView.h"

/*这个页面原则上只有两或者三个按钮，点击切换不同的tableView，每个tableView的代理由该类承接，但具体实现在外部代理完成。*/

#define kTableSelectViewButtonWidth       self.frame.size.width / self.buttonTitleArray.count
#define kTableSelectViewButtonHeight      30.0f

@interface TableSelectView () <UITableViewDelegate,UITableViewDataSource,RefreshAndLoadTableViewAgent>

@property (nonatomic, weak) id<TableSelectViewDelegate> delegate;
@property (nonatomic, strong) NSArray<NSString *> *buttonTitleArray;
@property (nonatomic, strong) ActivityButton *firstButton;
@property (nonatomic, strong) ActivityButton *secondButton;
@property (nonatomic, strong) ActivityButton *thirdButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL thirdButtonNeeded;
@property (nonatomic, strong) RefreshAndLoadTableView *firstTableView;
@property (nonatomic, strong) RefreshAndLoadTableView *secondTableView;
@property (nonatomic, strong) RefreshAndLoadTableView *thirdTableView;

@end

@implementation TableSelectView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<TableSelectViewDelegate>)delegate buttonTitleArray:(NSArray<NSString *> *)buttonTitleArray
{
    if (self = [super initWithFrame:frame]) {
        self.delegate = delegate;
        self.buttonTitleArray = buttonTitleArray;
        self.backgroundColor = [UIColor whiteColor];
        [self initTableSelectViewData];
        [self configTableSelectView];
    }
    return self;
}

- (void)initTableSelectViewData
{
    if (self.buttonTitleArray.count >= 3) {
        self.thirdButtonNeeded = YES;
    } else {
        self.thirdButtonNeeded = NO;
    }
}

- (void)configTableSelectView
{
    [self addSubview:self.firstButton];
    [self addSubview:self.secondButton];
    
    [self addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.firstTableView];
    [self.scrollView addSubview:self.secondTableView];
    
    if (self.thirdButtonNeeded) {
        [self addSubview:self.thirdButton];
        [self.scrollView addSubview:self.thirdTableView];
    }
}

#pragma mark - Getter
- (ActivityButton *)firstButton
{
    if (!_firstButton) {
        ActivityButton *button = [ActivityButton buttonWithFrame:CGRectMake(0.0f, 0.0f,kTableSelectViewButtonWidth, kTableSelectViewButtonHeight) title:[self.buttonTitleArray md_objectAtIndex:0 defaultValue:@"Default"] target:self action:@selector(firstButtonClicked:)];
        _firstButton = button;
    }
    return _firstButton;
}

- (ActivityButton *)secondButton
{
    if (!_secondButton) {
        ActivityButton *button = [ActivityButton buttonWithFrame:CGRectMake(kTableSelectViewButtonWidth, 0.0f, kTableSelectViewButtonWidth, kTableSelectViewButtonHeight) title:[self.buttonTitleArray md_objectAtIndex:1 defaultValue:@"Default"] target:self action:@selector(secondButtonClicked:)];
        _secondButton = button;
    }
    return _secondButton;
}

- (ActivityButton *)thirdButton
{
    if (!self.thirdButtonNeeded) {
        return nil;
    }
    if (!_thirdButton) {
        ActivityButton *button = [ActivityButton buttonWithFrame:CGRectMake(kTableSelectViewButtonWidth * 2, 0.0f, kTableSelectViewButtonWidth, kTableSelectViewButtonHeight) title:[self.buttonTitleArray md_objectAtIndex:2 defaultValue:@"Default"] target:self action:@selector(thirdButtonClicked:)];
        _thirdButton = button;
    }
    return _thirdButton;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTableSelectViewButtonHeight, self.frame.size.width, self.frame.size.height - kTableSelectViewButtonHeight)];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.scrollEnabled = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.contentSize = CGSizeMake(self.frame.size.width * self.buttonTitleArray.count, 0.0f);
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (RefreshAndLoadTableView *)firstTableView
{
    if (!_firstTableView) {
        RefreshAndLoadTableView *tableView = [[RefreshAndLoadTableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height - kTableSelectViewButtonHeight) style:UITableViewStylePlain totalDelegate:self refreshAgent:self];
        _firstTableView = tableView;
    }
    return _firstTableView;
}

- (RefreshAndLoadTableView *)secondTableView
{
    if (!_secondTableView) {
        RefreshAndLoadTableView *tableView = [[RefreshAndLoadTableView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0.0f, self.frame.size.width, self.frame.size.height - kTableSelectViewButtonHeight) style:UITableViewStylePlain totalDelegate:self refreshAgent:self];
        _secondTableView = tableView;
    }
    return _secondTableView;
}

- (RefreshAndLoadTableView *)thirdTableView
{
    if (!self.thirdButtonNeeded) {
        return nil;
    }
    if (!_thirdTableView) {
        RefreshAndLoadTableView *tableView = [[RefreshAndLoadTableView alloc] initWithFrame:CGRectMake(self.frame.size.width * 2, 0.0f, self.frame.size.width, self.frame.size.height - kTableSelectViewButtonHeight) style:UITableViewStylePlain totalDelegate:self refreshAgent:self];
        _thirdTableView = tableView;
    }
    return _thirdTableView;
}

#pragma mark - TargetAction
- (void)firstButtonClicked:(ActivityButton *)button
{
    if (button.buttonSelected) {
        return;
    }
    self.secondButton.buttonSelected = NO;
    self.thirdButton.buttonSelected = NO;
    button.buttonSelected = !button.buttonSelected;
    [UIView animateWithDuration:0.3f animations:^{
        [self.scrollView setContentOffset:CGPointMake(0.0f, 0.0f)];
    }];
}

- (void)secondButtonClicked:(ActivityButton *)button
{
    if (button.buttonSelected) {
        return;
    }
    self.thirdButton.buttonSelected = NO;
    self.firstButton.buttonSelected = NO;
    button.buttonSelected = !button.buttonSelected;
    [UIView animateWithDuration:0.3f animations:^{
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0.0f)];
    }];
}

- (void)thirdButtonClicked:(ActivityButton *)button
{
    if (button.buttonSelected) {
        return;
    }
    self.secondButton.buttonSelected = NO;
    self.firstButton.buttonSelected = NO;
    button.buttonSelected = !button.buttonSelected;
    [UIView animateWithDuration:0.3f animations:^{
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width * 2, 0.0f)];
    }];
}

#pragma mark - Public
- (void)reloadDataWithTableViewIndex:(NSInteger)index
{
    if (![self isAvailableIndex:index]) {
        return;
    }
    switch (index) {
        case 1:
            [self.firstTableView reloadData];
            break;
        case 2:
            [self.secondTableView reloadData];
            break;
        case 3:
            [self.thirdTableView reloadData];
            break;
            
        default:
            break;
    }
}

- (void)setSelectedButtonIndex:(NSInteger)buttonIndex
{
    if (![self isAvailableIndex:buttonIndex]) {
        return;
    }
    switch (buttonIndex) {
        case 1:
            self.firstButton.buttonSelected = YES;
            break;
        case 2:
            self.secondButton.buttonSelected = YES;
            break;
        case 3:
            self.thirdButton.buttonSelected = YES;
            break;
            
        default:
            break;
    }
}

- (void)enablePulldownRefresh:(BOOL)pulldownEnabled pullupLoad:(BOOL)pullupEnabled tableViewIndex:(NSInteger)index
{
    if (![self isAvailableIndex:index]) {
        return;
    }
    switch (index) {
        case 1:
        {
            if (pulldownEnabled) {
                [self.firstTableView enablePulldownRefresh];
            }
            if (pullupEnabled) {
                [self.firstTableView enablePullupLoad];
            }
        }
            break;
        case 2:
        {
            if (pulldownEnabled) {
                [self.secondTableView enablePulldownRefresh];
            }
            if (pullupEnabled) {
                [self.secondTableView enablePullupLoad];
            }
        }
            break;
        case 3:
        {
            if (pulldownEnabled) {
                [self.thirdTableView enablePulldownRefresh];
            }
            if (pullupEnabled) {
                [self.thirdTableView enablePullupLoad];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)endPulldownRefreshWithTableViewIndex:(NSInteger)index
{
    if (![self isAvailableIndex:index]) {
        return;
    }
    switch (index) {
        case 1:
            [self.firstTableView endPulldownRefresh];
            break;
        case 2:
            [self.secondTableView endPulldownRefresh];
            break;
        case 3:
            [self.thirdTableView endPulldownRefresh];
            break;
            
        default:
            break;
    }
}

- (void)endPullupLoadWithTableViewIndex:(NSInteger)index
{
    if (![self isAvailableIndex:index]) {
        return;
    }
    switch (index) {
        case 1:
            [self.firstTableView endPullupLoad];
            break;
        case 2:
            [self.secondTableView endPullupLoad];
            break;
        case 3:
            [self.thirdTableView endPullupLoad];
            break;
            
        default:
            break;
    }
}

#pragma mark - Private
- (NSInteger)getIndexWithTableView:(RefreshAndLoadTableView *)tableView
{
    if (tableView == _firstTableView) {
        return 1;
    } else if (tableView == _secondTableView) {
        return 2;
    } else if (tableView == _thirdTableView) {
        return 3;
    } else {
        DebugLog(DebugLogTypeError, @"TableView对象比对出现错误");
        return 0;
    }
}

- (BOOL)isAvailableIndex:(NSInteger)index
{
    if (index > 3 || index < 1) {
        DebugLog(DebugLogTypeError, @"TableSelectView传入Index超限");
        return NO;
    }
    if (!self.thirdButtonNeeded) {
        if (index == 3) {
            DebugLog(DebugLogTypeError, @"TableSelectView传入Index超限");
            return NO;
        }
    }
    return YES;
}

#pragma mark - UITableViewDelegate/DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(numberForTableView:atIndex:)]) {
        return [self.delegate numberForTableView:(RefreshAndLoadTableView *)tableView atIndex:[self getIndexWithTableView:(RefreshAndLoadTableView *)tableView]];
    } else {
        DebugLog(DebugLogTypeError, @"TableSelectView代理类没有实现numberForTableView:atIndex:方法");
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(tableViewCellForTableView:atIndex:row:)]) {
        return [self.delegate tableViewCellForTableView:(RefreshAndLoadTableView *)tableView atIndex:[self getIndexWithTableView:(RefreshAndLoadTableView *)tableView] row:indexPath.row];
    } else {
        DebugLog(DebugLogTypeError, @"TableSelectView代理类没有实现tableViewCellForTableView:atIndex:row:方法");
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(didSelectTableView:atIndex:row:)]) {
        [self.delegate didSelectTableView:(RefreshAndLoadTableView *)tableView atIndex:[self getIndexWithTableView:(RefreshAndLoadTableView *)tableView] row:indexPath.row];
    } else {
        DebugLog(DebugLogTypeError, @"TableSelectView代理类没有实现didSelectTableView:atIndex:row:方法");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(cellHeightForTableView:anIndex:row:)]) {
        return [self.delegate cellHeightForTableView:(RefreshAndLoadTableView *)tableView anIndex:[self getIndexWithTableView:(RefreshAndLoadTableView *)tableView] row:indexPath.row];
    } else {
        //这里不需要输出error日志，返回默认高度44就可以
        //DebugLog(DebugLogTypeError, @"TableSelectView代理类没有实现cellHeightForTableView:atIndex:row:方法");
        return 44.0f;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
}

#pragma mark - RefreshAndLoadTableViewAgent
- (void)shouldStartPulldownRefreshWithTableView:(RefreshAndLoadTableView *)tableView
{
    if ([self.delegate respondsToSelector:@selector(shouldPulldownRefreshWithTableView:atIndex:)]) {
        [self.delegate shouldPulldownRefreshWithTableView:tableView atIndex:[self getIndexWithTableView:tableView]];
    } else {
        DebugLog(DebugLogTypeError, @"TableSelectView代理类没有实现shouldPulldownRefreshWithTableView:atIndex:方法");
    }
}

- (void)shouldStartPullupLoadWithTableView:(RefreshAndLoadTableView *)tableView
{
    if ([self.delegate respondsToSelector:@selector(shouldPullupLoadWithTableView:atIndex:)]) {
        [self.delegate shouldPullupLoadWithTableView:tableView atIndex:[self getIndexWithTableView:tableView]];
    } else {
        DebugLog(DebugLogTypeError, @"TableSelectView代理类没有实现shouldPullupLoadWithTableView:atIndex:方法");
    }
}

@end
