//
//  WGHomeFloorGoodListItemCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"
#import "WGHomeFloorContentGoodItem.h"

@interface WGHomeFloorGoodListItemCell : JHTableViewCell

@property (nonatomic, copy) void (^onPurchase)(WGHomeFloorContentGoodItem *object, CGPoint fromPoint);

@end
