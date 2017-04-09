//
//  WGBaseListCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGBaseAddressAndReceiptListCell.h"
#import "WGAddress.h"

@interface WGBaseAddressAndReceiptListCell ()
{
    JHLabel *_title1NameLabel;
    JHLabel *_title2NameLabel;
    JHLabel *_title3NameLabel;
    
    JHButton *_useBtn;
    JHButton *_modifyBtn;
    
    WGObject *_data;
}
@end

@implementation WGBaseAddressAndReceiptListCell

- (void)loadSubviews {
    [super loadSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _title1NameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(14), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(20))];
    _title1NameLabel.font = kAppAdaptFont(14);
    _title1NameLabel.textColor = WGAppTitleColor;
    _title1NameLabel.text = kStr(@"Codice fiscale");
    [self.contentView addSubview:_title1NameLabel];
    
    _title1ValueLabel = [[JHLabel alloc] initWithFrame:_title1NameLabel.frame];
    _title1ValueLabel.font = kAppAdaptFont(14);
    _title1ValueLabel.textAlignment = NSTextAlignmentRight;
    _title1ValueLabel.textColor = WGAppNameLabelColor;
    [self.contentView addSubview:_title1ValueLabel];
    
    _title2NameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_title1NameLabel.x, _title1NameLabel.maxY + kAppAdaptHeight(4), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(20))];
    _title2NameLabel.font = kAppAdaptFont(14);
    _title2NameLabel.textColor = WGAppTitleColor;
    _title2NameLabel.text = kStr(@"Raginone sociale");
    [self.contentView addSubview:_title2NameLabel];
    
    _title2ValueLabel = [[JHLabel alloc] initWithFrame:_title2NameLabel.frame];
    _title2ValueLabel.font = kAppAdaptFont(14);
    _title2ValueLabel.textAlignment = NSTextAlignmentRight;
    _title2ValueLabel.textColor = WGAppNameLabelColor;
    [self.contentView addSubview:_title2ValueLabel];
    
    _title3NameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_title1NameLabel.x, _title2NameLabel.maxY + kAppAdaptHeight(4), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(20))];
    _title3NameLabel.font = kAppAdaptFont(14);
    _title3NameLabel.textColor = WGAppTitleColor;
    _title3NameLabel.text = kStr(@"CAP");
    [self.contentView addSubview:_title3NameLabel];
    
    _title3ValueLabel = [[JHLabel alloc] initWithFrame:_title3NameLabel.frame];
    _title3ValueLabel.font = kAppAdaptFont(14);
    _title3ValueLabel.textAlignment = NSTextAlignmentRight;
    _title3ValueLabel.textColor = WGAppNameLabelColor;
    [self.contentView addSubview:_title3ValueLabel];
    
    JHView *line = [[JHView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), _title3NameLabel.maxY + kAppAdaptHeight(14), kDeviceWidth - kAppAdaptWidth(32), kAppSepratorLineHeight)];
    line.backgroundColor = WGAppSeparateLineColor;
    [self.contentView addSubview:line];
    
    _defaultBtn = [[JHButton alloc] initWithFrame:CGRectMake(_title1NameLabel.x, line.maxY + kAppAdaptHeight(8), kAppAdaptWidth(80), kAppAdaptHeight(24))];
    [_defaultBtn setTitle:kStr(@"Default") forState:UIControlStateNormal];
    _defaultBtn.titleLabel.font = kAppAdaptFont(12);
    _defaultBtn.layer.masksToBounds = YES;
    _defaultBtn.layer.cornerRadius = kAppAdaptHeight(12);
    //[_defaultBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_defaultBtn addTarget:self action:@selector(touchDefaultBtn:) forControlEvents:UIControlEventTouchUpInside];
    //[_defaultBtn setBackgroundColor:kHRGB(0xF8FAFA)];
    [self.contentView addSubview:_defaultBtn];
    
    _useBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(223), _defaultBtn.y, kAppAdaptWidth(64), kAppAdaptHeight(24)) difRadius:JHRadiusMake(kAppAdaptHeight(12), kAppAdaptHeight(12), kAppAdaptHeight(12), kAppAdaptHeight(12)) borderWidth:kAppAdaptWidth(1) borderColor:WGAppFooterButtonColor];
    [_useBtn setTitle:kStr(@"Use") forState:UIControlStateNormal];
    _useBtn.titleLabel.font = kAppAdaptFont(12);
    [_useBtn setTitleColor:WGAppFooterButtonColor forState:UIControlStateNormal];
    [_useBtn addTarget:self action:@selector(touchUseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_useBtn];
    
    _modifyBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(295), _defaultBtn.y, kAppAdaptWidth(64), kAppAdaptHeight(24)) difRadius:JHRadiusMake(kAppAdaptHeight(12), kAppAdaptHeight(12), kAppAdaptHeight(12), kAppAdaptHeight(12)) borderWidth:kAppAdaptWidth(1) borderColor:WGAppFooterButtonColor];
    [_modifyBtn setTitle:kStr(@"Modify") forState:UIControlStateNormal];
    _modifyBtn.titleLabel.font = kAppAdaptFont(12);
    [_modifyBtn setTitleColor:WGAppFooterButtonColor forState:UIControlStateNormal];
    [_modifyBtn addTarget:self action:@selector(touchMotifyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_modifyBtn];
}

- (void)setHasUse:(BOOL)hasUse {
    _useBtn.hidden = !hasUse;
}

- (void)touchDefaultBtn:(UIButton *)sender {
    if (self.onDefault) {
        self.onDefault(_data);
    }
}

- (void)touchUseBtn:(UIButton *)sender {
    if (self.onUse) {
        self.onUse(_data);
    }
}

- (void)touchMotifyBtn:(UIButton *)sender {
    if (self.onModify) {
        self.onModify(_data);
    }
}

- (void)showWithData:(JHObject *)data {
    [super showWithData:data];
    _data = (WGObject *)data;
    if ([_data isKindOfClass:[WGAddress class]]) {
        WGAddress *address = (WGAddress *)_data;
        if (address.isDefault) {
            [_defaultBtn setBackgroundColor:WGAppBaseColor];
            [_defaultBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        }
        else {
            [_defaultBtn setBackgroundColor:kHRGB(0xF8FAFA)];
            [_defaultBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        }
    }
}

@end
