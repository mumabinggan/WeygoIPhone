//
//  WGCommitOrderCouponCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommitOrderCouponCell.h"
#import "WGCoupon.h"

@interface WGCommitOrderCouponCell ()
{
    JHImageView *_bgImageView;
    JHLabel *_nameLabel;
    JHLabel *_titleLabel;
    JHLabel *_detailLabel;
}
@end

@implementation WGCommitOrderCouponCell

- (void)loadSubviews {
    self.backgroundColor = kRGB(233, 236, 238);
    _bgImageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptHeight(8), kAppAdaptHeight(5), kDeviceWidth - kAppAdaptWidth(16), [WGCommitOrderCouponCell heightWithData:nil] - kAppAdaptHeight(10))];
    _bgImageView.image = [UIImage imageNamed:@"commitOrder_coupon_bg"];
    [self.contentView addSubview:_bgImageView];
    
    _titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(77), kAppAdaptHeight(9), kDeviceWidth - kAppAdaptWidth(77 + 16), kAppAdaptHeight(20))];
    _titleLabel.font = kAppAdaptFont(14);
    _titleLabel.textColor = WGAppNameLabelColor;
    [_bgImageView addSubview:_titleLabel];
    _titleLabel.text = kStr(@"CommitOrder No Coupon Title");
    
    _detailLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_titleLabel.x, kAppAdaptHeight(33), _titleLabel.width, kAppAdaptHeight(20))];
    _detailLabel.font = kAppAdaptFont(14);
    _detailLabel.textColor = WGAppTitleColor;
    [_bgImageView addSubview:_detailLabel];
    _detailLabel.text = kStr(@"CommitOrder No Coupon SubTitle");
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, 0, _titleLabel.width, _bgImageView.height)];
    _nameLabel.font = kAppAdaptFont(14);
    _nameLabel.textColor = WGAppNameLabelColor;
    [_bgImageView addSubview:_nameLabel];
}

- (void)showWithData:(JHObject *)data {
    WGCoupon *coupon = (WGCoupon *)data;
    if (coupon) {
        _titleLabel.hidden = YES;
        _detailLabel.hidden = YES;
        _nameLabel.hidden = NO;
        _nameLabel.text = coupon.name;
    }
    else {
        _titleLabel.hidden = NO;
        _detailLabel.hidden = NO;
        _nameLabel.hidden = YES;
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    return kAppAdaptHeight(70);
}

@end
