//
//  WGOverHeightGoodCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/6/25.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"
#import "WGOverHeightGoodItem.h"

@interface WGOverHeightGoodCell : JHTableViewCell

@property (nonatomic, copy) void (^onAdd)(WGOverHeightGoodItem *item);

@property (nonatomic, copy) void (^onSub)(WGOverHeightGoodItem *item);

@end
