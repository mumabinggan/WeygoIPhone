//
//  WGHotSearchCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/5/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"
#import "WGSearchKeywordItem.h"

@interface WGHotSearchCell : JHTableViewCell

@property (nonatomic, copy) void (^onApply)(WGSearchKeywordItem *item);

@end
