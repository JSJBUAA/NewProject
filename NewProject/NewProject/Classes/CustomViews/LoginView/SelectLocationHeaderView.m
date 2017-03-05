//
//  SelectLocationHeaderView.m
//  NewProject
//
//  Created by jiangshiju on 2017/3/5.
//  Copyright © 2017年 jiangshiju. All rights reserved.
//

#import "SelectLocationHeaderView.h"
#import <MapKit/MapKit.h>

@interface SelectLocationHeaderView () <MKMapViewDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;//搜索框，暂时不加
@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation SelectLocationHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.mapView];
    }
    return self;
}

- (MKMapView *)mapView
{
    if (!_mapView) {
        MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        mapView.mapType = MKMapTypeStandard;
        mapView.showsUserLocation = YES;
        mapView.scrollEnabled = NO;
        mapView.zoomEnabled = NO;
        mapView.rotateEnabled = NO;
        mapView.delegate = self;
        _mapView = mapView;
    }
    return _mapView;
}

@end
