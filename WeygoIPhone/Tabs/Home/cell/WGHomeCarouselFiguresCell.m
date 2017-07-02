//
//  WGHomeCarouselFiguresCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeCarouselFiguresCell.h"
#import "WGScrollImageView.h"
#import "WGCarouselFigureItem.h"

@interface WGHomeCarouselFiguresCell ()
{
    NSArray *_array;
}
@end

@implementation WGHomeCarouselFiguresCell

- (void)showWithArray:(NSArray *)array {
    [super showWithArray:array];
    if (array.count == _array.count) {
        BOOL same = YES;
        for (int num = 0; num < array.count; ++num) {
            if (![_array[num] isEqual:array[num]]) {
                same = NO;
                break;
            }
        }
        if (same) {
            return;
        }
    }
    _array = array;
    if (!_scrollImageView) {
        _scrollImageView = [[WGScrollImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, [[self class] heightWithData:array]) imageArray:nil fromType:WGScrollImageViewFromTypeGoodDetail];
        _scrollImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        __weak id weakSelf = self;
        _scrollImageView.onClick = ^(NSInteger index) {
            [weakSelf handleClick:index];
        };
        _scrollImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_scrollImageView];
    }
    [_scrollImageView setImageArray:array];
}

- (void)setCountDownTime:(long long)time {
    if (!_countDownTimeView || time != 0) {
        _countDownTimeView = [[WGCountdownTimeView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(10), kAppAdaptHeight(20), kAppAdaptWidth(200), kAppAdaptWidth(107))];
        WeakSelf;
        _countDownTimeView.onHidden = ^() {
            [weakSelf handleRefresh];
        };
        [_scrollImageView addSubview:_countDownTimeView];
    }
    _countDownTimeView.hidden = (time == 0);
    [_countDownTimeView setTime:time];
}

- (void)handleRefresh {
    if (self.onRefresh) {
        self.onRefresh();
    }
}

- (void)handleClick:(NSInteger)index {
    if (self.onApply) {
        self.onApply(index);
    }
}

+ (CGFloat)heightWithData:(NSArray *)array {
    float height = 0.0f;
    //height = kAppAdaptHeight(176);
    if (array && array.count > 0) {
        height = kAppAdaptHeight(176);
    }
    return height;
}

@end
