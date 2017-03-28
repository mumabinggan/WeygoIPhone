//
//  WGCommonViewController+Segment.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommonViewController+Segment.h"
#import "WGCommonViewController+Scroll.h"
#import "WGTitleItem.h"

@implementation WGCommonViewController (Segment)

- (void)addTitleSegmentView {
    if (_titleSegmentView) {
        [_titleSegmentView removeFromSuperview];
        _titleSegmentView = nil;
    }
    if (!_titleSegmentView) {
        _titleSegmentView = [[WGSegmentView alloc] initWithFrame:CGRectMake(0, kAppNavigationVCY, kDeviceWidth, kAppAdaptHeight(44))];
        NSMutableArray *titleMArray = [[NSMutableArray alloc] init];
        for (WGTitleItem *item in _titleArray) {
            [titleMArray addObject:item.name];
        }
        [_titleSegmentView setTitleArray:titleMArray];
        _titleSegmentView.backgroundColor = kWhiteColor;
        __weak id weakSelf = self;
        _titleSegmentView.onSelect = ^(NSInteger oldIndex, NSInteger newIndex) {
            [weakSelf setContentsScrollViewOffsetWithIndex:newIndex];
        };
        [self.view addSubview:_titleSegmentView];
    }
}

- (void)setTitleSegmentView:(NSArray *)titleArray {
    [_titleSegmentView setTitleArray:titleArray];
}

@end
