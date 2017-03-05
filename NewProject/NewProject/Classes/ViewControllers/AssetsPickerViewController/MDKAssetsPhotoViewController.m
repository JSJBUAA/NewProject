//
//  MDKAssetsPhotoViewController.m
//  libMomoSDK
//
//  Created by 季川 on 15/4/5.
//  Copyright (c) 2015年 immomo. All rights reserved.
//

#import "MDKAssetsPhotoViewController.h"
#import "MDKAssetsViewController.h"
#import "MDMBProgressHUD+MDKUtility.h"

#define kThumbnailLength                            78.0f
#define kPhotoItemSize                              CGSizeMake(kThumbnailLength, kThumbnailLength)
#define kAssetsPhotoViewCellIdentifier              @"assetsPhotoViewCellIdentifier"
#define kAssetsPhotoSupplementaryViewIdentifier     @"assetsPhotoSupplementaryViewIdentifier"

@interface MDKAssetsPhotoViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *layout;
@property (nonatomic, retain) NSMutableArray *assets;
@property (nonatomic, retain) NSPredicate *selectionFilter;

@property (nonatomic, assign) MDKPhotoPickType photoPickType;      //用于标记单选/多选
@property (nonatomic, assign) NSInteger maxCount;                  //多选时用于标记此次最多可以选择几张图片
@property (nonatomic, retain) NSMutableArray *pickedImagesArray;   //用于存储已经选中的图片

@end

@implementation MDKAssetsPhotoViewController
- (id)init
{
    self = [super init];
    if (self) {
        self.assets = [NSMutableArray array];
        self.selectionFilter = [NSPredicate predicateWithValue:YES];
    }
    return self;
}

- (id)initWithPhotoPickType:(MDKPhotoPickType)photoPickType maxCount:(NSInteger)count
{
    self = [super init];
    if (self) {
        self.assets = [NSMutableArray array];
        self.selectionFilter = [NSPredicate predicateWithValue:YES];
        self.pickedImagesArray = [NSMutableArray array];
        self.photoPickType = photoPickType;
        self.maxCount = count;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(leftBarButtonItemTapped:)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(rightBarButtonItemTapped:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    rightBarButtonItem.enabled = NO;
    
    NSString *title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    self.navigationItem.title = title;
    
    [self.view addSubview:self.collectionView];
    
    [self accessAssets];
}

#pragma mark -
- (void)accessAssets
{
    // 先把数组清空
    if (self.assets.count != 0) {
        [self.assets removeAllObjects];
    }
    
    [self.assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            if ([[result valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypePhoto]) {
                [self.assets addObject:result];  //只访问照片,不访问视频
            }
        } else {
            if (self.assets.count > 0 ) { //检查下数组中是否有注入asset了
                [self.collectionView reloadData];
            } else {
                
            }
        }
    }];
}

#pragma mark - Getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        CGRect frame = CGRectMake(0, 0, [ProjectUtility getScreenWidth], [ProjectUtility getScreenHeight]-self.navigationController.navigationBar.frame.size.height);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        if (self.photoPickType == MDKPhotoPickTypeMultiple) {
            //如果当前是多选模式，需要打开支持。
            _collectionView.allowsMultipleSelection = YES;
        }
        
        [_collectionView registerClass:[MDKAssetsPhotoViewCell class]
            forCellWithReuseIdentifier:kAssetsPhotoViewCellIdentifier];
        
        [_collectionView registerClass:[MDKAssetsPhotoSupplementaryView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:kAssetsPhotoSupplementaryViewIdentifier];
    }
    
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = kPhotoItemSize;
        _layout.footerReferenceSize = CGSizeMake(0, 44.0f);
        
        if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
            _layout.sectionInset = UIEdgeInsetsMake(2.0f, 2.0f, 0, 2.0f);
            _layout.minimumInteritemSpacing = 3.0f;
            _layout.minimumLineSpacing = 3.0f;
        } else {
            _layout.sectionInset = UIEdgeInsetsMake(1.0f, 1.0f, 0, 1.0f);
            _layout.minimumInteritemSpacing = 2.0f;
            _layout.minimumLineSpacing = 2.0f;
        }
    }
    return _layout;
}

#pragma mark - Target Action
- (void)leftBarButtonItemTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarButtonItemTapped:(id)sender
{
    MDKAssetsViewController *assetsViewController = (MDKAssetsViewController *)self.navigationController;
    /*点击确定时需要区分选择类型，执行不同的回调方法*/
    if (self.photoPickType == MDKPhotoPickTypeMultiple) {
        //多选，传图片数组
        if ([assetsViewController.agent respondsToSelector:@selector(assetsViewController:didFinishPickingImagesArray:)]) {
            [assetsViewController.agent assetsViewController:assetsViewController didFinishPickingImagesArray:self.pickedImagesArray];
        }
        [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    } else if (self.photoPickType == MDKPhotoPickTypeSingle) {
        //单选，直接传选中图片
        if ([assetsViewController.agent respondsToSelector:@selector(assetsViewController:didFinishPickingAsset:)]) {
            NSIndexPath *indexPathForSelectedItem = [[self.collectionView indexPathsForSelectedItems] firstObject];
            ALAsset *asset = self.assets[indexPathForSelectedItem.row];
            [assetsViewController.agent assetsViewController:assetsViewController didFinishPickingAsset:asset];
        }
        [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    } else if (self.photoPickType == MDKPhotoPickTypeForEdit) {
        NSIndexPath *indexPathForSelectedItem = [[self.collectionView indexPathsForSelectedItems] firstObject];
        ALAsset *asset = self.assets[indexPathForSelectedItem.row];
        ALAssetRepresentation *representation = [asset defaultRepresentation];
        UIImage *fullResolutionImage = [UIImage imageWithCGImage:representation.fullResolutionImage
                                                           scale:1.0f
                                                     orientation:(UIImageOrientation)representation.orientation];
#pragma warning - 这里是裁剪情况，暂时不用
//        if (fullResolutionImage) {
//            MDKImageCropViewController *cropVC = [[[MDKImageCropViewController alloc] initWithImage:fullResolutionImage needCrop:YES] autorelease];
//            cropVC.delegate = self;
//            cropVC.imageComeFromLibrary = YES;
//            [self.navigationController pushViewController:cropVC animated:YES];
//        } else {
//            MDKLog(MDKLogTypeWarning, @"数据异常,%@", fullResolutionImage);
//            if ([assetsViewController.agent respondsToSelector:@selector(assetsViewControllerDidCancel:)]) {
//                [assetsViewController.agent assetsViewControllerDidCancel:assetsViewController];
//            }
//        }
        
        
    }
    
//    [self.presentingViewController dismissModalViewControllerAnimated:NO];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MDKAssetsPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAssetsPhotoViewCellIdentifier
                                                                             forIndexPath:indexPath];
    [cell refresh:self.assets[indexPath.row]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MDKAssetsPhotoSupplementaryView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                               withReuseIdentifier:kAssetsPhotoSupplementaryViewIdentifier
                                                                                      forIndexPath:indexPath];
    [view refresh:self.assets.count];
    return view;
}

#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.photoPickType == MDKPhotoPickTypeMultiple) {
        //多选时需要限定数量，超出不可再选
        if (self.pickedImagesArray.count >= self.maxCount) {
            [MDMBProgressHUD MDshowWarningWithText:@"最多只能选择6张图片"];
            return NO;
        } else {
            return YES;
        }
    } else {
        NSIndexPath *indexPathForPreSelectedItem = [[collectionView indexPathsForSelectedItems] firstObject];
        if (indexPathForPreSelectedItem == nil) {
            return YES;
        }
        [collectionView deselectItemAtIndexPath:indexPathForPreSelectedItem animated:YES];
        
        if (indexPath.row == indexPathForPreSelectedItem.row && indexPath.section == indexPathForPreSelectedItem.section) {
            self.navigationItem.rightBarButtonItem.enabled = NO;
            return NO;
        }
        return YES;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.navigationItem.rightBarButtonItem.enabled = YES;
    if (self.photoPickType == MDKPhotoPickTypeMultiple) {
        //多选时需要将选中的图片加入数组储存
        ALAsset *asset = self.assets[indexPath.row];
        if (asset) {
            [self.pickedImagesArray addObject:asset];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.photoPickType == MDKPhotoPickTypeMultiple) {
        //多选时，反选（取消选中）需要将图片从数组移除；同时如果数组元素为0时，禁用右上方“确定”按钮
        ALAsset *asset = self.assets[indexPath.row];
        [self.pickedImagesArray removeObject:asset];
        if (self.pickedImagesArray.count == 0) {
            self.navigationItem.rightBarButtonItem.enabled = NO;
        }
    } else {
        //单选时，取消选中直接禁用右上方“确定”按钮
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

#pragma warning - 裁剪图片相关，暂不考虑
#pragma mark - MDKCropImageDelegate
//- (void)MDKImageCropViewController:(MDKImageCropViewController *)cropVC resultImage:(UIImage *)image
//{
//    MDKAssetsViewController *assetsViewController = (MDKAssetsViewController *)self.navigationController;
//    if (image) {
//        if ([assetsViewController.agent respondsToSelector:@selector(assetsViewController:didFinishPickLibraryEditedImage:)]) {
//            [assetsViewController.agent assetsViewController:assetsViewController didFinishPickLibraryEditedImage:image];
//        }
//    }
//    [cropVC.navigationController popViewControllerAnimated:NO];
//    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
//}

@end


#pragma mark -
@interface MDKAssetsPhotoViewCell ()
@property (nonatomic, retain) ALAsset *asset;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIImage *checkedIcon;
@property (nonatomic, copy) NSString *typeStr;
@end

@implementation MDKAssetsPhotoViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *checkedIconImageName = @"IMAGE.bundle/CTAssetsPickerChecked";
        self.checkedIcon = [UIImage imageNamed:checkedIconImageName];
    }
    return self;
}

- (void)refresh:(ALAsset *)asset
{
    self.asset = asset;
    self.image = [UIImage imageWithCGImage:asset.thumbnail];
    self.typeStr = [asset valueForProperty:ALAssetPropertyType];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [self.image drawInRect:CGRectMake(0, 0, kThumbnailLength, kThumbnailLength)];
    
    if (self.selected) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:1 alpha:0.5].CGColor);
        CGContextFillRect(context, rect);
        [_checkedIcon drawAtPoint:CGPointMake(CGRectGetMaxX(rect) - _checkedIcon.size.width, CGRectGetMinY(rect))];
    }
}

@end


#pragma mark -
@interface MDKAssetsPhotoSupplementaryView ()
@property (nonatomic, retain) UILabel *sectionLabel;
@end

@implementation MDKAssetsPhotoSupplementaryView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.sectionLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.bounds, 8.0f, 8.0f)];
        _sectionLabel.font = [UIFont systemFontOfSize:18.0f];
        _sectionLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_sectionLabel];
    }
    return self;
}

- (void)refresh:(NSInteger)numberOfPhotos
{
    self.sectionLabel.text = [NSString stringWithFormat:@"%ld Photos", (long)numberOfPhotos];
}

@end

