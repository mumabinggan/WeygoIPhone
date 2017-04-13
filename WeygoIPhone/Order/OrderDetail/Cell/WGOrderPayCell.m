//
//  WGOrderPayCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderPayCell.h"
#import "WGOrderDetail.h"

@interface WGOrderPayCell ()
{
    JHLabel *_totalLabel;
    JHLabel *_benefitLabel;
    JHLabel *_currentTotalLabel;
}
@end

@implementation WGOrderPayCell

- (void)loadSubviews {
    _totalLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), kAppAdaptHeight(16), kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(20))];
    _totalLabel.font = kAppAdaptFont(14);
    _totalLabel.textColor = WGAppTitleColor;
    [self.contentView addSubview:_totalLabel];
    
    _benefitLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), _totalLabel.maxY, kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(20))];
    _benefitLabel.font = kAppAdaptFont(14);
    _benefitLabel.textColor = WGAppTitleColor;
    [self.contentView addSubview:_benefitLabel];
    
    _currentTotalLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), _benefitLabel.maxY, kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(20))];
    _currentTotalLabel.font = kAppAdaptFont(14);
    _currentTotalLabel.textColor = WGAppTitleColor;
    [self.contentView addSubview:_currentTotalLabel];
}

- (void)showWithData:(JHObject *)data {
    WGOrderPay *pay = ((WGOrderDetail *)data).pay;
    if (pay) {
        _totalLabel.text = [NSString stringWithFormat:kStr(@"Order Pay Total"), pay.totalPrice];
        _benefitLabel.text = [NSString stringWithFormat:kStr(@"Order Pay Benefit Detail"), pay.reducePrice];
        _currentTotalLabel.text = [NSString stringWithFormat:kStr(@"Order Pay Totale"), pay.currentPrice];
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    return kAppAdaptHeight(92);
}

@end
