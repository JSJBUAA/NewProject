//
//  MDKAssetsGroupViewController.h
//  libMomoSDK
//
//  Created by 季川 on 15/4/3.
//  Copyright (c) 2015年 immomo. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "MDKAssetsViewController.h"

/**
 * ============================================
 * 相簿选取视图控制器
 * ============================================
 */
@interface MDKAssetsGroupViewController : UIViewController

- (id)initWithPhotoPickType:(MDKPhotoPickType)photoPickType maxCount:(NSInteger)maxCount;

@end


/**
 * ============================================
 * 相簿Cell
 * ============================================
 */
@interface MDKAssetsGroupViewCell : UITableViewCell

- (void)refresh:(ALAssetsGroup *)assetsGroup;

@end
