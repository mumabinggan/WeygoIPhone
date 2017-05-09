//
//  WGHomeFloorGoodColumnItemView.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorGoodColumnItemView.h"
#import "WGDiscountView.h"

@implementation WGHomeFloorGoodColumnItemView

- (void)loadSubviews {
    [super loadSubviews];
    self.backgroundColor = kWhiteColor;
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self addSubview:_imageView];
    
    CGFloat width = _imageView.width * 3 / 7;
    _discountView = [[WGDiscountView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    _discountView.font = kWGOswaldMediumAdaptFont(12);
    [_imageView addSubview:_discountView];
    _discountView.hidden = YES;
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8), _imageView.maxY + kAppAdaptHeight(12), self.width - kAppAdaptWidth(16), kAppAdaptHeight(38))];
    //_nameLabel.backgroundColor = kRedColor;
    _nameLabel.font = kAppAdaptFont(14);
    _nameLabel.textColor = kRGBA(0, 0, 0, 0.87);
    _nameLabel.numberOfLines = 2;
    [self addSubview:_nameLabel];
    
    _reducePriceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _nameLabel.maxY + kAppAdaptHeight(10), _nameLabel.width, kAppAdaptHeight(20))];
    _reducePriceLabel.font = kAppAdaptFont(14);
    _reducePriceLabel.textColor = kRGBA(0, 0, 0, 0.87);
    _reducePriceLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_reducePriceLabel];
    
    _currentPriceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _nameLabel.maxY + kAppAdaptHeight(10), _nameLabel.width, kAppAdaptHeight(20))];
    _currentPriceLabel.font = kAppAdaptFont(14);
    _currentPriceLabel.textColor = WGAppBaseColor;
    _currentPriceLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_currentPriceLabel];
}

- (void)showWithData:(WGHomeFloorContentGoodItem *)object {
    [_imageView setImageWithURL:[NSURL URLWithString:object.pictureURL] placeholderImage:kHomeGoodColumnPlaceholderImage options:JHWebImageOptionsRefreshCached];
    _discountView.hidden = !object.hasDiscount;
    _discountView.discount = object.discount;
    _nameLabel.text = object.name;
    _currentPriceLabel.text = object.currentPrice;
    _reducePriceLabel.text = [object.price addMidline].string;
}

@end
