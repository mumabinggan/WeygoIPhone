//
//  WGCommonViewController+Contents.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommonViewController+Contents.h"
#import "WGHomeTabContentViewController.h"
#import "WGCommonViewController+Request.h"
#import "WGTitleItem.h"

@implementation WGCommonViewController (Contents)

- (void)addContentsWithIndex:(NSInteger)index {
    WGTitleItem *item = [self dataWithIndex:index];
    [self loadContentWithMenuId:item.id cacheType:WGCacheTypeCachePrior];
//    if (item == nil || item.data == nil) {
//        
//    }
}

- (void)setTabContentDictionary:(NSInteger)index {
    WGHomeTabContentViewController *contentVC = [_tabContentMDictionary objectForKey:@(index)];
    if (!contentVC) {
        contentVC = [[WGHomeTabContentViewController alloc] init];
        __weak id weakSelf = self;
        contentVC.onTopRefresh = ^(void) {
            [weakSelf handleRefresh];
        };
        [_contentsScrollView addSubview:contentVC.view];
        [self addChildViewController:contentVC];
        [_tabContentMDictionary setObject:contentVC forKey:@(index)];
    }
    contentVC.view.frame = CGRectMake(kDeviceWidth * index, 0, _contentsScrollView.width, _contentsScrollView.height);
    WGHome *homeData = (WGHome *)[self dataWithIndex:index].data;
    contentVC.homeData = homeData;
}

//- (void)initTabContentDictionary {
//    if (_tabContentMDictionary) {
//        for (WGHomeTabContentViewController *item in _tabContentMDictionary) {
//            [item.view removeFromSuperview];
//            [item removeFromParentViewController];
//        }
//        [_tabContentMDictionary removeAllObjects];
//    }
//    _tabContentMDictionary = [[NSMutableDictionary alloc] init];
//    for (int num = 0; num < _titleArray.count; ++num) {
//        WGHomeTabContentViewController *contentVC = [[WGHomeTabContentViewController alloc] init];
//        contentVC.view.frame = CGRectMake(kDeviceWidth * num, 0, _contentsScrollView.width, _contentsScrollView.height);
//        __weak id weakSelf = self;
//        contentVC.onTopRefresh = ^(void) {
//            [weakSelf handleRefresh];
//        };
//        contentVC.view.tag = 10000 + num;
//        [_contentsScrollView addSubview:contentVC.view];
//        [self addChildViewController:contentVC];
//        [_tabContentMDictionary setObject:contentVC forKey:@(num)];
//    }
//}

- (void)handleRefresh {
    long menuId = [self menuIdWithIndex:_titleSegmentView.selectedIndex];
    if (menuId >= 0) {
        [self loadContentWithMenuId:menuId cacheType:WGCacheTypeNetwork];
    }
    //[self loadData];
}

- (void)refreshContent:(NSInteger)index {
    [self setTabContentDictionary:index];
}

@end
