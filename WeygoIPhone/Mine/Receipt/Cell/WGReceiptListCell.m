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
{
    JHLabel *_taxNameLabel;
    JHLabel *_taxValueLabel;
    
    JHLabel *_companyNameLabel;
    JHLabel *_companyValueLabel;
    
    JHLabel *_capNameLabel;
    JHLabel *_capValueLabel;
    
    JHButton *_defaultBtn;
    JHButton *_useBtn;
    JHButton *_modifyBtn;
    
    WGReceipt *_data;
}
@end

@implementation WGReceiptListCell

- (void)loadSubviews {
    [super loadSubviews];
    
    _taxNameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(14), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(20))];
    _taxNameLabel.font = kAppAdaptFont(14);
    _taxNameLabel.textColor = WGAppTitleColor;
    _taxNameLabel.text = kStr(@"Codice fiscale");
    [self.contentView addSubview:_taxNameLabel];
    
    _taxValueLabel = [[JHLabel alloc] initWithFrame:_taxNameLabel.frame];
    _taxValueLabel.font = kAppAdaptFont(14);
    _taxValueLabel.textAlignment = NSTextAlignmentRight;
    _taxValueLabel.textColor = WGAppNameLabelColor;
    [self.contentView addSubview:_taxValueLabel];
    
    _companyNameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_taxNameLabel.x, _taxNameLabel.maxY + kAppAdaptHeight(4), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(20))];
    _companyNameLabel.font = kAppAdaptFont(14);
    _companyNameLabel.textColor = WGAppTitleColor;
    _companyNameLabel.text = kStr(@"Raginone sociale");
    [self.contentView addSubview:_companyNameLabel];
    
    _companyValueLabel = [[JHLabel alloc] initWithFrame:_companyNameLabel.frame];
    _companyValueLabel.font = kAppAdaptFont(14);
    _companyValueLabel.textAlignment = NSTextAlignmentRight;
    _companyValueLabel.textColor = WGAppNameLabelColor;
    [self.contentView addSubview:_companyValueLabel];
    
    _capNameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_taxNameLabel.x, _companyNameLabel.maxY + kAppAdaptHeight(4), kDeviceWidth - kAppAdaptWidth(32), kAppAdaptHeight(20))];
    _capNameLabel.font = kAppAdaptFont(14);
    _capNameLabel.textColor = WGAppTitleColor;
    _capNameLabel.text = kStr(@"CAP");
    [self.contentView addSubview:_capNameLabel];
    
    _capValueLabel = [[JHLabel alloc] initWithFrame:_capNameLabel.frame];
    _capValueLabel.font = kAppAdaptFont(14);
    _capValueLabel.textAlignment = NSTextAlignmentRight;
    _capValueLabel.textColor = WGAppNameLabelColor;
    [self.contentView addSubview:_capValueLabel];
    
    JHView *line = [[JHView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), _capNameLabel.maxY + kAppAdaptHeight(14), kDeviceWidth - kAppAdaptWidth(32), kAppSepratorLineHeight)];
    line.backgroundColor = WGAppSeparateLineColor;
    [self.contentView addSubview:line];
    
    _defaultBtn = [[JHButton alloc] initWithFrame:CGRectMake(_taxNameLabel.x, line.maxY + kAppAdaptHeight(8), kAppAdaptWidth(80), kAppAdaptHeight(24))];
    [_defaultBtn setTitle:kStr(@"Default") forState:UIControlStateNormal];
    _defaultBtn.titleLabel.font = kAppAdaptFont(12);
    _defaultBtn.layer.masksToBounds = YES;
    _defaultBtn.layer.cornerRadius = kAppAdaptHeight(12);
    [_defaultBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_defaultBtn addTarget:self action:@selector(touchDefaultBtn:) forControlEvents:UIControlEventTouchUpInside];
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
    _data = (WGReceipt *)data;
    _taxValueLabel.text = _data.taxCode;
    _companyValueLabel.text = _data.companyName;
    _capValueLabel.text = _data.cap;
    [_defaultBtn setBackgroundColor:_data.isDefault ? WGAppBaseColor : kRGB(248, 250, 250)];
    [_defaultBtn setTitleColor:_data.isDefault ? kWhiteColor : WGAppTitleColor forState:UIControlStateNormal];
}

@end
