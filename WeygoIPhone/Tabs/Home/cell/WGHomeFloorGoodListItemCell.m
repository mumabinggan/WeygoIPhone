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
    _itemView = [[WGHomeFloorGoodListItemView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(124))];
    [self.contentView addSubview:_itemView];
}

- (void)showWithData:(JHObject *)data {
    [super showWithData:data];
    WGHomeFloorContentGoodItem *item = (WGHomeFloorContentGoodItem *)data;
    [_itemView showWithData:item];
}

@end
