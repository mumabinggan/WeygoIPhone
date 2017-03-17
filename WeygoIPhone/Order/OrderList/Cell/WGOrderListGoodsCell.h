//
//  WGOrderListGoodsCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"
#import "WGOrderGoodItem.h"

@interface WGOrderListGoodsCell : JHTableViewCell

@property (nonatomic, copy) void (^onApply)(WGOrderGoodItem *item);

@end
