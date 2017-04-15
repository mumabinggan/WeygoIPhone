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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _itemView = [[WGHomeFloorGoodListItemView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(124))];
    WeakSelf;
    _itemView.onPurchase = ^(WGHomeFloorContentGoodItem *item, CGPoint fromPoint) {
        [weakSelf handleOnPurchase:item fromPoint:fromPoint];
    };
    [self.contentView addSubview:_itemView];
}

- (void)showWithData:(JHObject *)data {
    [super showWithData:data];
    WGHomeFloorContentGoodItem *item = (WGHomeFloorContentGoodItem *)data;
    [_itemView showWithData:item];
}

- (void)handleOnPurchase:(WGHomeFloorContentGoodItem *)item fromPoint:(CGPoint)fromPoint {
    if (self.onPurchase) {
        self.onPurchase(item, fromPoint);
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    return kAppAdaptHeight(124);
}

@end
