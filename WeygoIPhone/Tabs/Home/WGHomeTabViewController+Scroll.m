//
//  WGHomeTabViewController+ScrollContents.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/10.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGHomeTabViewController+Scroll.h"
#import "WGSegmentView.h"
#import "WGScrollImageView.h"
#import "WGScrollAdView.h"
#import "WGHomeTabViewController+Contents.h"

@interface WGHomeTabViewController (ScrollDelegate) <UIScrollViewDelegate>

@end

@implementation WGHomeTabViewController (Scroll)

- (void)addContentsScrollView {
    _contentsScrollView = [[JHScrollView alloc] initWithFrame:CGRectMake(0, _titleSegmentView.maxY, kDeviceWidth, kDeviceHeight - _titleSegmentView.maxY - kAppTabBarHeight)];
    //_contentsScrollView.contentSize = CGSizeMake(3 * kDeviceWidth, _contentsScrollView.height);
    _contentsScrollView.showsHorizontalScrollIndicator = NO;
    _contentsScrollView.delegate = self;
    _contentsScrollView.pagingEnabled = YES;
    _contentsScrollView.bounces = NO;
//    for (int num = 0; num < 3; ++num) {
//        NSArray *imageArray = @[@"http://pic32.nipic.com/20130813/9422601_092059943000_2.jpg", @"http://pic38.nipic.com/20140306/2457331_150217053000_2.jpg", @"http://pic32.nipic.com/20130813/9422601_092617803000_2.jpg", @"http://easyread.ph.126.net/j4Ih8eDnIbipPWKBw9kmiw==/7916596969685939749.jpg"];
//        WGScrollImageView *scrollImageView = [[WGScrollImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 200) imageArray:imageArray];
//        scrollImageView.onClick = ^(NSInteger index) {
//            DLog(@"--index = %ld", index);
//        };
//        [_contentsScrollView addSubview:scrollImageView];
//    }
    [self.view addSubview:_contentsScrollView];
    
    WGScrollAdView *adView = [[WGScrollAdView alloc] initWithFrame:CGRectMake(80, 500, kDeviceWidth - 100, 50) titleArray:@[@"asdfasdfasdfasdfsadf", @"hgfhgfdhdfghdfghdfg", @"popikokkkokjkli"]];
    //WGScrollAdView *adView = [[WGScrollAdView alloc] initWithFrame:CGRectMake(80, 500, kDeviceWidth - 100, 50) titleArray:@[@"网易是中国领先的互联网技术公司。", @"为用户提供免费邮箱、游戏、搜索引擎服务,开设新闻、娱乐、体育等30多个内容频道。", @"及博客、视频、论坛等互动交流,网聚人的力量。"]];
    adView.onTouch = ^(NSInteger index) {
        DLog(@"---index = %ld", index);
    };
    //[self.view addSubview:adView];
}

- (void)setContentsScrollViewContentsSizeWithItemCount:(NSInteger)itemCount {
    _contentsScrollView.contentSize = CGSizeMake(kDeviceWidth * itemCount, _contentsScrollView.height);
}

- (void)setContentsScrollViewOffsetWithIndex:(NSInteger)selectedIndex {
    [UIView animateWithDuration:0.20 animations:^(void) {
        _contentsScrollView.contentOffset = CGPointMake(selectedIndex * kDeviceWidth, 0);
    } completion:^(BOOL finished) {
        [self addContentsWithIndex:selectedIndex];
    }];
}

@end

@implementation WGHomeTabViewController (ScrollDelegate)

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger selectedIndex = ((int)(scrollView.contentOffset.x + 1)) / (int)kDeviceWidth;
    [_titleSegmentView setSelectedIndex:selectedIndex];
    [self addContentsWithIndex:selectedIndex];
}

@end
