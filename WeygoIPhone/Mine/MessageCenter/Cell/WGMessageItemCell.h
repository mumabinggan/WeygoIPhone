//
//  WGMessageItemCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/19.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"

@class WGMessageItem;

@interface WGMessageItemCell : JHTableViewCell

@property (nonatomic, copy) void (^onMore)(WGMessageItem *item);

@end
