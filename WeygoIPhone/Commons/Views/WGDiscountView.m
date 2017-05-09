//
//  WGDiscountView.m
//  WeygoIPhone
//
//  Created by muma on 2017/5/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGDiscountView.h"

@interface WGDiscountView ()
{
    JHImageView     *_discountImageView;
    JHLabel         *_discountLabel;
}
@end

@implementation WGDiscountView

- (void)loadSubviews {
    [super loadSubviews];
    _discountImageView = [[JHImageView alloc] initWithFrame:self.bounds];
    _discountImageView.image = [UIImage imageNamed:@"discount_bg"];
    _discountImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_discountImageView];
    
    CGFloat discountLabelHeight = _discountImageView.height * cos(M_PI_4) * 29 / 60;
    _discountLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, 0, self.width / cos(M_PI_4), discountLabelHeight)];
    _discountLabel.center = CGPointMake((_discountImageView.height - discountLabelHeight * cos(M_PI_4))/2, (_discountImageView.height - discountLabelHeight * cos(M_PI_4))/2);
    _discountLabel.font = kWGOswaldMediumAdaptFont(12);
    _discountLabel.textColor = kWhiteColor;
    _discountLabel.textAlignment = NSTextAlignmentCenter;
    _discountLabel.transform = CGAffineTransformRotate (_discountLabel.transform, -M_PI_4);
    [_discountImageView addSubview:_discountLabel];
}

- (void)setFont:(UIFont *)font {
    _discountLabel.font = font;
}

- (void)setDiscount:(NSString *)discount {
    _discountLabel.text = discount;
}

@end
