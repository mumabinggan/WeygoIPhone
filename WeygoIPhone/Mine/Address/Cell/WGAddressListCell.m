//
//  WGAddressListCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGAddressListCell.h"
#import "WGAddress.h"

@implementation WGAddressListCell

- (void)showWithData:(JHObject *)data {
    [super showWithData:data];
    WGAddress *address = (WGAddress *)data;
    _title3ValueLabel.text = address.phone;
    _title2ValueLabel.text = address.address;
    _title1ValueLabel.text = address.name;
    [_defaultBtn setBackgroundColor:address.isDefault ? WGAppBaseColor : kRGB(247, 249, 250)];
    [_defaultBtn setTitleColor:address.isDefault ? kWhiteColor : kRGB(235, 239, 240) forState:UIControlStateNormal];
}

@end
