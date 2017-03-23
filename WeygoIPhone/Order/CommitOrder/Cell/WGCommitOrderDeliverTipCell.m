//
//  WGCommitOrderDeliverTipCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommitOrderDeliverTipCell.h"
#import "WGSettlementResult.h"

@interface WGCommitOrderDeliverTipCell ()
{
    JHLabel *_contentLabel;
}
@end

@implementation WGCommitOrderDeliverTipCell

- (void)loadSubviews {
    [super loadSubviews];
    _contentLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), kAppAdaptHeight(16), kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(20))];
    _contentLabel.font = kAppAdaptFont(12);
    _contentLabel.numberOfLines = 0;
    _contentLabel.textColor = WGAppTitleColor;
    [self.contentView addSubview:_contentLabel];
}

- (void)showWithData:(JHObject *)data {
    WGSettlementTips *tip = (WGSettlementTips *)data;
    if (tip) {
        _contentLabel.text = tip.orderChangeTip;
        CGSize size = [tip.orderChangeTip returnSize:_contentLabel.font maxWidth:(kDeviceWidth - kAppAdaptWidth(30))];
        _contentLabel.height = size.height;
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    WGSettlementTips *tip = (WGSettlementTips *)data;
    if (tip) {
        CGSize size = [tip.orderChangeTip returnSize:kAppAdaptFont(12) maxWidth:(kDeviceWidth - kAppAdaptWidth(30))];
        return size.height + kAppAdaptHeight(32);
    }
    return 0;
}

@end
