//
//  WGCommodityDesCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommodityDesCell.h"
#import "WGGoodDetail.h"

@interface WGCommodityDesCell ()
{
    JHLabel *_nameLabel;
    JHLabel *_contentLabel;
}
@end

@implementation WGCommodityDesCell

- (void)loadSubviews {
    JHView *headerView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(40))];
    headerView.backgroundColor = kHRGB(0xF8FAFA);
    [self.contentView addSubview:headerView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), 0, kDeviceWidth - kAppAdaptWidth(30), headerView.height)];
    _nameLabel.text = kStr(@"Good Detail CommodityInfo");
    _nameLabel.font = kAppAdaptFontBold(14);
    _nameLabel.textColor = kRGBA(0, 0, 0, 0.87);
    [headerView addSubview:_nameLabel];
    
    _contentLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, kAppAdaptHeight(16) + _nameLabel.maxY, kDeviceWidth - kAppAdaptWidth(30), 1)];
    _contentLabel.font = kAppAdaptFont(14);
    _contentLabel.numberOfLines = 0;
    _contentLabel.textColor = kRGBA(0, 0, 0, 0.38);
    [self.contentView addSubview:_contentLabel];
}

- (void)showWithData:(JHObject *)data {
    WGGoodDetail *good = (WGGoodDetail *)data;
    _contentLabel.text = good.commodityInfo;
    CGSize size = [good.commodityInfo returnSize:_contentLabel.font maxWidth:_contentLabel.width];
    _contentLabel.height = size.height;
}

+ (CGFloat)heightWithData:(JHObject *)data {
    CGFloat height = 0.0f;
    WGGoodDetail *good = (WGGoodDetail *)data;
    if ([NSString isNullOrEmpty:good.commodityInfo]) {
        return height;
    }
    height += kAppAdaptHeight(40);
    height += kAppAdaptHeight(15);
    CGSize size = [good.commodityInfo returnSize:kAppAdaptFont(14) maxWidth:kDeviceWidth - kAppAdaptWidth(30)];
    height += size.height;
    height += kAppAdaptHeight(15);
    return height;
}

@end
