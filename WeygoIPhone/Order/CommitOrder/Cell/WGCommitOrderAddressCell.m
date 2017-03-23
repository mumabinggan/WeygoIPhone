//
//  WGCommiteOrderAddressCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommitOrderAddressCell.h"
#import "WGAddress.h"

@interface WGCommitOrderAddressCell ()
{
    JHImageView *_bgImageView;
    JHLabel *_nameLabel;
    JHLabel *_addressLabel;
}
@end

@implementation WGCommitOrderAddressCell

- (void)loadSubviews {
    [super loadSubviews];
    
    _bgImageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, [WGCommitOrderAddressCell heightWithData:nil])];
    _bgImageView.image = [UIImage imageNamed:@"commitOrder_address_bg"];
    [self.contentView addSubview:_bgImageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(56), kAppAdaptHeight(18), kDeviceWidth - kAppAdaptWidth(56 + 40), kAppAdaptHeight(20))];
    _nameLabel.font = kAppAdaptFont(14);
    _nameLabel.textColor = WGAppNameLabelColor;
    [self.contentView addSubview:_nameLabel];
    
    _addressLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(56), kAppAdaptHeight(18 + 24), _nameLabel.width, kAppAdaptHeight(20))];
    _addressLabel.font = kAppAdaptFont(14);
    _addressLabel.textColor = WGAppTitleColor;
    [self.contentView addSubview:_addressLabel];
}

- (void)showWithData:(JHObject *)data {
    WGAddress *address = (WGAddress *)data;
    if (address) {
        _nameLabel.hidden = NO;
        _addressLabel.hidden = NO;
        _nameLabel.text = [NSString stringWithFormat:@"%@   %@", address.name, address.phone];
        _addressLabel.text = address.address;
    }
    else {
        _nameLabel.hidden = YES;
        _addressLabel.hidden = YES;
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    return kAppAdaptHeight(80);
}

@end
