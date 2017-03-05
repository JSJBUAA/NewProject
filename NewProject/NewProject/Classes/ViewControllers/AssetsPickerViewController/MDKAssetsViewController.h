//
//  MDKAssetsViewController.h
//  libMomoSDK
//
//  Created by 季川 on 15/4/3.
//  Copyright (c) 2015年 immomo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MDKPhotoPickTypeSingle,
    MDKPhotoPickTypeMultiple,
    MDKPhotoPickTypeForEdit,      //允许裁剪
} MDKPhotoPickType;

@protocol MDKAssetsDelegate;
@class ALAsset;

/**
 * ============================================
 * 相册导航控制器,负责总体调度和回调.
 * 支持单选、多选和多选编辑(裁剪)三种模式.
 * Availability iOS (6.0 and later)
 * ============================================
 */
@interface MDKAssetsViewController : UINavigationController

@property (nonatomic, assign) id<MDKAssetsDelegate> agent;

- (id)initWithDelegate:(id<MDKAssetsDelegate>)delegate;

//新增的通过类型进行区分的方法，支持多选
- (id)initWithDelegate:(id<MDKAssetsDelegate>)delegate photoPickType:(MDKPhotoPickType)type maxCount:(NSInteger)count;

@end

@protocol MDKAssetsDelegate <NSObject>
@optional
- (void)assetsViewController:(MDKAssetsViewController *)controller didFinishPickingAsset:(ALAsset *)asset;
- (void)assetsViewControllerDidCancel:(MDKAssetsViewController *)controller;

//图片多选的回调方法
- (void)assetsViewController:(MDKAssetsViewController *)controller didFinishPickingImagesArray:(NSArray *)pickedImagesArray;

- (void)assetsViewController:(MDKAssetsViewController *)controller didFinishPickLibraryEditedImage:(UIImage *)image;

@end
