//
//  WGTextClassifyCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGTextClassifyCell.h"
#import "WGClassifyItem.h"

@interface WGTextClassifyCell ()

@end

@implementation WGTextClassifyCell

- (void)loadSubviews {
    [super loadSubviews];
    self.textLabel.textColor = WGAppTitleColor;
    self.textLabel.font = kAppAdaptFont(14);
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)showWithData:(WGClassifyItem *)data {
    [super showWithData:data];
    self.textLabel.text = data.name;
}

@end
