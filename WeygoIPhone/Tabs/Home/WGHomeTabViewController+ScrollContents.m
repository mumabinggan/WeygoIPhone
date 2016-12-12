//
//  WGHomeTabViewController+ScrollContents.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/10.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGHomeTabViewController+ScrollContents.h"
#import "WGSegmentView.h"
#import "WGScrollImageView.h"

@interface WGHomeTabViewController (ScrollDelegate) <UIScrollViewDelegate>

@end

@implementation WGHomeTabViewController (ScrollContents)

- (void)addContentsScrollView {
    _contentsScrollView = [[JHScrollView alloc] initWithFrame:CGRectMake(0, _titleSegmentView.maxY, kDeviceWidth, kDeviceHeight - _titleSegmentView.maxY - kAppTabBarHeight)];
    _contentsScrollView.contentSize = CGSizeMake(3 * kDeviceWidth, _contentsScrollView.height);
    _contentsScrollView.showsHorizontalScrollIndicator = NO;
    _contentsScrollView.delegate = self;
    _contentsScrollView.pagingEnabled = YES;
    for (int num = 0; num < 3; ++num) {
        NSArray *imageArray = @[@"http://pic32.nipic.com/20130813/9422601_092059943000_2.jpg", @"http://pic38.nipic.com/20140306/2457331_150217053000_2.jpg", @"http://pic32.nipic.com/20130813/9422601_092617803000_2.jpg", @"http://easyread.ph.126.net/j4Ih8eDnIbipPWKBw9kmiw==/7916596969685939749.jpg"];
        WGScrollImageView *scrollImageView = [[WGScrollImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 200) imageArray:imageArray];
        //WGScrollImageView *label = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth * num, 0, 100, 100)];
        //label.backgroundColor = kRedColor;
        //label.text = [NSString stringWithFormat:@"%d", num];
        [_contentsScrollView addSubview:scrollImageView];
    }
    [self.view addSubview:_contentsScrollView];
}

- (void)setContentsScrollViewContentsSizeWithItemCount:(NSInteger)itemCount {
    _contentsScrollView.contentSize = CGSizeMake(kDeviceWidth * itemCount, _contentsScrollView.height);
}

- (void)setContentsScrollViewOffsetWithIndex:(NSInteger)selectedIndex {
    [UIView animateWithDuration:0.25 animations:^(void) {
        _contentsScrollView.contentOffset = CGPointMake(selectedIndex * kDeviceWidth, 0);
    }];
}

@end

@implementation WGHomeTabViewController (ScrollDelegate)

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_titleSegmentView setSelectedIndex:((int)(scrollView.contentOffset.x + 1)) / (int)kDeviceWidth];
}

@end
