//
//  WGHomeFloorContentGoodListCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"
#import "WGDiscountView.h"

@class WGDiscountView;
@class WGHomeFloorContentGoodItem;

@interface WGHomeFloorGoodListItemView : JHView

@property (nonatomic, strong) WGDiscountView  *discountView;

@property (nonatomic, copy) void (^onPurchase)(WGHomeFloorContentGoodItem *object, CGPoint fromPoint);

- (void)showWithData:(WGHomeFloorContentGoodItem *)object;

@end
