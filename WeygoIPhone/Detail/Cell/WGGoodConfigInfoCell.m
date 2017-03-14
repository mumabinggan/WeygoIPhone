//
//  WGGoodConfigInfoCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGoodConfigInfoCell.h"
#import "WGGoodDetail.h"

@interface WGGoodConfigInfoCell ()
{
    JHLabel *_nameLabel;
    JHLabel *_priceLabel;
    JHLabel *_currentLabel;
}
@end

@implementation WGGoodConfigInfoCell

- (void)loadSubviews {
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), kAppAdaptHeight(16), kDeviceWidth - kAppAdaptWidth(30), 1)];
    _nameLabel.font = kAppAdaptFontBold(16);
    _nameLabel.textColor = kRGBA(0, 0, 0, 0.87);
    _nameLabel.numberOfLines = 0;
    [self.contentView addSubview:_nameLabel];
    
    _currentLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), 0, kAppAdaptWidth(100), kAppAdaptHeight(20))];
    _currentLabel.font = kAppAdaptFont(14);
    _currentLabel.textColor = WGAppBaseColor;
    [self.contentView addSubview:_currentLabel];
    
    _priceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), 0, kAppAdaptWidth(100), _currentLabel.height)];
    _priceLabel.font = kAppAdaptFont(14);
    _priceLabel.textColor = WGAppLightNameLabelColor;
    [self.contentView addSubview:_priceLabel];
}

- (void)showWithData:(JHObject *)data {
    WGGoodDetail *good = (WGGoodDetail *)data;
    _nameLabel.text = good.name;
    CGSize size = [good.name returnSize:_nameLabel.font maxWidth:_nameLabel.width];
    _nameLabel.height = size.height;
    NSString *currentPriceStr = [NSString stringWithFormat:kStr(@"Good Detail Price With .2 Unit"), good.currentPrice];
    _currentLabel.text = currentPriceStr;
    _currentLabel.y = _nameLabel.maxY + kAppAdaptHeight(8);
    size = [currentPriceStr returnSize:_currentLabel.font maxWidth:200];
    _currentLabel.width = size.width + kAppAdaptWidth(5);
    
    NSString *priceStr = [NSString stringWithFormat:kStr(@"Good Detail Price With .2 Unit"), good.price];
    _priceLabel.attributedText = [priceStr addMidline];
    _priceLabel.x = _currentLabel.maxX + kAppAdaptWidth(10);
    _priceLabel.y = _currentLabel.y;
}

+ (CGFloat)heightWithData:(JHObject *)data {
    CGFloat height = 0.0f;
    WGGoodDetail *good = (WGGoodDetail *)data;
    height += kAppAdaptHeight(16);
    height += [good.name returnSize:kAppAdaptFontBold(16) maxWidth:kDeviceWidth - kAppAdaptWidth(30)].height;
    height += kAppAdaptHeight(8);
    NSString *currentPriceStr = [NSString stringWithFormat:kStr(@"Good Detail Price With .2 Unit"), good.currentPrice];
    height += [currentPriceStr returnSize:kAppAdaptFont(14) maxWidth:200].height;
    height += kAppAdaptHeight(16);
    return height;
}

@end
