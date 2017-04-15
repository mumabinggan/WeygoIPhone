//
//  WGHomeFloorGoodGridItemView.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorGoodGridItemView.h"

@implementation WGHomeFloorGoodGridItemView

- (void)loadSubviews {
    [super loadSubviews];

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
    
    _purchaseBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(10), _currentPriceLabel.maxY + kAppAdaptHeight(10), self.width - kAppAdaptWidth(20), kAppAdaptHeight(30)) difRadius:JHRadiusMake(kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15)) backgroundColor:WGAppBaseColor];
    [_purchaseBtn setTitle:kStr(@"Add to Cart") forState:UIControlStateNormal];
    _purchaseBtn.titleLabel.font = kAppAdaptFont(12);
    [self addSubview:_purchaseBtn];
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
    [super showWithData:object];
}

@end
