//
//  WGIntegrationHelpView.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGIntegrationHelpView.h"

@implementation WGIntegrationHelpView
{
    UIView *_contentView;
    JHTextView *_textView;
    JHLabel *_titleLabel;
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
    
    _titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(24), 0, titleBgView.width - kAppAdaptWidth(48), titleBgView.height)];
    _titleLabel.font = kAppAdaptFontBold(16);
    _titleLabel.numberOfLines = 0;
    _titleLabel.text = kStr(@"Integration_Help_Title");
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = WGAppNameLabelColor;
    [titleBgView addSubview:_titleLabel];
    
    _textView = [[JHTextView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(24), kAppAdaptHeight(16) + titleBgView.maxY, _contentView.width - kAppAdaptWidth(48), kAppAdaptHeight(160))];
    _textView.font = kAppAdaptFont(14);
    _textView.textColor = WGAppTitleColor;
    _textView.textAlignment = NSTextAlignmentCenter;
//    _textView.text = @"积分换算规则:\n1欧元=1点积分（0.1至1欧元都视为1点积分。例如：1.2欧=2点积分）\n\n1点积分=0.01欧元，并且您可以随时使用，为提交的订单兑换（但是只有积分达到100分时，结算页面才会显示抵用信息。积分可以在个人中心中查询）\n使用积分规则:\n如果积分超出订单所需额度: \n1. €0.1至€1=100积分\n\n2. 积分使用以整百为单位\n3. 单次使用时必须使用最大整百积分\n4. 积分不能分次使用\n例如：订单额度为€45时可用积分为756分，那需使用700积分抵用，而剩下的56积分可供下次消费抵用";
    [_contentView addSubview:_textView];
    _textView.backgroundColor = kClearColor;
    _textView.editable = NO;
    
    JHButton *okBtn = [[JHButton alloc] initWithFrame:CGRectMake(_textView.x, _textView.maxY + kAppAdaptHeight(36), _textView.width, kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20)) backgroundColor:WGAppFooterButtonColor];
    [okBtn setTitle:kStr(@"Integration_Help_Button") forState:UIControlStateNormal];
    okBtn.titleLabel.font = kAppAdaptFont(14);
    [okBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(touchCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:okBtn];
}

- (void)setTip:(NSString *)tip {
    _tip = tip;
    _textView.text = tip;
}

- (void)setType:(int)type {
    if (0 == type) {
        _titleLabel.text = kStr(@"Integration_Help_Title");
    }
    else {
        _titleLabel.text = kStr(@"CommitOrder_OrderPrice_Tip_Title");
    }
}

- (void)touchCloseBtn:(JHButton *)sender {
    if (self.onApply) {
        self.onApply(0);
    }
    [self close];
}

@end
