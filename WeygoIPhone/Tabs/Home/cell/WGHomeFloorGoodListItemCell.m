//
//  WGHomeFloorGoodListItemCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorGoodListItemCell.h"
#import "WGHomeFloorGoodListItemView.h"
#import "WGHomeFloorContentItem.h"

@interface WGHomeFloorGoodListItemCell ()
{
    WGHomeFloorGoodListItemView *_itemView;
}
@end

@implementation WGHomeFloorGoodListItemCell

- (void)loadSubviews {
    [super loadSubviews];
    _itemView = [[WGHomeFloorGoodListItemView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    [self.contentView addSubview:_itemView];
}

- (void)showWithData:(JHObject *)data {
    [super showWithData:data];
    WGHomeFloorContentItem *item = (WGHomeFloorContentItem *)data;
    [_itemView showWithData:(WGHomeFloorContentGoodItem *)item.contentItem];
    CGRect frame = _itemView.frame;
    frame.size.height = item.contentHeight;
    _itemView.frame = frame;
}

@end
