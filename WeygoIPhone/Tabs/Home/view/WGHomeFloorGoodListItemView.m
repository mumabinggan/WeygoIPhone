//
//  WGHomeFloorContentGoodListCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorGoodListItemView.h"
#import "WGRatingView.h"
#import "WGHomeFloorContentGoodItem.h"
#import "WGDiscountView.h"

@interface WGHomeFloorGoodListItemView ()
{
    JHImageView     *_imageView;
    
    JHLabel         *_nameLabel;
    JHLabel         *_briefDescribeLabel;
    JHLabel         *_chineseNameLabel;
    WGRatingView    *_ratingView;
    JHLabel         *_currentPriceLabel;    //current price
    JHLabel         *_priceLabel;           //origin price
    JHLabel         *_reduceLabel;          //reduce price
    
    JHButton        *_purchaseResponseButton;
    JHButton        *_purchaseBtn;
    
    JHButton        *_unPurchaseBtn;
    
    WGHomeFloorContentGoodItem  *_data;
}
@end

@implementation WGHomeFloorGoodListItemView

- (void)loadSubviews {
    float marginLeft = kAppAdaptWidth(8);
    float marginRight = kAppAdaptWidth(16);
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(marginLeft, 0, kAppAdaptWidth(104), kAppAdaptHeight(124))];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self addSubview:_imageView];
    
    CGFloat width = _imageView.width * 3 / 7;
    _discountView = [[WGDiscountView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    _discountView.font = kWGOswaldMediumAdaptFont(11);
    [_imageView addSubview:_discountView];
    _discountView.hidden = YES;
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_imageView.maxX + kAppAdaptWidth(16), kAppAdaptHeight(12), kDeviceWidth - _imageView.maxX - marginRight - kAppAdaptWidth(16), kAppAdaptHeight(20))];
    _nameLabel.font = kAppAdaptFontBold(16);
    _nameLabel.textColor = kRGBA(0, 0, 0, 0.87);
    [self addSubview:_nameLabel];
    
    _briefDescribeLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _nameLabel.maxY + kAppAdaptHeight(5), _nameLabel.width, kAppAdaptHeight(16))];
    _briefDescribeLabel.font = kAppAdaptFont(14);
    _briefDescribeLabel.textColor = kRGBA(0, 0, 0, 0.54);
    [self addSubview:_briefDescribeLabel];
    
    _chineseNameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _briefDescribeLabel.maxY + kAppAdaptHeight(5), _nameLabel.width, kAppAdaptHeight(16))];
    //_briefDescribeLabel.font = kWGSFUIDisplayRegularAdaptFont(8);
    _chineseNameLabel.font = kAppAdaptFont(14);
    _chineseNameLabel.textColor = kRGBA(0, 0, 0, 0.54);
    [self addSubview:_chineseNameLabel];
    
    _ratingView = [[WGRatingView alloc] initWithFrame:CGRectMake(_nameLabel.x, _briefDescribeLabel.maxY + kAppAdaptHeight(8), kAppAdaptWidth(120), kAppAdaptHeight(14))];
    //[self addSubview:_ratingView];
    
    _currentPriceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _chineseNameLabel.maxY + kAppAdaptHeight(12), 100, kAppAdaptHeight(24))];
    _currentPriceLabel.font = kWGOswaldRegularAdaptFont(16);
    //_currentPriceLabel.font = kWGOswaldRegularAdaptFont(17);
    _currentPriceLabel.textColor = kRGB(238, 122, 60);
    [self addSubview:_currentPriceLabel];
    
    _priceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _chineseNameLabel.maxY + kAppAdaptHeight(16), 100, kAppAdaptHeight(16))];
    _priceLabel.font = kAppAdaptFont(14);
    _priceLabel.textColor = kRGBA(0, 0, 0, 0.38);
    [self addSubview:_priceLabel];
    
    _reduceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _chineseNameLabel.maxY + kAppAdaptHeight(16), 100, kAppAdaptHeight(16))];
    _reduceLabel.font = kAppAdaptFont(14);
    _reduceLabel.textColor = kWhiteColor;
    _reduceLabel.textAlignment = NSTextAlignmentCenter;
    _reduceLabel.backgroundColor = WGAppBaseColor;
    _reduceLabel.layer.cornerRadius = kAppAdaptWidth(3);
    _reduceLabel.layer.masksToBounds = YES;
    [self addSubview:_reduceLabel];
    
    _purchaseResponseButton = [[JHButton alloc] initWithFrame:CGRectMake(kDeviceWidth/5 * 4, 0, kDeviceWidth/5, self.height)];
    [_purchaseResponseButton addTarget:self action:@selector(touchPurchase:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_purchaseResponseButton];
    _purchaseBtn = [[JHButton alloc] initWithFrame:CGRectMake(kDeviceWidth - kAppAdaptWidth(16 + 24), kAppAdaptHeight(86), kAppAdaptWidth(24), kAppAdaptHeight(24))];
    [_purchaseBtn setImage:[UIImage imageNamed:@"add_cart"] forState:UIControlStateNormal];
    [_purchaseBtn addTarget:self action:@selector(touchPurchase:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_purchaseBtn];
    
    _unPurchaseBtn = [[JHButton alloc] initWithFrame:CGRectMake(kDeviceWidth - kAppAdaptWidth(16 + 72), kAppAdaptHeight(88), kAppAdaptWidth(72), kAppAdaptHeight(20)) difRadius:JHRadiusMake(kAppAdaptHeight(10), kAppAdaptHeight(10), kAppAdaptHeight(10), kAppAdaptHeight(10)) backgroundColor:kHRGB(0xB0BEC5)];
    [_unPurchaseBtn setTitle:kStr(@"GoodList_UnPurchase") forState:UIControlStateNormal];
    [_unPurchaseBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    _unPurchaseBtn.titleLabel.font = kAppAdaptFont(12);
    [self addSubview:_unPurchaseBtn];
}

- (void)touchPurchase:(JHButton *)sender {
    if (self.onPurchase) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        CGPoint point = [self convertPoint:CGPointMake(_imageView.x + _imageView.width/2, _imageView.y) toView:window];
        self.onPurchase(_data, point);
    }
}

- (void)showWithData:(WGHomeFloorContentGoodItem *)object {
    _data = object;
    
    [_imageView setImageWithURL:[NSURL URLWithString:_data.pictureURL] placeholderImage:kHomeGoodListPlaceholderImage options:JHWebImageOptionsRefreshCached];
    
    _discountView.hidden = !_data.hasDiscount;
    _discountView.discount = _data.discount;
    
    _nameLabel.text = _data.name;
    
    _briefDescribeLabel.text = _data.briefDescription;
    
    _chineseNameLabel.text = [NSString isNullOrEmpty:_data.expiredTime] ? _data.chineseName : _data.expiredTime;
    
    //[_ratingView showWithData:_data.rating];
    
    NSString *currentPrice = _data.currentPrice;
    CGSize size = [currentPrice returnSize:_currentPriceLabel.font];
    _currentPriceLabel.text = currentPrice;
    CGRect frame = _currentPriceLabel.frame;
    frame.size.width = size.width;
    _currentPriceLabel.frame = frame;
    
    NSString *price = _data.price;
    size = [price returnSize:_priceLabel.font];
    _priceLabel.attributedText = [price addMidline];
    frame = _priceLabel.frame;
    frame.origin.x = _currentPriceLabel.maxX + kAppAdaptWidth(8);
    frame.size.width = size.width;
    _priceLabel.frame = frame;
    
    NSString *reduce =_data.reducePrice;
    size = [reduce returnSize:_reduceLabel.font];
    frame = _reduceLabel.frame;
    frame.origin.x = _priceLabel.maxX + kAppAdaptWidth(8);
    frame.size.width = size.width + kAppAdaptWidth(4);
    _reduceLabel.frame = frame;
    _reduceLabel.text = reduce;
    _reduceLabel.hidden = [NSString isNullOrEmpty:reduce];
    
    _unPurchaseBtn.hidden = (_data.inStock);
    _purchaseBtn.hidden = (!_data.inStock);
    _purchaseResponseButton.hidden = (!_data.inStock);
}

@end
