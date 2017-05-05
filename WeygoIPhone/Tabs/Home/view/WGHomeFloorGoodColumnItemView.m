//
//  WGHomeFloorGoodColumnItemView.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorGoodColumnItemView.h"

@interface WGHomeFloorGoodColumnItemView ()
{
    JHImageView     *_discountImageView;
    JHLabel         *_discountLabel;
}
@end

@implementation WGHomeFloorGoodColumnItemView

- (void)loadSubviews {
    [super loadSubviews];
    self.backgroundColor = kWhiteColor;
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self addSubview:_imageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8), _imageView.maxY + kAppAdaptHeight(12), self.width - kAppAdaptWidth(16), kAppAdaptHeight(38))];
    //_nameLabel.backgroundColor = kRedColor;
    _nameLabel.font = kAppAdaptFont(14);
    _nameLabel.textColor = kRGBA(0, 0, 0, 0.87);
    _nameLabel.numberOfLines = 2;
    [self addSubview:_nameLabel];
    
    _reducePriceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _nameLabel.maxY + kAppAdaptHeight(10), _nameLabel.width, kAppAdaptHeight(20))];
    _reducePriceLabel.font = kAppAdaptFont(15);
    _reducePriceLabel.textColor = kRGBA(0, 0, 0, 0.87);
    _reducePriceLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_reducePriceLabel];
    
    _currentPriceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _nameLabel.maxY + kAppAdaptHeight(10), _nameLabel.width, kAppAdaptHeight(20))];
    _currentPriceLabel.font = kAppAdaptFont(16);
    _currentPriceLabel.textColor = WGAppBaseColor;
    _currentPriceLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_currentPriceLabel];
}

- (void)showWithData:(WGHomeFloorContentGoodItem *)object {
    [_imageView setImageWithURL:[NSURL URLWithString:object.pictureURL] placeholderImage:kHomeGoodColumnPlaceholderImage options:JHWebImageOptionsRefreshCached];
    _nameLabel.text = object.name;
    _currentPriceLabel.text = object.currentPrice;
    _reducePriceLabel.text = [object.price addMidline].string;
}

@end
