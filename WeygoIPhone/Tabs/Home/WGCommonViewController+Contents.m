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

@implementation WGCommonViewController (Contents)

- (void)addContentsWithIndex:(NSInteger)index {
    if ([_tabDataMDictionary objectForKey:@(index)] == nil) {
        [self loadContentWithIndex:index isFirst:NO];
    };
    /*
    WGHomeTabContentViewController *contentVC = [_tabContentMDictionary objectForKey:@(index)];
    if (!contentVC) {
        contentVC = [[WGHomeTabContentViewController alloc] init];
        contentVC.view.frame = CGRectMake(kDeviceWidth * index, 0, _contentsScrollView.width, _contentsScrollView.height);
        [_contentsScrollView addSubview:contentVC.view];
        [self addChildViewController:contentVC];
        [_tabContentMDictionary setObject:contentVC forKey:@(index)];
    }
    //[contentVC loadData:nil];
    contentVC.homeData = nil;
     */
}

- (void)initTabContentDictionary {
    if (_tabContentMDictionary) {
        for (WGHomeTabContentViewController *item in _tabContentMDictionary) {
            [item.view removeFromSuperview];
            [item removeFromParentViewController];
        }
        [_tabContentMDictionary removeAllObjects];
    }
    _tabContentMDictionary = [[NSMutableDictionary alloc] init];
    for (int num = 0; num < _titleArray.count; ++num) {
        WGHomeTabContentViewController *contentVC = [[WGHomeTabContentViewController alloc] init];
        contentVC.view.frame = CGRectMake(kDeviceWidth * num, 0, _contentsScrollView.width, _contentsScrollView.height);
        __weak id weakSelf = self;
        contentVC.onTopRefresh = ^(void) {
            [weakSelf handleRefresh];
        };
        [_contentsScrollView addSubview:contentVC.view];
        [self addChildViewController:contentVC];
        [_tabContentMDictionary setObject:contentVC forKey:@(num)];
    }
}

- (void)handleRefresh {
    [self loadContentWithIndex:_titleSegmentView.selectedIndex isFirst:NO];
    //[self loadData];
}

- (void)refreshContent:(NSInteger)index {
    WGHomeTabContentViewController *contentVC = [_tabContentMDictionary objectForKey:@(index)];
    WGHome *homeData = [_tabDataMDictionary objectForKey:@(index)];
    contentVC.homeData = homeData;
}

@end
