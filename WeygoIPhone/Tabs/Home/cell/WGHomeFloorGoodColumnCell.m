//
//  WGHomeFloorGoodColumnCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorGoodColumnCell.h"
#import "WGHomeFloorGoodColumnItemView.h"
#import "WGHomeFloorContentItem.h"

@interface WGHomeFloorGoodColumnCell ()
{
    JHScrollView *_scrollView;
    NSArray *_dataArray;
    NSArray *_itemViewArray;
}
@end

@implementation WGHomeFloorGoodColumnCell

- (void)loadSubviews {
    [super loadSubviews];
    self.backgroundColor = kRGB(247, 249, 250);
}

- (JHScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[JHScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(232))];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = kRGB(247, 250, 250);
        [self.contentView addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)showWithArray:(NSArray *)array {
    [super showWithArray:array];
    if (array.count == _dataArray.count) {
        BOOL same = YES;
        for (int num = 0; num < array.count; ++num) {
            JHObject *oldItem = _dataArray[num];
            JHObject *newItem = array[num];
            if (![oldItem.toJSONString isEqualToString:newItem.toJSONString]) {
                same = NO;
                break;
            }
        }
        if (same) {
            return;
        }
    }
    _dataArray = array;
    
    for (JHView *item in _itemViewArray) {
        [item removeFromSuperview];
    }
    _itemViewArray = nil;
    
    NSMutableArray *itemViewArray = [[NSMutableArray alloc] init];
    for (int num = 0; num < _dataArray.count; ++num) {
        WGHomeFloorContentItem *item = _dataArray[num];
        WGHomeFloorGoodColumnItemView *itemView = [[WGHomeFloorGoodColumnItemView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8) + kAppAdaptWidth(128 + 8)*num, kAppAdaptHeight(8), kAppAdaptWidth(128), kAppAdaptHeight(216)) radius:kAppAdaptWidth(6)];
        itemView.tag = num;
        [itemView addSingleTapGestureRecognizerWithTarget:self action:@selector(handleClick:)];
        itemView.backgroundColor = kWhiteColor;
        [itemView showWithData:item.contentItem];
        [[self scrollView] addSubview:itemView];
        [itemViewArray addObject:itemView];
    }
    CGSize size = _scrollView.size;
    size.width = _dataArray.count * kAppAdaptWidth(128 + 8) + kAppAdaptWidth(8);
    _scrollView.contentSize = size;
    _itemViewArray = itemViewArray;
}

- (void)handleClick:(UIGestureRecognizer *)recognizer {
    if (self.onApply) {
        NSInteger index = recognizer.view.tag;
        if (_dataArray.count > index) {
            self.onApply(_dataArray[index]);
        }
    }
}

@end
