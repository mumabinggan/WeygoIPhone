//
//  WGHomeFloorClassifyGridCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"
#import "WGHomeFloorContentItem.h"

@interface WGHomeFloorClassifyGridItemCell : JHTableViewCell

@property (nonatomic, copy) void (^onApply)(WGHomeFloorContentItem *item);

@end
