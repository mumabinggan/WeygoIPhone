//
//  WGReceiptListCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGReceiptListCell.h"
#import "WGReceipt.h"

@interface WGReceiptListCell ()

@end

@implementation WGReceiptListCell

- (void)showWithData:(JHObject *)data {
    [super showWithData:data];
    WGReceipt *receipt = (WGReceipt *)data;
    _title3ValueLabel.text = receipt.taxCode;
    _title2ValueLabel.text = receipt.address;
    _title1ValueLabel.text = receipt.companyName;
    [_defaultBtn setBackgroundColor:receipt.isDefault ? WGAppBaseColor : kRGB(247, 249, 250)];
    [_defaultBtn setTitleColor:receipt.isDefault ? kWhiteColor : kRGB(235, 239, 240) forState:UIControlStateNormal];
}

@end
