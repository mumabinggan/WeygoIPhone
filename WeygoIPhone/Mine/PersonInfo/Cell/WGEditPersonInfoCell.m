//
//  WGEditPersonInfoCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGEditPersonInfoCell.h"

@interface WGEditPersonInfoCell (TextFieldDelegate) <UITextFieldDelegate>

@end

@implementation WGEditPersonInfoCell

- (void)loadSubviews {
    [super loadSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _textField = [[JHTextField alloc] initWithFrame:CGRectMake(kAppAdaptWidth(150), 0, kDeviceWidth - kAppAdaptWidth(150 + 40), kAppAdaptHeight(48))];
    _textField.font = kAppAdaptFont(14);
    _textField.textColor = WGAppNameLabelColor;
    _textField.textAlignment = NSTextAlignmentRight;
    _textField.delegate = self;
    [self.contentView addSubview:_textField];
}

- (void)showWithData:(JHObject *)data {
    NSString *content = (NSString *)data;
    _textField.text = content;
}

@end

@implementation WGEditPersonInfoCell (TextFieldDelegate)

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.onEndEdit) {
        self.onEndEdit(self);
    }
}

@end
