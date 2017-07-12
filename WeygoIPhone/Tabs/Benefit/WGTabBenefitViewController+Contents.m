//
//  WGTabBenefitViewController+Contents.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGTabBenefitViewController+Contents.h"
#import "WGClassifyDetailContentViewController.h"
#import "WGTabBenefitViewController+Request.h"
#import "WGClassifyDetailContentViewController+Request.h"
#import "WGTitleItem.h"

@implementation WGTabBenefitViewController (Contents)

- (void)addContentsWithIndex:(NSInteger)index {
    [self refreshContent:index cacheType:WGCacheTypeCachePrior];
}

//- (void)initTabContentDictionary {
//    if (_tabContentMDictionary) {
//        for (WGClassifyDetailContentViewController *item in _tabContentMDictionary) {
//            [item.view removeFromSuperview];
//            [item removeFromParentViewController];
//        }
//        [_tabContentMDictionary removeAllObjects];
//    }
//    _tabContentMDictionary = [[NSMutableDictionary alloc] init];
//    NSArray *
//    for (int num = 0; num < _titleArray.count; ++num) {
//        WGClassifyDetailContentViewController *contentVC = [[WGClassifyDetailContentViewController alloc] init];
//        if (_titleArray.count > num) {
//            WGTitleItem *item = _titleArray[num];
//            contentVC.classifyId = item.id;
//        }
//        contentVC.view.frame = CGRectMake(kDeviceWidth * num, 0, _contentsScrollView.width, _contentsScrollView.height);
//        WeakSelf;
//        contentVC.onTopRefresh = ^(void) {
//            [weakSelf handleRefresh];
//        };
//        [_contentsScrollView addSubview:contentVC.view];
//        [self addChildViewController:contentVC];
//        [_tabContentMDictionary setObject:contentVC forKey:@(num)];
//    }
//}

- (void)handleRefresh {
    [self refreshContent:_titleSegmentView.selectedIndex  cacheType:WGCacheTypeNetwork];
}

- (void)refreshContent:(NSInteger)index cacheType:(WGCacheType)cacheType {
    WGClassifyDetailContentViewController *contentVC = [_tabContentMDictionary objectForKey:@(index)];
    if (!contentVC) {
        contentVC = [[WGClassifyDetailContentViewController alloc] init];
        __weak id weakSelf = self;
        contentVC.onTopRefresh = ^(void) {
            [weakSelf handleRefresh];
        };
        NSArray *array = _dataResponse.data;
        if (array.count > index) {
            WGTitleItem *item = array[index];
            contentVC.classifyId = item.id;
        }
        contentVC.view.frame = CGRectMake(kDeviceWidth * index, 0, _contentsScrollView.width, _contentsScrollView.height);
        [_contentsScrollView addSubview:contentVC.view];
        [self addChildViewController:contentVC];
        [_tabContentMDictionary setObject:contentVC forKey:@(index)];
    }
    else {
        contentVC.view.frame = CGRectMake(kDeviceWidth * index, 0, _contentsScrollView.width, _contentsScrollView.height);
        NSArray *array = _dataResponse.data;
        if (array.count > index) {
            WGTitleItem *item = array[index];
            contentVC.classifyId = item.id;
        }
    }
    //contentVC.view.frame = CGRectMake(kDeviceWidth * index, 0, _contentsScrollView.width, _contentsScrollView.height);
    //[contentVC loadNeedCheckData:cacheType];
//    WGHome *homeData = [self dataWithIndex:index].data;
//    contentVC.homeData = homeData;
//    WGClassifyDetailContentViewController *contentVC = [_tabContentMDictionary objectForKey:@(index)];
//    [contentVC loadNeedCheckData];
}

@end
