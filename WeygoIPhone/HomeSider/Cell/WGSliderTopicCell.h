//
//  WGSliderTopicCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/2/8.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"
#import "WGTopicItem.h"

@interface WGSliderTopicCell : JHTableViewCell

@property (nonatomic, copy) void (^onApply)(WGTopicItem *item);

@end
