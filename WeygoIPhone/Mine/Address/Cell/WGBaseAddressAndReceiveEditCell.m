//
//  WGBaseEditCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGBaseAddressAndReceiveEditCell.h"

@interface WGBaseAddressAndReceiveEditCell (TextFieldDelegate) <UITextFieldDelegate>

@end

@implementation WGBaseAddressAndReceiveEditCell

- (void)loadSubviews {
    [super loadSubviews];
    _textField = [[JHTextField alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), 0, kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(48))];
    _textField.font = kAppAdaptFont(14);
    _textField.textColor = WGAppNameLabelColor;
    [self.contentView addSubview:_textField];
}

- (void)showWithData:(JHObject *)data {
    NSString *content = (NSString *)data;
    _textField.text = content;
}

@end

@implementation WGBaseAddressAndReceiveEditCell (TextFieldDelegate)

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.onEndEdit) {
        self.onEndEdit(self);
    }
}

@end
