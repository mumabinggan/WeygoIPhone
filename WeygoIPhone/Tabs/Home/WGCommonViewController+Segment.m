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
    if (!_titleSegmentView) {
        _titleSegmentView = [[WGSegmentView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(44))];
        _titleSegmentView.backgroundColor = kWhiteColor;
        __weak id weakSelf = self;
        _titleSegmentView.onSelect = ^(NSInteger oldIndex, NSInteger newIndex) {
            [weakSelf setContentsScrollViewOffsetWithIndex:newIndex];
        };
        [self.view addSubview:_titleSegmentView];
    }
    NSMutableArray *titleMArray = [[NSMutableArray alloc] init];
    NSArray *array = _dataResponse.data;
    for (WGTitleItem *item in array) {
        [titleMArray addObject:item.name];
    }
    [_titleSegmentView setTitleArray:titleMArray];
}

- (void)setSelectedIndex:(NSInteger)index {
    _titleSegmentView.selectedIndex = index;
}

- (void)setTitleSegmentView:(NSArray *)titleArray {
    [_titleSegmentView setTitleArray:titleArray];
}

@end
