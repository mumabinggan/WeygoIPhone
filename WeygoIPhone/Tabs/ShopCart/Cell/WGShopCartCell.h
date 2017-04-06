//
//  WGShopCartCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"
#import "WGShopCartGoodItem.h"

@interface WGShopCartCell : JHTableViewCell

@property (nonatomic, copy) void (^onApply)(WGShopCartGoodItem *item);

@property (nonatomic, copy) void (^onAdd)(WGShopCartGoodItem *item);

@property (nonatomic, copy) void (^onSub)(WGShopCartGoodItem *item);

@end
