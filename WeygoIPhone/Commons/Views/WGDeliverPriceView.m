//
//  WGDeliverPriceView.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGDeliverPriceView.h"

@implementation WGDeliverPriceView
{
    UIView *_contentView;
    JHTextView *_textView;
}

- (void)loadSubviews {
    [super loadSubviews];
    self.maskColor = kHRGBA(0x000000, 0.4);
    
    JHButton *closeBtn = [[JHButton alloc] initWithFrame:self.bounds];
    [closeBtn addTarget:self action:@selector(touchCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    float radius = kAppAdaptWidth(24);
    _contentView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(343), kAppAdaptHeight(324)) radius:kAppAdaptWidth(24)];
    _contentView.backgroundColor = kWhiteColor;
    _contentView.center = CGPointMake(kDeviceWidth/2, kDeviceHeight/2);
    [self addSubview:_contentView];
    
    JHView *titleBgView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, _contentView.width, kAppAdaptHeight(48)) difRadius:JHRadiusMake(radius, 0, radius, 0) backgroundColor:kHRGB(0xF8FAFA)];
    [_contentView addSubview:titleBgView];
    
    JHLabel *titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(24), 0, titleBgView.width - kAppAdaptWidth(48), titleBgView.height)];
    titleLabel.font = kAppAdaptFontBold(16);
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = WGAppNameLabelColor;
    titleLabel.text = kStr(@"ShopCart_DeliverPrice_Title");
    [titleBgView addSubview:titleLabel];
    
    _textView = [[JHTextView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(24), kAppAdaptHeight(16) + titleBgView.maxY, _contentView.width - kAppAdaptWidth(48), kAppAdaptHeight(160))];
    _textView.font = kAppAdaptFont(14);
    _textView.editable = NO;
    _textView.textColor = WGAppTitleColor;
    _textView.textAlignment = NSTextAlignmentCenter;
    [_contentView addSubview:_textView];
    _textView.backgroundColor = kClearColor;
    _textView.editable = NO;
    
    JHButton *okBtn = [[JHButton alloc] initWithFrame:CGRectMake(_textView.x, _textView.maxY + kAppAdaptHeight(36), _textView.width, kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20)) backgroundColor:WGAppFooterButtonColor];
    [okBtn setTitle:kStr(@"ShopCart_DeliverPrice_Ok") forState:UIControlStateNormal];
    okBtn.titleLabel.font = kAppAdaptFont(14);
    [okBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(touchCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:okBtn];
}

- (void)setTip:(NSString *)tip {
    _textView.text = tip;
}

- (void)touchCloseBtn:(JHButton *)sender {
    if (self.onApply) {
        self.onApply(0);
    }
    [self close];
}

@end
