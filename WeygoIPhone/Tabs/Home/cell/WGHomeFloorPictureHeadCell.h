//
//  WGHomeFloorPictureHeadCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"

@class WGHomeFloorItem;

@interface WGHomeFloorPictureHeadCell : JHTableViewCell

@property (nonatomic, copy) void (^onApply)(WGHomeFloorItem *item);

@end
