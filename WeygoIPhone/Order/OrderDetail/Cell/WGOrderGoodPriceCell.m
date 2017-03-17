//
//  WGOrderGoodPriceCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderGoodPriceCell.h"
#import "WGHomeFloorGoodListItemView.h"
#import "WGOrderGoodItem.h"
#import "WGOrderCountView.h"

@interface WGOrderGoodPriceCell ()
{
    WGOrderCountView *_countView;
    WGHomeFloorGoodListItemView *_itemView;
    JHLabel *_totalLabel;
    JHLabel *_reduceLabel;
    JHLabel *_priceLabel;
}
@end

@implementation WGOrderGoodPriceCell

- (void)loadSubviews {
    [super loadSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _itemView = [[WGHomeFloorGoodListItemView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(124))];
    [self.contentView addSubview:_itemView];
    
    _countView = [[WGOrderCountView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8), kAppAdaptHeight(8), kAppAdaptWidth(24), kAppAdaptWidth(24))];
    _countView.backgroundColor = kClearColor;
    [_itemView addSubview:_countView];
    
    JHView *frontView = [[JHView alloc] initWithFrame:CGRectMake(0, _itemView.maxY, kDeviceWidth/2, kAppAdaptHeight(40))];
    frontView.backgroundColor = kHRGB(0xF8FAFA);
    [self.contentView addSubview:frontView];
    
    _totalLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), 0, kDeviceWidth/2, kAppAdaptWidth(40))];
    _totalLabel.font = kAppAdaptFont(14);
    _totalLabel.textColor = WGAppLightNameLabelColor;
    [frontView addSubview:_totalLabel];
    
    JHView *laterView = [[JHView alloc] initWithFrame:CGRectMake(kDeviceWidth/2, frontView.y, kDeviceWidth/2, kAppAdaptHeight(40))];
    laterView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:laterView];
    
    _priceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, 0, laterView.width/2, kAppAdaptWidth(40))];
    _priceLabel.font = kAppAdaptFont(14);
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    _priceLabel.textColor = WGAppLightNameLabelColor;
    [laterView addSubview:_priceLabel];
    
    _reduceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(laterView.width/2, 0, laterView.width/2, kAppAdaptWidth(40))];
    _reduceLabel.font = kAppAdaptFont(14);
    _reduceLabel.textAlignment = NSTextAlignmentCenter;
    _reduceLabel.textColor = WGAppLightNameLabelColor;
    [laterView addSubview:_reduceLabel];
    
    JHView *headerLine = [[JHView alloc] initWithFrame:CGRectMake(0, _itemView.maxY, kDeviceWidth, kAppSepratorLineHeight)];
    headerLine.backgroundColor = WGAppSeparateLineColor;
    [self.contentView  addSubview:headerLine];
    
    JHView *footerLine = [[JHView alloc] initWithFrame:CGRectMake(0, laterView.maxY - kAppSepratorLineHeight, kDeviceWidth, kAppSepratorLineHeight)];
    footerLine.backgroundColor = WGAppSeparateLineColor;
    [self.contentView addSubview:footerLine];
}

- (void)showWithData:(JHObject *)data {
    [super showWithData:data];
    WGOrderGoodItem *item = (WGOrderGoodItem *)data;
    if (item) {
        [_itemView showWithData:item];
        _countView.value = [NSString stringWithFormat:kStr(@"Order Good Number"), item.number];
        NSString *currentPrice = [NSString stringWithFormat:@"€%.2f", item.orderCurrentPrice];
        _totalLabel.text = [NSString stringWithFormat:kStr(@"Order Pay Totale"), item.orderCurrentPrice];
        [_totalLabel setPartString:currentPrice attributes:@{NSForegroundColorAttributeName : WGAppBaseColor}];
        _reduceLabel.text = [NSString stringWithFormat:@"€%.2f", item.orderReducePrice];
        _priceLabel.attributedText = [[NSString stringWithFormat:@"€%.2f", item.orderPrice] addMidline];
    }
    
}

+ (CGFloat)heightWithData:(JHObject *)data {
    return kAppAdaptHeight(164);
}

@end
