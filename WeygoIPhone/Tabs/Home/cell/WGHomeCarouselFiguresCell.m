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
    WGScrollImageView *_scrollImageView;
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
        _scrollImageView = [[WGScrollImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(176)) imageArray:nil];
        __weak id weakSelf = self;
        _scrollImageView.onClick = ^(NSInteger index) {
            [weakSelf handleClick:index];
        };
        _scrollImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_scrollImageView];
    }
    [_scrollImageView setImageArray:array];
}

- (void)handleClick:(NSInteger)index {
    if (self.onApply) {
        self.onApply(index);
    }
}

@end
