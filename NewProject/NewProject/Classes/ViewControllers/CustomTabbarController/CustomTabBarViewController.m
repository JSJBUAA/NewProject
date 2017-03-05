//
//  CustomTabBarViewController.m
//  NewProject
//
//  Created by jiangshiju on 17/2/21.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "CustomTabBarCentralItem.h"
#import "FirstTestViewController.h"
#import "ActivityViewController.h"
#import "FourthTestViewController.h"
#import "PersonalViewController.h"
#import "GroupViewController.h"

@interface CustomTabBarViewController ()

@property (nonatomic, strong) CustomTabBarItem *messageItem;
@property (nonatomic, strong) CustomTabBarItem *groupItem;
@property (nonatomic, strong) CustomTabBarCentralItem *activityItem;
@property (nonatomic, strong) CustomTabBarItem *lifeItem;
@property (nonatomic, strong) CustomTabBarItem *personalItem;

@end

@implementation CustomTabBarViewController

- (instancetype)initAllModuleViewControllers
{
    if (self = [super init]) {
        [self configAllModuleViewControllers];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.tabBar.hidden) {
        self.tabBar.hidden = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!self.tabBar.hidden) {
        self.tabBar.hidden = YES;
    }
    self.selectedIndex = 0;
    [self configTabBarItems];
}

- (void)configAllModuleViewControllers
{
    FirstTestViewController *firstVC = [[FirstTestViewController alloc] initWithTitle:@"消息"];
    
    GroupViewController *groupViewController = [[GroupViewController alloc] initWithTitle:@"群组" leftButtonTitle:nil rightButtonTitle:@"搜索"];
    UINavigationController *groupNavViewController = [[UINavigationController alloc] initWithRootViewController:groupViewController];
    
    ActivityViewController *activityViewController = [[ActivityViewController alloc] initWithTitle:@"活动" leftButtonTitle:nil rightButtonTitle:@"发起活动"];
    UINavigationController *activityNavViewController = [[UINavigationController alloc] initWithRootViewController:activityViewController];
    
    
    FourthTestViewController *fourthVC = [[FourthTestViewController alloc] initWithTitle:@"生活"];
    
    
    PersonalViewController *personalViewController = [[PersonalViewController alloc] initWithTitle:@"个人" leftButtonTitle:nil rightButtonTitle:@"设置"];
    UINavigationController *personalNavViewController = [[UINavigationController alloc] initWithRootViewController:personalViewController];
    
    
    self.viewControllers = [NSArray arrayWithObjects:firstVC,groupNavViewController,activityNavViewController,fourthVC,personalNavViewController, nil];
}

- (void)configTabBarItems
{
    [self.view addSubview:self.customTabBar];
    [self.customTabBar addSubview:self.messageItem];
    [self.customTabBar addSubview:self.groupItem];
    [self.customTabBar addSubview:self.activityItem];
    [self.customTabBar addSubview:self.lifeItem];
    [self.customTabBar addSubview:self.personalItem];
}

#pragma mark - Getter
- (UIView *)customTabBar
{
    if (!_customTabBar) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, [ProjectUtility getScreenHeight] - 50.0f, [ProjectUtility getScreenWidth], 50.0f)];
        view.backgroundColor = [UIColor clearColor];
        _customTabBar = view;
    }
    return _customTabBar;
}

- (CustomTabBarItem *)messageItem
{
    if (!_messageItem) {
        CustomTabBarItem *item = [[CustomTabBarItem alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kPhoneTabBarItemWidth, kPhoneTabBarItemHeight) image:nil selectedImage:nil title:@"消息"];
        item.index = 0;
        [item addTarget:self touchInsideAction:@selector(didClickItem:)];
        [item setSelectedStatus];
        _messageItem = item;
    }
    return _messageItem;
}

- (CustomTabBarItem *)groupItem
{
    if (!_groupItem) {
        CustomTabBarItem *item = [[CustomTabBarItem alloc] initWithFrame:CGRectMake(kPhoneTabBarItemWidth, 0.0f, kPhoneTabBarItemWidth, kPhoneTabBarItemHeight) image:nil selectedImage:nil title:@"群组"];
        item.index = 1;
        [item addTarget:self touchInsideAction:@selector(didClickItem:)];
        _groupItem = item;
    }
    return _groupItem;
}

- (CustomTabBarCentralItem *)activityItem
{
    if (!_activityItem) {
        CustomTabBarCentralItem *item = [[CustomTabBarCentralItem alloc] initWithFrame:CGRectMake(2 * kPhoneTabBarItemWidth, -10.0f, kPhoneTabBarCentralItemWidth, kPhoneTabBarItemHeight + 10.0f) image:nil selectedImage:nil title:@"活动"];
        item.index = 2;
        item.backgroundColor = [UIColor clearColor];
        [item addTarget:self touchInsideAction:@selector(didClickItem:)];
        _activityItem = item;
    }
    return _activityItem;
}

- (CustomTabBarItem *)lifeItem
{
    if (!_lifeItem) {
        CustomTabBarItem *item = [[CustomTabBarItem alloc] initWithFrame:CGRectMake(2 * kPhoneTabBarItemWidth + kPhoneTabBarCentralItemWidth, 0.0f, kPhoneTabBarItemWidth, kPhoneTabBarItemHeight) image:nil selectedImage:nil title:@"生活"];
        item.index = 3;
        [item addTarget:self touchInsideAction:@selector(didClickItem:)];
        _lifeItem = item;
    }
    return _lifeItem;
}

- (CustomTabBarItem *)personalItem
{
    if (!_personalItem) {
        CustomTabBarItem *item = [[CustomTabBarItem alloc] initWithFrame:CGRectMake(3 *kPhoneTabBarItemWidth + kPhoneTabBarCentralItemWidth, 0.0f, kPhoneTabBarItemWidth, kPhoneTabBarItemHeight) image:nil selectedImage:nil title:@"个人"];
        item.index = 4;
        [item addTarget:self touchInsideAction:@selector(didClickItem:)];
        _personalItem = item;
    }
    return _personalItem;
}

#pragma mark - TargetAction
- (void)didClickItem:(CustomTabBarItem *)item
{
    if (item.index == self.selectedIndex) {
        return;
    }
    [[self getPreviousItem] cancelSelectedStatus];
    self.selectedIndex = item.index;
}

#pragma mark - Private
- (CustomTabBarItem *)getPreviousItem
{
    CustomTabBarItem *item = nil;
    switch (self.selectedIndex) {
        case 0:
            item = self.messageItem;
            break;
        case 1:
            item = self.groupItem;
            break;
        case 2:
            item = self.activityItem;
            break;
        case 3:
            item = self.lifeItem;
            break;
        case 4:
            item = self.personalItem;
            break;
            
        default:
            break;
    }
    return item;
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
