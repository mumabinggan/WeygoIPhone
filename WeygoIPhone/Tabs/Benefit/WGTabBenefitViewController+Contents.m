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
    [self refreshContent:index];
}

- (void)initTabContentDictionary {
    if (_tabContentMDictionary) {
        for (WGClassifyDetailContentViewController *item in _tabContentMDictionary) {
            [item.view removeFromSuperview];
            [item removeFromParentViewController];
        }
        [_tabContentMDictionary removeAllObjects];
    }
    _tabContentMDictionary = [[NSMutableDictionary alloc] init];
    for (int num = 0; num < _titleArray.count; ++num) {
        WGClassifyDetailContentViewController *contentVC = [[WGClassifyDetailContentViewController alloc] init];
        if (_titleArray.count > num) {
            WGTitleItem *item = _titleArray[num];
            contentVC.classifyId = item.id;
        }
        contentVC.view.frame = CGRectMake(kDeviceWidth * num, 0, _contentsScrollView.width, _contentsScrollView.height);
        WeakSelf;
        contentVC.onTopRefresh = ^(void) {
            [weakSelf handleRefresh];
        };
        [_contentsScrollView addSubview:contentVC.view];
        [self addChildViewController:contentVC];
        [_tabContentMDictionary setObject:contentVC forKey:@(num)];
    }
}

- (void)handleRefresh {
    [self refreshContent:_titleSegmentView.selectedIndex];
}

- (void)refreshContent:(NSInteger)index {
    WGClassifyDetailContentViewController *contentVC = [_tabContentMDictionary objectForKey:@(index)];
    [contentVC loadNeedCheckData];
}

@end
