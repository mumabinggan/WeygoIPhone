//
//  WGShopCartCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGShopCartCell.h"
#import "WGShopCartGoodItem.h"
#import "WGGoodAddView.h"

@interface WGShopCartCell ()
{
    JHImageView     *_imageView;
    
    JHLabel         *_nameLabel;
    JHLabel         *_briefDescribeLabel;
    
    JHLabel         *_currentPriceLabel;    //current price
    JHLabel         *_priceLabel;           //origin price
    JHLabel         *_reduceLabel;          //reduce price
    
    WGGoodAddView *_addView;
    
    WGShopCartGoodItem  *_data;
}
@end

@implementation WGShopCartCell

- (void)loadSubviews {
    float marginLeft = kAppAdaptWidth(8);
    float marginRight = kAppAdaptWidth(16);
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(marginLeft, 0, kAppAdaptWidth(104), kAppAdaptHeight(124))];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_imageView.maxX + kAppAdaptWidth(16), kAppAdaptHeight(12), kDeviceWidth - _imageView.maxX - marginRight - kAppAdaptWidth(16), kAppAdaptHeight(20))];
    _nameLabel.font = kAppAdaptFontBold(16);
    _nameLabel.textColor = kRGBA(0, 0, 0, 0.87);
    [self.contentView addSubview:_nameLabel];
    
    _briefDescribeLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _nameLabel.maxY + kAppAdaptHeight(5), _nameLabel.width, kAppAdaptHeight(16))];
    _briefDescribeLabel.font = kAppAdaptFont(14);
    _briefDescribeLabel.textColor = kRGBA(0, 0, 0, 0.54);
    [self.contentView addSubview:_briefDescribeLabel];
    
    _currentPriceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _briefDescribeLabel.maxY + kAppAdaptHeight(12), 100, kAppAdaptHeight(24))];
    _currentPriceLabel.font = kWGOswaldRegularFont(16);
    _currentPriceLabel.font = kAppAdaptFont(17);
    _currentPriceLabel.textColor = kRGB(238, 122, 60);
    [self.contentView addSubview:_currentPriceLabel];
    
    _priceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _briefDescribeLabel.maxY + kAppAdaptHeight(16), 100, kAppAdaptHeight(16))];
    _priceLabel.font = kWGOswaldRegularFont(12);
    _priceLabel.font = kAppAdaptFont(14);
    _priceLabel.textColor = kRGBA(0, 0, 0, 0.38);
    [self.contentView addSubview:_priceLabel];
    
    _reduceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _briefDescribeLabel.maxY + kAppAdaptHeight(16), 100, kAppAdaptHeight(16))];
    _reduceLabel.font = kWGOswaldRegularFont(12);
    _reduceLabel.font = kAppAdaptFont(14);
    _reduceLabel.textColor = kWhiteColor;
    _reduceLabel.textAlignment = NSTextAlignmentCenter;
    _reduceLabel.backgroundColor = WGAppBaseColor;
    _reduceLabel.layer.cornerRadius = kAppAdaptWidth(3);
    _reduceLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:_reduceLabel];
    
    _addView = [[WGGoodAddView alloc] initWithFrame:CGRectMake(_nameLabel.x, _reduceLabel.maxY + kAppAdaptHeight(5), kAppAdaptWidth(80), kAppAdaptHeight(24))];
    _addView.fromType = WGGoodAddViewFromCart;
    _addView.count = 1;
    WeakSelf;
    _addView.onAdd = ^(NSInteger count) {
        [weakSelf handleAdd];
    };
    _addView.onSub = ^(NSInteger count) {
        [weakSelf handleSub];
    };
    [self.contentView addSubview:_addView];
}

- (void)showWithData:(WGShopCartGoodItem *)object {
    _data = object;
    
    self.backgroundColor = (_data && !_data.inStock) ? kHRGB(0XF8FAFA) : kWhiteColor;
    
    [_imageView setImageWithURL:[NSURL URLWithString:_data.pictureURL] placeholderImage:kHomeGoodListPlaceholderImage options:JHWebImageOptionsRefreshCached];
    
    _nameLabel.text = _data.name;
    
    _briefDescribeLabel.text = _data.briefDescription;
    
    NSString *currentPrice = _data.currentPrice;
    CGSize size = [currentPrice returnSize:_currentPriceLabel.font];
    _currentPriceLabel.text = currentPrice;
    CGRect frame = _currentPriceLabel.frame;
    frame.size.width = size.width;
    _currentPriceLabel.frame = frame;
    
    NSString *price = [_data.price addMidline].string;
    size = [price returnSize:_priceLabel.font];
    _priceLabel.attributedText = [price addMidline];
    frame = _priceLabel.frame;
    frame.origin.x = _currentPriceLabel.maxX + kAppAdaptWidth(8);
    frame.size.width = size.width;
    _priceLabel.frame = frame;
    
    NSString *reduce = _data.reducePrice;
    size = [reduce returnSize:_reduceLabel.font];
    frame = _reduceLabel.frame;
    frame.origin.x = _priceLabel.maxX + kAppAdaptWidth(8);
    frame.size.width = size.width + kAppAdaptWidth(4);
    _reduceLabel.frame = frame;
    _reduceLabel.text = reduce;
    
    _addView.count = _data.goodCount;
}

- (void)handleAdd {
    if (self.onAdd) {
        self.onAdd(_data);
    }
}

- (void)handleSub {
    if (self.onSub) {
        self.onSub(_data);
    }
}

@end
