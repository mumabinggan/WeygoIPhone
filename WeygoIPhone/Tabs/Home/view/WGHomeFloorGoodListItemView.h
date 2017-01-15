//
//  WGHomeFloorContentGoodListCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"

@class WGHomeFloorContentGoodItem;

@interface WGHomeFloorGoodListItemView : JHView

@property (nonatomic, copy) void (^onPurchase)(WGHomeFloorContentGoodItem *object);

- (void)showWithData:(WGHomeFloorContentGoodItem *)object;

@end
