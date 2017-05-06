//
//  WGCommonViewController+Scroll.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommonViewController+Scroll.h"
#import "WGScrollAdView.h"
#import "WGCommonViewController+Contents.h"

@interface WGCommonViewController (ScrollDelegate) <UIScrollViewDelegate>

@end

@implementation WGCommonViewController (Scroll)

- (void)addContentsScrollView {
    if (_contentsScrollView) {
        [_contentsScrollView removeFromSuperview];
        _contentsScrollView = nil;
    }
    _contentsScrollView = [[JHScrollView alloc] initWithFrame:CGRectMake(0, _titleSegmentView.maxY, kDeviceWidth, kDeviceHeight - _titleSegmentView.maxY - kAppTabBarHeight - kAppNavigationVCY)];
    //_contentsScrollView.backgroundColor = kRedColor;
    _contentsScrollView.contentSize = CGSizeMake(_titleArray.count * kDeviceWidth, _contentsScrollView.height);
    _contentsScrollView.showsHorizontalScrollIndicator = NO;
    _contentsScrollView.delegate = self;
    _contentsScrollView.pagingEnabled = YES;
    _contentsScrollView.bounces = NO;
    [self.view addSubview:_contentsScrollView];
}

- (void)setContentsScrollViewContentsSizeWithItemCount:(NSInteger)itemCount {
    _contentsScrollView.contentSize = CGSizeMake(kDeviceWidth * itemCount, _contentsScrollView.height);
}

- (void)setContentsScrollViewOffsetWithIndex:(NSInteger)selectedIndex {
    [UIView animateWithDuration:0.25 animations:^(void) {
        _contentsScrollView.contentOffset = CGPointMake(selectedIndex * kDeviceWidth, 0);
    } completion:^(BOOL finished) {
        [self addContentsWithIndex:selectedIndex];
    }];
}

@end

@implementation WGCommonViewController (ScrollDelegate)

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger selectedIndex = ((int)(scrollView.contentOffset.x + 1)) / (int)kDeviceWidth;
    [_titleSegmentView setSelectedIndex:selectedIndex];
    [self addContentsWithIndex:selectedIndex];
}

@end
