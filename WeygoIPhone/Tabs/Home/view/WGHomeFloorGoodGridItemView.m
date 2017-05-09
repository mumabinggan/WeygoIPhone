//
//  WGHomeFloorGoodGridItemView.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorGoodGridItemView.h"

@interface WGHomeFloorGoodGridItemView ()
{
    JHLabel *_specificationLabel;
}
@end

@implementation WGHomeFloorGoodGridItemView

- (void)loadSubviews {
    [super loadSubviews];

    _discountView.font = kWGOswaldMediumAdaptFont(15);
    
    CGRect frame = _nameLabel.frame;
    frame.origin.x = kAppAdaptWidth(10);
    frame.size = CGSizeMake(self.width - kAppAdaptWidth(20), kAppAdaptHeight(40));
    _nameLabel.frame = frame;
    _nameLabel.font = kAppAdaptFontBold(16);
    
    frame = _currentPriceLabel.frame;
    frame.origin.x = kAppAdaptWidth(10);
    frame.size.width = _nameLabel.width;
    frame.size.height = kAppAdaptHeight(20);
    frame.origin.y = _nameLabel.maxY + kAppAdaptHeight(10);
    _currentPriceLabel.frame = frame;
    
    frame = _reducePriceLabel.frame;
    frame.origin.x = kAppAdaptWidth(10);
    frame.size.width = _nameLabel.width;
    frame.size.height = kAppAdaptHeight(20);
    frame.origin.y = _nameLabel.maxY + kAppAdaptHeight(10);
    _reducePriceLabel.frame = frame;
    
    _specificationLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _currentPriceLabel.maxY + kAppAdaptHeight(10), self.width - kAppAdaptWidth(20), kAppAdaptHeight(20))];
    _specificationLabel.font = kAppAdaptFont(14);
    _specificationLabel.textColor = WGAppNameLabelColor;
    [self addSubview:_specificationLabel];
    
    _purchaseBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(10), _specificationLabel.maxY + kAppAdaptHeight(10), self.width - kAppAdaptWidth(20), kAppAdaptHeight(30)) difRadius:JHRadiusMake(kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15)) backgroundColor:WGAppBaseColor];
    [_purchaseBtn setTitle:kStr(@"Add to Cart") forState:UIControlStateNormal];
    _purchaseBtn.titleLabel.font = kAppAdaptFont(12);
    [_purchaseBtn addTarget:self action:@selector(touchPurchase:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_purchaseBtn];
    
    _notPurchaseBtn = [[JHButton alloc] initWithFrame:_purchaseBtn.frame difRadius:JHRadiusMake(kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15)) backgroundColor:kRGB(173, 190, 197)];
    [_notPurchaseBtn setTitle:kStr(@"Home_Grid_Instock") forState:UIControlStateNormal];
    _notPurchaseBtn.titleLabel.font = kAppAdaptFont(12);
    [self addSubview:_notPurchaseBtn];
}

- (void)touchPurchase:(id)sender {
    if (self.onPurchase) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        CGPoint point = [self convertPoint:CGPointMake(_imageView.x + _imageView.width/2, _imageView.y) toView:window];
        self.onPurchase(_data, point);
    }
}

- (void)showWithData:(WGHomeFloorContentGoodItem *)object {
    _data = object;
    if (_displaySpecification) {
        if ([NSString isNullOrEmpty:_data.specification]) {
            _specificationLabel.hidden = YES;
            _purchaseBtn.y = _currentPriceLabel.maxY + kAppAdaptHeight(10);
            _notPurchaseBtn.y = _currentPriceLabel.maxY + kAppAdaptHeight(10);
        }
        else {
            _specificationLabel.hidden = NO;
            _purchaseBtn.y = _specificationLabel.maxY + kAppAdaptHeight(10);
            _notPurchaseBtn.y = _specificationLabel.maxY + kAppAdaptHeight(10);
            _specificationLabel.text = _data.specification;
        }
    }
    else {
        _specificationLabel.hidden = YES;
        _purchaseBtn.y = _currentPriceLabel.maxY + kAppAdaptHeight(10);
        _notPurchaseBtn.y = _currentPriceLabel.maxY + kAppAdaptHeight(10);
    }
    _notPurchaseBtn.hidden = (_data.inStock);
    //[_purchaseBtn setBackgroundColor:(_data.inStock) ? WGAppBaseColor : WGAppSeparateLineColor];
    [super showWithData:object];
}

@end
