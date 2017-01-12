//
//  WGHomeTabViewController+Contents.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeTabViewController+Contents.h"
#import "WGHomeTabContentViewController.h"

@implementation WGHomeTabViewController (Contents)

- (void)addContentsWithIndex:(NSInteger)index {
    WGHomeTabBaseContentViewController *contentVC = [_tabContentMDictionary objectForKey:@(index)];
    if (!contentVC) {
        contentVC = [[WGHomeTabContentViewController alloc] init];
        contentVC.view.frame = CGRectMake(kDeviceWidth * index, 0, _contentsScrollView.width, _contentsScrollView.height);
        [_contentsScrollView addSubview:contentVC.view];
        [self addChildViewController:contentVC];
        [_tabContentMDictionary setObject:contentVC forKey:@(index)];
    }
    [contentVC loadData:nil];
}

@end
