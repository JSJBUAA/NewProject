//
//  MDKAssetsViewController.m
//  libMomoSDK
//
//  Created by 季川 on 15/4/3.
//  Copyright (c) 2015年 immomo. All rights reserved.
//

#import "MDKAssetsViewController.h"
#import "MDKAssetsGroupViewController.h"

@implementation MDKAssetsViewController

- (id)initWithDelegate:(id<MDKAssetsDelegate>)delegate
{
    MDKAssetsGroupViewController *assetsGroupViewController = [[MDKAssetsGroupViewController alloc] init];
    self = [super initWithRootViewController:assetsGroupViewController];
    if (self) {
        self.agent = delegate;
    }
    
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
//    if ([MDKUtility systemVersion] >= 8.0 && [MDKUtility isPhoneDevice]) {
//        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//        assetsGroupViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    }
//#endif
    
    return self;
}

- (id)initWithDelegate:(id<MDKAssetsDelegate>)delegate photoPickType:(MDKPhotoPickType)type maxCount:(NSInteger)count
{
    MDKAssetsGroupViewController *assetsGroupViewController = [[MDKAssetsGroupViewController alloc] initWithPhotoPickType:type maxCount:count];
    self = [super initWithRootViewController:assetsGroupViewController];
    if (self) {
        self.agent = delegate;
        
    }
    
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
//    if ([MDKUtility systemVersion] >= 8.0 && [MDKUtility isPhoneDevice]) {
//        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//        assetsGroupViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    }
//    if ([MDKUtility isPadDevice]) {
//        self.modalPresentationStyle = UIModalPresentationFullScreen;
//        assetsGroupViewController.modalPresentationStyle = UIModalPresentationFullScreen;
//    }
//    
//#endif
    
    return self;
}

@end
