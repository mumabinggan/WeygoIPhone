//
//  WGCouponCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/18.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCouponCell.h"
#import "WGCoupon.h"

@interface WGCouponCell ()
{
    JHImageView *_imageView;
    JHLabel *_nameLabel;
    JHLabel *_countLabel;
    JHLabel *_breifDestrictionLabel;
    JHLabel *_codeAndTimeLabel;
    
    WGCoupon *_data;
}
@end

@implementation WGCouponCell

- (void)loadSubviews {
    [super loadSubviews];
    self.backgroundColor = kRGB(234, 238, 240);
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8), kAppAdaptWidth(8), kAppAdaptWidth(359), kAppAdaptHeight(118))];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    _imageView.image = [UIImage imageNamed:@"coupon_bg"];
    [self addSubview:_imageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(88), kAppAdaptHeight(16), kAppAdaptWidth(56 + 170), kAppAdaptHeight(24))];
    _nameLabel.font = kAppAdaptFont(15);
    _nameLabel.textColor = kRGBA(0, 0, 0, 0.87);
    [_imageView addSubview:_nameLabel];
    
    _countLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(250), kAppAdaptHeight(17), kAppAdaptWidth(93), kAppAdaptHeight(20))];
    _countLabel.font = kAppAdaptFont(14);
    _countLabel.textColor = WGAppBaseColor;
    _countLabel.textAlignment = NSTextAlignmentRight;
    [_imageView addSubview:_countLabel];
    
    _breifDestrictionLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, kAppAdaptHeight(48), kAppAdaptWidth(255), kAppAdaptHeight(32))];
    _breifDestrictionLabel.font = kAppAdaptFont(12);
    _breifDestrictionLabel.textColor = WGAppLightNameLabelColor;
    [_imageView addSubview:_breifDestrictionLabel];
    
    _codeAndTimeLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(86), kAppAdaptWidth(_imageView.width - kAppAdaptWidth(16)), kAppAdaptHeight(16))];
    _codeAndTimeLabel.font = kAppAdaptFont(12);
    _codeAndTimeLabel.textAlignment = NSTextAlignmentRight;
    _codeAndTimeLabel.textColor = WGAppLightNameLabelColor;
    [_imageView addSubview:_codeAndTimeLabel];
}

- (void)showWithData:(JHObject *)data {
    [super showWithData:data];
    _data = (WGCoupon *)data;
    _imageView.image = _data.isSelected ? [UIImage imageNamed:@"coupon_selected_bg"] : [UIImage imageNamed:@"coupon_bg"];
    _nameLabel.text = [NSString stringWithFormat:@"%@  %@", _data.price, _data.name];
    [_nameLabel setPartString:_data.price attributes:@{NSForegroundColorAttributeName : WGAppBaseColor, NSFontAttributeName : kAppAdaptFont(16)}];
    _breifDestrictionLabel.text = _data.briefDescription;
    _countLabel.text = [NSString stringWithFormat:@"%ld/%ld", _data.residueCount, _data.totalCount];
    _codeAndTimeLabel.text = [NSString stringWithFormat:@"%@ %@", _data.couponCode, _data.time];
}

@end
