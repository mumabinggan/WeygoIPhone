//
//  WGOrderListRebuyCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderListRebuyCell.h"

@implementation WGOrderListRebuyCell

- (void)loadSubviews {
    JHButton *rebuyBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(108), kAppAdaptHeight(12), kAppAdaptWidth(160), kAppAdaptHeight(32)) difRadius:JHRadiusMake(kAppAdaptHeight(16), kAppAdaptHeight(16), kAppAdaptHeight(16), kAppAdaptHeight(16)) backgroundColor:WGAppBlueButtonColor];
    [rebuyBtn addTarget:self action:@selector(touchRebuyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [rebuyBtn setTitle:kStr(@"Order Rebuy") forState:UIControlStateNormal];
    [rebuyBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    rebuyBtn.titleLabel.font = kAppAdaptFont(12);
    [self.contentView addSubview:rebuyBtn];
    
    JHView *lineView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
    lineView.backgroundColor = WGAppSeparateLineColor;
    [self.contentView addSubview:lineView];
}

- (void)touchRebuyBtn:(JHButton *)sender {
    if (self.onApply) {
        self.onApply();
    }
}

@end
