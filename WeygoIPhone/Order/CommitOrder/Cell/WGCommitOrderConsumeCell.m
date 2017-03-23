//
//  WGCommitOrderConsumeCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommitOrderConsumeCell.h"
#import "WGCommitOrderDetail.h"

@interface WGCommitOrderConsumeCell ()
{
    JHLabel *_totalValueLabel;
    JHLabel *_deliverValueLabel;
    JHLabel *_couponValueLabel;
}
@end

@implementation WGCommitOrderConsumeCell

- (void)loadSubviews {
    JHLabel *totalLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), kAppAdaptHeight(16), kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(20))];
    totalLabel.font = kAppAdaptFont(14);
    totalLabel.textColor = WGAppTitleColor;
    totalLabel.text = kStr(@"CommitOrder Total");
    [self.contentView addSubview:totalLabel];
    
    _totalValueLabel = [[JHLabel alloc] initWithFrame:totalLabel.frame];
    _totalValueLabel.font = kAppAdaptFont(14);
    _totalValueLabel.textColor = WGAppNameLabelColor;
    _totalValueLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_totalValueLabel];
    
    JHLabel *deliverLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), totalLabel.maxY, kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(20))];
    deliverLabel.font = kAppAdaptFont(14);
    deliverLabel.textColor = WGAppTitleColor;
    deliverLabel.text = kStr(@"CommitOrder DeliverPrice");
    [self.contentView addSubview:deliverLabel];
    
    _deliverValueLabel = [[JHLabel alloc] initWithFrame:deliverLabel.frame];
    _deliverValueLabel.font = kAppAdaptFont(14);
    _deliverValueLabel.textColor = WGAppNameLabelColor;
    _deliverValueLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_deliverValueLabel];
    
    JHLabel *couponLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), deliverLabel.maxY, kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(20))];
    couponLabel.font = kAppAdaptFont(14);
    couponLabel.textColor = WGAppTitleColor;
    couponLabel.text = kStr(@"CommitOrder CouponPrice");
    [self.contentView addSubview:couponLabel];
    
    _couponValueLabel = [[JHLabel alloc] initWithFrame:couponLabel.frame];
    _couponValueLabel.font = kAppAdaptFont(14);
    _couponValueLabel.textColor = WGAppNameLabelColor;
    _couponValueLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_couponValueLabel];
}

- (void)showWithData:(JHObject *)data {
    WGSettlementConsumePrice *price = (WGSettlementConsumePrice *)data;
    if (price) {
        _totalValueLabel.text = [NSString stringWithFormat:kStr(@"Price With 2 Unit"), price.totalPrice];
        _deliverValueLabel.text = [NSString stringWithFormat:kStr(@"Price With 2 Unit"), price.deliverPrice];
        _couponValueLabel.text = [NSString stringWithFormat:@"-%@", [NSString stringWithFormat:kStr(@"Price With 2 Unit"), price.couponPrice]];
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    return kAppAdaptHeight(90);
}

@end
