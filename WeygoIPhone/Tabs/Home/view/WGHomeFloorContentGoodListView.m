//
//  WGHomeFloorContentGoodListCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorContentGoodListView.h"
#import "WGRatingView.h"
#import "WGHomeFloorContentGoodItem.h"

@interface WGHomeFloorContentGoodListView ()
{
    JHImageView     *_imageView;
    JHImageView     *_discountImageView;
    JHLabel         *_discountLabel;
    
    JHLabel         *_nameLabel;
    JHLabel         *_briefDescribeLabel;
    WGRatingView    *_ratingView;
    JHLabel         *_currentPriceLabel;    //current price
    JHLabel         *_priceLabel;           //origin price
    JHLabel         *_reduceLabel;          //reduce price
    JHButton        *_purchaseBtn;
    
    WGHomeFloorContentGoodItem  *_data;
}
@end

@implementation WGHomeFloorContentGoodListView

- (void)loadSubviews {
    float marginLeft = kAppAdaptWidth(8);
    float marginRight = kAppAdaptWidth(16);
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(marginLeft, 0, kAppAdaptWidth(104), kAppAdaptHeight(124))];
    [self addSubview:_imageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_imageView.maxX + kAppAdaptWidth(16), kAppAdaptHeight(12), kDeviceWidth - _imageView.maxX - marginRight - kAppAdaptWidth(16), kAppAdaptHeight(20))];
    _nameLabel.font = kWGSFUIDisplaySemiBoldAdaptFont(14);
    [self addSubview:_nameLabel];
    
    _briefDescribeLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _nameLabel.maxY + kAppAdaptHeight(5), _nameLabel.width, kAppAdaptHeight(16))];
    _briefDescribeLabel.font = kWGSFUIDisplayRegularAdaptFont(12);
    [self addSubview:_briefDescribeLabel];
    
    _ratingView = [[WGRatingView alloc] initWithFrame:CGRectMake(_nameLabel.x, _briefDescribeLabel.maxY + kAppAdaptHeight(8), kAppAdaptWidth(120), kAppAdaptHeight(14))];
    [self addSubview:_ratingView];
    
    _currentPriceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _ratingView.maxY + kAppAdaptHeight(12), 100, kAppAdaptHeight(24))];
    _currentPriceLabel.font = kWGOswaldRegularFont(16);
    _currentPriceLabel.textColor = kRGB(238, 122, 60);
    [self addSubview:_currentPriceLabel];
    
    _priceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _ratingView.maxY + kAppAdaptHeight(12), 100, kAppAdaptHeight(24))];
    _priceLabel.font = kWGOswaldRegularFont(16);
    _priceLabel.textColor = kRGB(238, 122, 60);
    [self addSubview:_priceLabel];
    
    _priceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _ratingView.maxY + kAppAdaptHeight(12), 100, kAppAdaptHeight(24))];
    _priceLabel.font = kWGOswaldRegularFont(16);
    _priceLabel.textColor = kRGBA(0, 0, 0, 0.38);
    [self addSubview:_priceLabel];
    
    _reduceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _ratingView.maxY + kAppAdaptHeight(12), 100, kAppAdaptHeight(24))];
    _reduceLabel.font = kWGOswaldRegularFont(16);
    _reduceLabel.textColor = kRGB(238, 122, 60);
    [self addSubview:_reduceLabel];
    
    _purchaseBtn = [[JHButton alloc] initWithFrame:CGRectMake(kDeviceWidth - kAppAdaptWidth(16 + 24), kAppAdaptHeight(84), kAppAdaptWidth(24), kAppAdaptHeight(24))];
    [_purchaseBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_purchaseBtn addTarget:self action:@selector(touchPurchase:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_purchaseBtn];
}

- (void)touchPurchase:(JHButton *)sender {
    if (self.onPurchase) {
        self.onPurchase(_data);
    }
}

- (void)showWithData:(WGHomeFloorContentGoodItem *)object {
    _data = object;
    
    [_imageView setImageWithURL:[NSURL URLWithString:_data.pictureURL] placeholderImage:kHomeGoodListPlaceholderImage options:JHWebImageOptionsRefreshCached];
    
    _nameLabel.text = _data.name;
    
    _briefDescribeLabel.text = _data.briefDescription;
    
    [_ratingView showWithData:_data.rating];
    
    NSString *currentPrice = [NSString stringWithFormat:kStr(@"Price With Unit"), _data.currentPrice];
    CGSize size = [currentPrice returnSize:_currentPriceLabel.font];
    _currentPriceLabel.text = currentPrice;
    CGRect frame = _currentPriceLabel.frame;
    frame.size.width = size.width;
    _currentPriceLabel.frame = frame;
    
    NSString *price = [[NSString stringWithFormat:kStr(@"Price With Unit"), _data.price] addMidline].string;
    size = [price returnSize:_priceLabel.font];
    _priceLabel.text = price;
    frame = _priceLabel.frame;
    frame.origin.x = _currentPriceLabel.maxX + kAppAdaptWidth(8);
    frame.size.width = size.width;
    _priceLabel.frame = frame;
    
}

@end
