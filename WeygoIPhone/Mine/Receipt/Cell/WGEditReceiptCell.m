//
//  WGAddReceiptCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGEditReceiptCell.h"

@interface WGEditReceiptCell ()

@end

@implementation WGEditReceiptCell

- (void)loadSubviews {
    [super loadSubviews];
    _textField = [[JHTextField alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), 0, kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(48))];
    _textField.font = kAppAdaptFont(14);
    _textField.textColor = WGAppLightNameLabelColor;
    [self.contentView addSubview:_textField];
}

- (void)showWithData:(JHObject *)data {
    NSString *content = (NSString *)data;
    _textField.text = content;
}

@end
