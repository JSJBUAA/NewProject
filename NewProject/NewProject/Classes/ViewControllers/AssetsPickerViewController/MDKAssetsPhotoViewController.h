//
//  MDKAssetsPhotoViewController.h
//  libMomoSDK
//
//  Created by 季川 on 15/4/5.
//  Copyright (c) 2015年 immomo. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "MDKAssetsViewController.h"

/**
 * ============================================
 * 相片选取视图控制器
 * ============================================
 */
@interface MDKAssetsPhotoViewController : UIViewController

@property (nonatomic, retain) ALAssetsGroup *assetsGroup;

- (id)initWithPhotoPickType:(MDKPhotoPickType)photoPickType maxCount:(NSInteger)count;

@end


/**
 * ============================================
 * 相片Cell
 * ============================================
 */
@interface MDKAssetsPhotoViewCell : UICollectionViewCell
- (void)refresh:(ALAsset *)asset;
@end


/**
 * ============================================
 * 补充视图
 * ============================================
 */
@interface MDKAssetsPhotoSupplementaryView : UICollectionReusableView
- (void)refresh:(NSInteger)numberOfPhotos;
@end
