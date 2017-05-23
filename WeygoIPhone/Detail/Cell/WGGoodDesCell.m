//
//  WGGoodDesCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGGoodDesCell.h"
#import "WGGoodDetail.h"
#import "WGSegmentView.h"

@interface WGGoodDesCell ()
{
    WGSegmentView *_titleSegmentView;
    JHScrollView *_scrollView;
    JHView *_desView;
    JHView *_infoView;
    JHView *_deliverView;
}
@end

@implementation WGGoodDesCell

- (void)loadSubviews {
    _titleSegmentView = [[WGSegmentView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(44))];
    [_titleSegmentView setTitleArray:@[kStr(@"Good Detail Des"), kStr(@"Good Detail Info"), kStr(@"Good Detail Consegna")]];
    _titleSegmentView.backgroundColor = kWhiteColor;
    __weak id weakSelf = self;
    _titleSegmentView.onSelect = ^(NSInteger oldIndex, NSInteger newIndex) {
        [weakSelf setContentsScrollViewOffsetWithIndex:newIndex];
    };
    _titleSegmentView.layer.shadowColor = kBlackColor.CGColor;
    _titleSegmentView.layer.shadowOffset = CGSizeMake(0, 1);
    _titleSegmentView.layer.shadowRadius = 1;
    _titleSegmentView.layer.shadowOpacity = 0.15;
    [self.contentView addSubview:_titleSegmentView];
    
    JHView *lineView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
    lineView.backgroundColor = kHRGBA(0x000000, 0.12);
    [_titleSegmentView addSubview:lineView];
    //[self setContentsScrollViewOffsetWithIndex:0];
}

- (void)setContentsScrollViewOffsetWithIndex:(NSInteger)index {
    if (index == 0) {
        _desView.hidden = NO;
        _infoView.hidden = YES;
        _deliverView.hidden = YES;
    }
    else if (index == 1) {
        _desView.hidden = YES;
        _infoView.hidden = NO;
        _deliverView.hidden = YES;
    }
    else {
        _desView.hidden = YES;
        _infoView.hidden = YES;
        _deliverView.hidden = NO;
    }
}

- (void)showWithData:(JHObject *)data {
    WGGoodDetail *good = (WGGoodDetail *)data;
    if (!_desView) {
        _desView = [[JHView alloc] initWithFrame:CGRectMake(0, _titleSegmentView.maxY, kDeviceWidth, 1)];
        _desView.backgroundColor = kHRGB(0xF8FAFA);
        [self.contentView addSubview:_desView];
        
        CGFloat width = kDeviceWidth - kAppAdaptWidth(30);
        CGSize size = [good.productInfo returnSize:kAppAdaptFont(14) maxWidth:width];
        
        JHLabel *keyLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), kAppAdaptHeight(15), width, size.height)];
        keyLabel.font = kAppAdaptFont(14);
        keyLabel.text = good.productInfo;
        keyLabel.numberOfLines = 0;
        keyLabel.textColor = kRGBA(0, 0, 0, 0.54);
        [_desView addSubview:keyLabel];
        
        _desView.height = kAppAdaptHeight(30) + size.height;
        
//        CGFloat height = kAppAdaptHeight(48);
//        for (int num = 0; num < good.productDes.count; ++num) {
//            WGGoodDetailDesItem *item = good.productDes[num];
//            JHView *keyView = [[JHView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), kAppAdaptHeight(15) + num * height, kAppAdaptWidth(152), height)];
//            keyView.layer.borderColor = kHRGBA(0x000000, 0.12).CGColor;
//            keyView.layer.borderWidth = kAppSepratorLineHeight;
//            [_desView addSubview:keyView];
//            
//            JHLabel *keyLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), 0, keyView.width - kAppAdaptWidth(30), keyView.height)];
//            keyLabel.font = kAppAdaptFont(14);
//            keyLabel.text = item.name;
//            keyLabel.textColor = kRGBA(0, 0, 0, 0.54);
//            [keyView addSubview:keyLabel];
//            
//            JHView *valueView = [[JHView alloc] initWithFrame:CGRectMake(keyView.maxX, keyView.y, kAppAdaptWidth(192), kAppAdaptHeight(48))];
//            valueView.layer.borderColor = kHRGBA(0x000000, 0.12).CGColor;
//            valueView.layer.borderWidth = kAppSepratorLineHeight;
//            [_desView addSubview:valueView];
//            
//            JHLabel *valueLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), 0, valueView.width - kAppAdaptWidth(30), valueView.height)];
//            valueLabel.text = item.value;
//            valueLabel.font = kAppAdaptFont(14);
//            valueLabel.textColor = kRGBA(0, 0, 0, 0.54);
//            [valueView addSubview:valueLabel];
//        }
//        _desView.height = good.productDes.count * kAppAdaptHeight(48) + kAppAdaptHeight(30);
    }
    if (!_infoView) {
        _infoView = [[JHView alloc] initWithFrame:CGRectMake(0, _titleSegmentView.maxY, kDeviceWidth, 1)];
        _infoView.backgroundColor = kHRGB(0xF8FAFA);
        [self.contentView addSubview:_infoView];
        
        CGFloat width = kDeviceWidth - kAppAdaptWidth(30);
        CGSize size = [good.purchaseTip returnSize:kAppAdaptFont(14) maxWidth:width];
        
        JHLabel *keyLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), kAppAdaptHeight(15), width, size.height)];
        keyLabel.font = kAppAdaptFont(14);
        keyLabel.text = good.purchaseTip;
        keyLabel.numberOfLines = 0;
        keyLabel.textColor = kRGBA(0, 0, 0, 0.54);
        [_infoView addSubview:keyLabel];
        
        _infoView.height = kAppAdaptHeight(30) + size.height;
    }
    
    if (!_deliverView) {
        UIFont *font = kAppAdaptFont(14);
        _deliverView = [[JHView alloc] initWithFrame:CGRectMake(0, _titleSegmentView.maxY, kDeviceWidth, 1)];
        _deliverView.backgroundColor = kHRGB(0xF8FAFA);
        [self.contentView addSubview:_deliverView];
        
        CGFloat width = kDeviceWidth - kAppAdaptWidth(30);
        CGSize size = [good.deliveryInfo returnSize:font maxWidth:width];
        
        JHLabel *keyLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), kAppAdaptHeight(15), width, size.height)];
        keyLabel.font = font;
        keyLabel.numberOfLines = 0;
        keyLabel.text = good.deliveryInfo;
        keyLabel.textColor = kRGBA(0, 0, 0, 0.54);
        [_deliverView addSubview:keyLabel];
        
        _deliverView.height = kAppAdaptHeight(30) + size.height;
        [_titleSegmentView setSelectedIndex:0];
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    CGFloat height = 0.0f;
    WGGoodDetail *good = (WGGoodDetail *)data;
    CGFloat desHeight = kAppAdaptHeight(30) + [good.productInfo returnSize:kAppAdaptFont(14) maxWidth:(kDeviceWidth - kAppAdaptWidth(30))].height;
    CGFloat infoHeight = kAppAdaptHeight(30) + [good.purchaseTip returnSize:kAppAdaptFont(14) maxWidth:(kDeviceWidth - kAppAdaptWidth(30))].height;
    CGFloat deliverHeight = kAppAdaptHeight(30) + [good.deliveryInfo returnSize:kAppAdaptFont(14) maxWidth:(kDeviceWidth - kAppAdaptWidth(30))].height;
    height = MAX(MAX(desHeight, infoHeight), deliverHeight);
    return height + kAppAdaptHeight(44);
}

@end
