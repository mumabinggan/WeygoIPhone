//
//  WGHotSearchCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/5/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHotSearchCell.h"
#import "WGHotSearchView.h"

@interface WGHotSearchCell ()
{
    WGHotSearchView *_hotSearchView;
}
@end

@implementation WGHotSearchCell

- (void)showWithArray:(NSArray *)array {
    [_hotSearchView removeFromSuperview];
    _hotSearchView = nil;
    _hotSearchView = [[WGHotSearchView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1) disArray:array];
    WeakSelf;
    _hotSearchView.onApply = ^(WGSearchKeywordItem *item) {
        [weakSelf handleHotSearchItem:item];
    };
    [self.contentView addSubview:_hotSearchView];
}

- (void)handleHotSearchItem:(WGSearchKeywordItem *)item {
    if (self.onApply) {
        self.onApply(item);
    }
}

+ (CGFloat)heightWithArray:(NSArray *)data {
    if (data == nil) {
        return 0.0f;
    }
    return [WGHotSearchView getViewHeightWithWidth:kDeviceWidth data:data];
}

@end
