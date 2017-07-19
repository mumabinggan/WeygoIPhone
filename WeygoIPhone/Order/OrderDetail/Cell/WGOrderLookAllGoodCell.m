//
//  WGOrderLookAllGoodCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderLookAllGoodCell.h"

@implementation WGOrderLookAllGoodCell

- (void)loadSubviews {
    JHButton *moreBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(108), kAppAdaptHeight(8), kDeviceWidth - kAppAdaptWidth(160), kAppAdaptHeight(23)) difRadius:JHRadiusMake(kAppAdaptHeight(11.5), kAppAdaptHeight(11.5), kAppAdaptHeight(11.5), kAppAdaptHeight(11.5)) backgroundColor:WGAppBlueButtonColor];
    [moreBtn addTarget:self action:@selector(touchMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setTitle:kStr(@"Order Detail Load More") forState:UIControlStateNormal];
    [moreBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    moreBtn.titleLabel.font = kAppAdaptFont(12);
    [self.contentView addSubview:moreBtn];
}

- (void)touchMoreBtn:(JHButton *)sender {
    if (self.onApply) {
        self.onApply();
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    return kAppAdaptHeight(40);
}

@end
