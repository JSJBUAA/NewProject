//
//  MDKAssetsGroupViewController.m
//  libMomoSDK
//
//  Created by 季川 on 15/4/3.
//  Copyright (c) 2015年 immomo. All rights reserved.
//

#import "MDKAssetsGroupViewController.h"
#import "MDKAssetsPhotoViewController.h"
#import "MDKAssetsViewController.h"

@interface MDKAssetsGroupViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UINavigationBar *navigationBar;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *groups;
@property (nonatomic, retain) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, retain) ALAssetsFilter *assetsFilter;

@property (nonatomic, assign) MDKPhotoPickType photoPickType;      //用于标记多选/单选
@property (nonatomic, assign) NSInteger maxCount;                  //多选时标记本次最多可以选择几张

@end

@implementation MDKAssetsGroupViewController
- (id)init
{
    self = [super init];
    if (self) {
        self.groups = [NSMutableArray array];
        self.assetsLibrary = [[ALAssetsLibrary alloc] init];
        self.assetsFilter = [ALAssetsFilter allAssets];
        //默认初始化方法在客服反馈、提交问题中使用，仅单选
        self.photoPickType = MDKPhotoPickTypeSingle;
    }
    return self;
}

- (id)initWithPhotoPickType:(MDKPhotoPickType)photoPickType maxCount:(NSInteger)count
{
    self = [super init];
    if (self) {
        self.groups = [NSMutableArray array];
        self.assetsLibrary = [[ALAssetsLibrary alloc] init];
        self.assetsFilter = [ALAssetsFilter allAssets];
        self.photoPickType = photoPickType;
        self.maxCount = count;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"相簿";
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭"
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(leftBarButtonItemTapped:)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    [self.view addSubview:self.tableView];
    
    [self accessAssetsGroup];
}

#pragma mark - Target Action
- (void)leftBarButtonItemTapped:(id)sender
{
    MDKAssetsViewController *assetsViewController = (MDKAssetsViewController *)self.navigationController;
    if ([assetsViewController.agent respondsToSelector:@selector(assetsViewControllerDidCancel:)]) {
        [assetsViewController.agent assetsViewControllerDidCancel:assetsViewController];
    }
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Getter
- (UITableView *)tableView
{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, [ProjectUtility getScreenWidth], [ProjectUtility getScreenHeight]-self.navigationController.navigationBar.frame.size.height);

        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 44.0f*1.5f;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor colorWithRed:247/255.0 green:248/255.0 blue:236/255.0 alpha:1.0];
        _tableView = tableView;
    }
    return _tableView;
}

- (void)accessAssetsGroup
{
    // 先把数组清空
    if (self.groups.count != 0) {
        [self.groups removeAllObjects];
    }
    
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group setAssetsFilter:_assetsFilter];
            if (group.numberOfAssets > 0) {
                [_groups addObject:group];
            }
        } else {
            [self reloadData];
        }
    } failureBlock:^(NSError *error) {
        [self showAccessFail];
    }];
}

- (void)reloadData
{
    if (_groups.count == 0 || _groups == nil) {
        [self showNoAssets];
    } else {
        [self.tableView reloadData];
    }
}

- (void)showAccessFail
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeLeft | UIRectEdgeRight | UIRectEdgeBottom];
    }
    
    self.title              = nil;
    
    UIImageView *padlock    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IMAGE.bundle/CTAssetsPickerLocked"]];
    padlock.translatesAutoresizingMaskIntoConstraints = NO;
    
    UILabel *title          = [[UILabel alloc] init];
    title.translatesAutoresizingMaskIntoConstraints = NO;
    title.preferredMaxLayoutWidth = 304.0f;
    
    UILabel *message        = [[UILabel alloc] init];
    message.translatesAutoresizingMaskIntoConstraints = NO;
    message.preferredMaxLayoutWidth = 304.0f;
    
    title.text              = @"此应用程序没有权限来访问您的照片";
    title.font              = [UIFont boldSystemFontOfSize:17.0];
    title.textColor         = [UIColor colorWithRed:129.0/255.0 green:136.0/255.0 blue:148.0/255.0 alpha:1];
    title.textAlignment     = NSTextAlignmentCenter;
    title.numberOfLines     = 5;
    
    message.text            = @"您可以在隐私设置里打开权限";
    message.font            = [UIFont systemFontOfSize:14.0];
    message.textColor       = [UIColor colorWithRed:129.0/255.0 green:136.0/255.0 blue:148.0/255.0 alpha:1];
    message.textAlignment   = NSTextAlignmentCenter;
    message.numberOfLines   = 5;
    
    [title sizeToFit];
    [message sizeToFit];
    
    UIView *centerView = [[UIView alloc] init];
    centerView.translatesAutoresizingMaskIntoConstraints = NO;
    [centerView addSubview:padlock];
    [centerView addSubview:title];
    [centerView addSubview:message];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(padlock, title, message);
    
    [centerView addConstraint:[NSLayoutConstraint constraintWithItem:padlock attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:centerView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [centerView addConstraint:[NSLayoutConstraint constraintWithItem:title attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:padlock attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [centerView addConstraint:[NSLayoutConstraint constraintWithItem:message attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:padlock attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [centerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[padlock]-[title]-[message]|" options:0 metrics:nil views:viewsDictionary]];
    
    UIView *backgroundView = [[UIView alloc] init];
    [backgroundView addSubview:centerView];
    [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    
    self.tableView.backgroundView = backgroundView;
}

- (void)showNoAssets
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeLeft | UIRectEdgeRight | UIRectEdgeBottom];
    }
    
    UILabel *title          = [[UILabel alloc] init];
    title.translatesAutoresizingMaskIntoConstraints = NO;
    title.preferredMaxLayoutWidth = 304.0f;
    UILabel *message        = [[UILabel alloc] init];
    message.translatesAutoresizingMaskIntoConstraints = NO;
    message.preferredMaxLayoutWidth = 304.0f;
    
    title.text              = @"无照片";
    title.font              = [UIFont systemFontOfSize:26.0];
    title.textColor         = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
    title.textAlignment     = NSTextAlignmentCenter;
    title.numberOfLines     = 5;
    
    message.text            = @"您可以用iTunes同步照片到此设备中";
    message.font            = [UIFont systemFontOfSize:18.0];
    message.textColor       = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
    message.textAlignment   = NSTextAlignmentCenter;
    message.numberOfLines   = 5;
    
    [title sizeToFit];
    [message sizeToFit];
    
    UIView *centerView = [[UIView alloc] init];
    centerView.translatesAutoresizingMaskIntoConstraints = NO;
    [centerView addSubview:title];
    [centerView addSubview:message];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(title, message);
    
    [centerView addConstraint:[NSLayoutConstraint constraintWithItem:title attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:centerView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [centerView addConstraint:[NSLayoutConstraint constraintWithItem:message attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:title attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [centerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[title]-[message]|" options:0 metrics:nil views:viewsDictionary]];
    
    UIView *backgroundView = [[UIView alloc] init];
    [backgroundView addSubview:centerView];
    [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:centerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    
    self.tableView.backgroundView = backgroundView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    MDKAssetsGroupViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MDKAssetsGroupViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                              reuseIdentifier:cellIdentifier];
    }
    [cell refresh:_groups[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MDKAssetsPhotoViewController *assetsPhotoVC = [[MDKAssetsPhotoViewController alloc] initWithPhotoPickType:self.photoPickType maxCount:self.maxCount];
    assetsPhotoVC.assetsGroup = self.groups[indexPath.row];
    
    [self.navigationController pushViewController:assetsPhotoVC animated:YES];
}

@end


#pragma mark -
@implementation MDKAssetsGroupViewCell

- (void)refresh:(ALAssetsGroup *)assetsGroup
{
    size_t height = CGImageGetHeight(assetsGroup.posterImage);
    float scale = height / 60.0f;
    UIImage *groupImage = [UIImage imageWithCGImage:assetsGroup.posterImage
                                              scale:scale
                                        orientation:UIImageOrientationUp];

    self.imageView.image = groupImage;
    self.textLabel.text = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    self.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)[assetsGroup numberOfAssets]];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
