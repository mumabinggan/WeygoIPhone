//
//  WGHomeTabViewController+Segment.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/10.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGHomeTabViewController+Segment.h"
#import "WGSegmentView.h"
#import "WGHomeTabViewController+Scroll.h"

@implementation WGHomeTabViewController (Segment)

- (void)addTitleSegmentView {
    _titleSegmentView = [[WGSegmentView alloc] initWithFrame:CGRectMake(0, kAppNavigationVCY, kDeviceWidth, kAppAdaptHeight(44))];
    [_titleSegmentView setTitleArray:@[@"每日尝鲜", @"精选寿司", @"绿色食品"]];
    _titleSegmentView.backgroundColor = kWhiteColor;
    __weak WGHomeTabViewController *weakSelf = self;
    _titleSegmentView.onSelect = ^(NSInteger oldIndex, NSInteger newIndex) {
        [weakSelf setContentsScrollViewOffsetWithIndex:newIndex];
    };
    [self.view addSubview:_titleSegmentView];
}

- (void)setTitleSegmentView:(NSArray *)titleArray {
    [_titleSegmentView setTitleArray:titleArray];
}

@end
