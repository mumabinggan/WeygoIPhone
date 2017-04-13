//
//  WGOrderDeliverCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderDeliverCell.h"
#import "WGOrderDetail.h"

@interface WGOrderDeliverCell ()
{
    JHLabel *_nameLabel;
    JHLabel *_addressLabel;
    JHLabel *_phoneLabel;
    JHLabel *_deliverTimeLabel;
}
@end

@implementation WGOrderDeliverCell

- (void)loadSubviews {
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), kAppAdaptHeight(16), kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(20))];
    _nameLabel.font = kAppAdaptFont(14);
    _nameLabel.textColor = WGAppTitleColor;
    [self.contentView addSubview:_nameLabel];
    
    _addressLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), _nameLabel.maxY, kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(20))];
    _addressLabel.font = kAppAdaptFont(14);
    _addressLabel.textColor = WGAppTitleColor;
    [self.contentView addSubview:_addressLabel];
    
    _phoneLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), _addressLabel.maxY, kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(20))];
    _phoneLabel.font = kAppAdaptFont(14);
    _phoneLabel.textColor = WGAppTitleColor;
    [self.contentView addSubview:_phoneLabel];
    
    _deliverTimeLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), _phoneLabel.maxY, kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(20))];
    _deliverTimeLabel.font = kAppAdaptFont(14);
    _deliverTimeLabel.textColor = WGAppTitleColor;
    [self.contentView addSubview:_deliverTimeLabel];
}

- (void)showWithData:(JHObject *)data {
    WGOrderDeliver *deliver = ((WGOrderDetail *)data).deliver;
    if (deliver) {
        _nameLabel.text = [NSString stringWithFormat:kStr(@"Order Client Name"), deliver.userName];
        _addressLabel.text = [NSString stringWithFormat:kStr(@"Order Address"), deliver.userAddress];
        _phoneLabel.text = [NSString stringWithFormat:kStr(@"Order Phone"), deliver.phone];
        _deliverTimeLabel.text = [NSString stringWithFormat:kStr(@"Order Address"), deliver.deliverTime];
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    return kAppAdaptHeight(112);
}

@end
