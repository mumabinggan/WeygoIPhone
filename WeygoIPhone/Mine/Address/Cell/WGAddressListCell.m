//
//  WGAddressListCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGAddressListCell.h"
#import "WGAddress.h"

@interface WGAddressListCell ()
{
    WGObject *_data;
}
@end

@implementation WGAddressListCell

- (void)loadSubviews {
    [super loadSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _title1NameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(14), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(20))];
    _title1NameLabel.font = kAppAdaptFont(14);
    _title1NameLabel.textColor = WGAppTitleColor;
    _title1NameLabel.text = kStr(@"Full Name");
    [self.contentView addSubview:_title1NameLabel];
    
    CGRect rect = _title1NameLabel.frame;
    rect.origin.x = kDeviceWidth/3;
    rect.size.width = kDeviceWidth * 2 / 3 - kAppAdaptWidth(16);
    _title1ValueLabel = [[JHLabel alloc] initWithFrame:rect];
    _title1ValueLabel.font = kAppAdaptFont(14);
    _title1ValueLabel.textAlignment = NSTextAlignmentRight;
    _title1ValueLabel.textColor = WGAppNameLabelColor;
    [self.contentView addSubview:_title1ValueLabel];
    
    _title2NameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_title1NameLabel.x, _title1NameLabel.maxY + kAppAdaptHeight(4), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(20))];
    _title2NameLabel.font = kAppAdaptFont(14);
    _title2NameLabel.textColor = WGAppTitleColor;
    _title2NameLabel.text = kStr(@"Indirizzo");
    [self.contentView addSubview:_title2NameLabel];
    
    rect = _title2NameLabel.frame;
    rect.origin.x = kDeviceWidth/3;
    rect.size.width = kDeviceWidth * 2 / 3 - kAppAdaptWidth(16);
    _title2ValueLabel = [[JHLabel alloc] initWithFrame:rect];
    _title2ValueLabel.font = kAppAdaptFont(14);
    _title2ValueLabel.textAlignment = NSTextAlignmentRight;
    _title2ValueLabel.textColor = WGAppNameLabelColor;
    _title2ValueLabel.numberOfLines = 2;
    [self.contentView addSubview:_title2ValueLabel];
    
    _title3NameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_title1NameLabel.x, _title2NameLabel.maxY + kAppAdaptHeight(4), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(20))];
    _title3NameLabel.font = kAppAdaptFont(14);
    _title3NameLabel.textColor = WGAppTitleColor;
    _title3NameLabel.text = kStr(@"Telefono/Cellulare");
    [self.contentView addSubview:_title3NameLabel];
    
    rect = _title3NameLabel.frame;
    rect.origin.x = kDeviceWidth/3;
    rect.size.width = kDeviceWidth * 2 / 3 - kAppAdaptWidth(16);
    _title3ValueLabel = [[JHLabel alloc] initWithFrame:rect];
    _title3ValueLabel.font = kAppAdaptFont(14);
    _title3ValueLabel.textAlignment = NSTextAlignmentRight;
    _title3ValueLabel.textColor = WGAppNameLabelColor;
    [self.contentView addSubview:_title3ValueLabel];
    
    _lineView = [[JHView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), _title3NameLabel.maxY + kAppAdaptHeight(14), kDeviceWidth - kAppAdaptWidth(32), kAppSepratorLineHeight)];
    _lineView.backgroundColor = WGAppSeparateLineColor;
    [self.contentView addSubview:_lineView];
    
    NSString *defaultTitle = kStr(@"Address_Default");
    CGFloat width = [defaultTitle returnSize:kAppAdaptFont(12) maxWidth:kDeviceWidth].width;
    _defaultBtn = [[JHButton alloc] initWithFrame:CGRectMake(_title1NameLabel.x, _lineView.maxY + kAppAdaptHeight(8), width + kAppAdaptWidth(15), kAppAdaptHeight(24)) difRadius:JHRadiusMake(kAppAdaptHeight(12), kAppAdaptHeight(12), kAppAdaptHeight(12), kAppAdaptHeight(12)) backgroundColor:WGAppBaseColor];
    [_defaultBtn setTitle:defaultTitle forState:UIControlStateNormal];
    _defaultBtn.titleLabel.font = kAppAdaptFont(12);
    [_defaultBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_defaultBtn addTarget:self action:@selector(touchDefaultBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_defaultBtn];
    _defaultBtn.hidden = YES;

    NSString *unDefaultTitle = kStr(@"Address_unDefault");
    width = [unDefaultTitle returnSize:kAppAdaptFont(12) maxWidth:kDeviceWidth].width;
    _unDefaultBtn = [[JHButton alloc] initWithFrame:CGRectMake(_title1NameLabel.x, _lineView.maxY + kAppAdaptHeight(8), width + kAppAdaptWidth(15), kAppAdaptHeight(24)) difRadius:JHRadiusMake(kAppAdaptHeight(12), kAppAdaptHeight(12), kAppAdaptHeight(12), kAppAdaptHeight(12)) backgroundColor:kRGB(247, 249, 250)];
    [_unDefaultBtn setTitle:unDefaultTitle forState:UIControlStateNormal];
    _unDefaultBtn.titleLabel.font = kAppAdaptFont(12);
    [_unDefaultBtn setTitleColor:WGAppNameLabelColor forState:UIControlStateNormal];
    [_unDefaultBtn addTarget:self action:@selector(touchDefaultBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_unDefaultBtn];
    _unDefaultBtn.hidden = YES;
    
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
        if (address) {
            _title1ValueLabel.text = address.fullName;
            NSString *addressString = address.address;
            CGFloat height = 0.0f;
            CGFloat width = [addressString returnSize:_title2ValueLabel.font maxWidth:kDeviceWidth].width;
            if (width > _title2ValueLabel.width) {
                height = kAppAdaptHeight(36);
            }
            else {
                height = kAppAdaptHeight(20);
            }
            _title2ValueLabel.height = height;
            _title2ValueLabel.text = addressString;
            _title3NameLabel.y = _title2ValueLabel.maxY;
            _title3ValueLabel.y = _title2ValueLabel.maxY;
            _title3ValueLabel.text = address.phone;
            _lineView.y = _title3ValueLabel.maxY + kAppAdaptHeight(14);
            _defaultBtn.y = _lineView.maxY + kAppAdaptHeight(8);
            _defaultBtn.hidden = !address.isDefault;
            _unDefaultBtn.y = _defaultBtn.y;
            _unDefaultBtn.hidden = address.isDefault;
            _useBtn.y = _defaultBtn.y;
            _modifyBtn.y = _defaultBtn.y;
        }
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    WGAddress *address = (WGAddress *)data;
    if (address){
        NSString *addressString = address.address;
        CGFloat height = kAppAdaptHeight(116);
        CGFloat addHeight = 0.0f;
        CGFloat width = [addressString returnSize:kAppAdaptFont(14) maxWidth:kDeviceWidth].width;
        if (width > kDeviceWidth/3 * 2 - kAppAdaptWidth(16)) {
            addHeight = kAppAdaptHeight(32);
        }
        else {
            addHeight = kAppAdaptHeight(20);
        }
        return height + addHeight;
    }
    return 0.0f;
}

@end
