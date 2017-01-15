//
//  WGHomeFloorNameHeadCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorNameHeadCell.h"
#import "WGHomeFloorItem.h"

@implementation WGHomeFloorNameHeadCell

- (void)loadSubviews {
    [super loadSubviews];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.textColor = kRGBA(0, 0, 0, 0.87);
    self.textLabel.font = kWGSFUIDisplayMediumAdaptFont(14);
}

- (void)showWithData:(JHObject *)data {
    WGHomeFloorItem *item = (WGHomeFloorItem *)data;
    self.textLabel.text = item.name;
}

@end
