//
//  WGTabBenefitViewController+Scroll.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGTabBenefitViewController+Scroll.h"
#import "WGTabBenefitViewController+Contents.h"

@interface WGTabBenefitViewController (ScrollDelegate) <UIScrollViewDelegate>

@end

@implementation WGTabBenefitViewController (Scroll)

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

@implementation WGTabBenefitViewController (ScrollDelegate)

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger selectedIndex = ((int)(scrollView.contentOffset.x + 1)) / (int)kDeviceWidth;
    [_titleSegmentView setSelectedIndex:selectedIndex];
    [self addContentsWithIndex:selectedIndex];
}

@end
