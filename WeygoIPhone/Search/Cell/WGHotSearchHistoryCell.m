//
//  WGHotSearchHistoryCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/5/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHotSearchHistoryCell.h"
#import "WGHotSearchHistoryView.h"

@interface WGHotSearchHistoryCell ()
{
    WGHotSearchHistoryView *_hotSearchHistoryView;
    NSArray *_array;
}
@end

@implementation WGHotSearchHistoryCell

- (void)showWithArray:(NSArray *)array {
    if (array == nil || array.count == 0) {
        return;
    }
    if (array.count == _array.count) {
        return;
    }
    _array = array;
    _hotSearchHistoryView = [[WGHotSearchHistoryView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1) disArray:array];
    WeakSelf;
    _hotSearchHistoryView.onLongApply = ^(WGSearchKeywordItem *item) {
        [weakSelf handleDeleteHotSearchHistoryItem:item];
    };
    _hotSearchHistoryView.onApply = ^(WGSearchKeywordItem *item) {
        [weakSelf handleHotSearchHistoryItem:item];
    };
    [self.contentView addSubview:_hotSearchHistoryView];
}

- (void)handleHotSearchHistoryItem:(WGSearchKeywordItem *)item {
    if (self.onApply) {
        self.onApply(item);
    }
}

- (void)handleDeleteHotSearchHistoryItem:(WGSearchKeywordItem *)item {
    if (self.onDelete) {
        self.onDelete(item);
    }
}

+ (CGFloat)heightWithArray:(NSArray *)data {
    if (data == nil) {
        return 0.0f;
    }
    return [WGHotSearchHistoryView getViewHeightWithWidth:kDeviceWidth data:data];
}

@end
