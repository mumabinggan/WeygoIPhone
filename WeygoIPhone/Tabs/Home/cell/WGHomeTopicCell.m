//
//  WGHomeTopicCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeTopicCell.h"
#import "WGTopicItem.h"
#import "WGHomeTopicItemView.h"

@interface WGHomeTopicCell ()
{
    JHScrollView *_scrollView;
    NSArray *_dataArray;
    NSArray *_itemViewArray;
}
@end

@implementation WGHomeTopicCell

- (JHScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[JHScrollView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(116))];
        _scrollView.showsHorizontalScrollIndicator = NO;
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
        WGTopicItem *item = _dataArray[num];
        WGHomeTopicItemView *itemView = [[WGHomeTopicItemView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8) + kAppAdaptWidth(96 + 8)*num, kAppAdaptHeight(8), kAppAdaptWidth(96), kAppAdaptHeight(100)) radius:kAppAdaptWidth(6)];
        itemView.tag = num;
        [itemView addSingleTapGestureRecognizerWithTarget:self action:@selector(handleClick:)];
        [itemView showWithData:item];
        [[self scrollView] addSubview:itemView];
        [itemViewArray addObject:itemView];
    }
    CGSize size = _scrollView.size;
    size.width = _dataArray.count * kAppAdaptWidth(96 + 8) + kAppAdaptWidth(8);
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
