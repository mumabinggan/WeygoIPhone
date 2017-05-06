//
//  WGCommitOrderLookMoreCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommitOrderLookMoreCell.h"
#import "WGSettlementResult.h"

@interface WGCommitOrderLookMoreCell ()
{
    JHLabel *_tipLabel;
    JHLabel *_moreLabel;
    WGSettlementTips *_tip;
}
@end

@implementation WGCommitOrderLookMoreCell

- (void)loadSubviews {
    [super loadSubviews];
    _tipLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), kAppAdaptHeight(12), kAppAdaptWidth(270), 1)];
    _tipLabel.font = kAppAdaptFont(12);
    _tipLabel.textColor = WGAppBaseColor;
    _tipLabel.numberOfLines = 0;
    [self.contentView addSubview:_tipLabel];
    
    _moreLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_tipLabel.maxX + kAppAdaptWidth(20), 0, kAppAdaptWidth(72), 1)];
    _moreLabel.font = kAppAdaptFont(12);
    _moreLabel.textColor = WGAppBaseColor;
    _moreLabel.text = kStr(@"CommitOrder Look More");
    [self.contentView addSubview:_moreLabel];
    _moreLabel.userInteractionEnabled = YES;
    
    [_moreLabel addSingleTapGestureRecognizerWithTarget:self action:@selector(handleMore:)];
}

- (void)handleMore:(UIGestureRecognizer *)recognizer {
    if (self.onMore) {
        self.onMore(_tip);
    }
}

- (void)showWithData:(JHObject *)data {
    _tip = (WGSettlementTips *)data;
    if (_tip) {
        _tipLabel.text = _tip.orderPriceTip;
        CGSize size = [_tip.orderPriceTip returnSize:_tipLabel.font maxWidth:_tipLabel.width];
        _tipLabel.height = size.height;
        CGFloat height = [WGCommitOrderLookMoreCell heightWithData:_tip];
        _moreLabel.height = height;
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    WGSettlementTips *tip = (WGSettlementTips *)data;
    tip.orderPriceTip = @"iOS UIView的点击事件与触摸手势 - Gabriel的专栏 - 博客频道 - ..";
    tip.orderPriceDetailTip = @"2014年7月23日 - 在UIViewController中,加入协议UIGestureRecognizerDelegate,然后.m文件里加入以下代码...在照片查看的时候,缩小手势也可实现缩小图片的功能。 8.长按...blog.csdn.net/gf771115...  - 百度快照 - 1766条评价";
    if (tip) {
//        if ([NSString isNullOrEmpty:tip.orderPriceTip] &&
//            [NSString isNullOrEmpty:tip.orderPriceDetailTip]) {
//            return 0;
//        }
        CGSize size = [tip.orderPriceTip returnSize:kAppAdaptFont(12) maxWidth:kAppAdaptWidth(270)];
        return size.height + kAppAdaptHeight(24);
    }
    return 0;
}

@end
