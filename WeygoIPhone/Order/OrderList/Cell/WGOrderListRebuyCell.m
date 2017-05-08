//
//  WGOrderListRebuyCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderListRebuyCell.h"
#import "WGOrderListItem.h"

@interface WGOrderListRebuyCell ()
{
    WGOrderListItem *_data;
    JHButton *_rebuyBtn;
}
@end

@implementation WGOrderListRebuyCell

- (void)loadSubviews {
    _rebuyBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(108), kAppAdaptHeight(12), kAppAdaptWidth(160), kAppAdaptHeight(32)) difRadius:JHRadiusMake(kAppAdaptHeight(16), kAppAdaptHeight(16), kAppAdaptHeight(16), kAppAdaptHeight(16)) backgroundColor:WGAppBlueButtonColor];
    [_rebuyBtn addTarget:self action:@selector(touchRebuyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_rebuyBtn setTitle:kStr(@"Order Rebuy") forState:UIControlStateNormal];
    [_rebuyBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    _rebuyBtn.titleLabel.font = kAppAdaptFont(12);
    [self.contentView addSubview:_rebuyBtn];
    
    JHView *lineView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
    lineView.backgroundColor = WGAppSeparateLineColor;
    [self.contentView addSubview:lineView];
}

- (void)touchRebuyBtn:(JHButton *)sender {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGPoint point = [self convertPoint:CGPointMake(_rebuyBtn.x + _rebuyBtn.width/2, _rebuyBtn.y) toView:window];
    if (self.onApply) {
        self.onApply(_data, point);
    }
}

- (void)showWithData:(JHObject *)data {
    _data = (WGOrderListItem *)data;
}

@end
