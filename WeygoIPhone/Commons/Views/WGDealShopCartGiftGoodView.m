//
//  WGDealShopCartGiftGoodView.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGDealShopCartGiftGoodView.h"
#import "WGHomeFloorContentGoodItem.h"

@implementation WGDealShopCartGiftGoodView
{
    UIView *_contentView;
    JHScrollView *_scrollView;
}

- (void)loadSubviews {
    [super loadSubviews];
    self.maskColor = kHRGBA(0x000000, 0.4);
    
    JHButton *closeBtn = [[JHButton alloc] initWithFrame:self.bounds];
    [closeBtn addTarget:self action:@selector(touchCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    _contentView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(300), kAppAdaptHeight(350)) radius:kAppAdaptWidth(24)];
    _contentView.backgroundColor = kHRGBA(0xF8FAFA, 0.88);
    _contentView.center = CGPointMake(kDeviceWidth/2, kDeviceHeight/2);
    [self addSubview:_contentView];
    
    JHLabel *titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(16), _contentView.width, kAppAdaptHeight(40))];
    titleLabel.font = kAppAdaptFontBold(14);
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = WGAppNameLabelColor;
    titleLabel.text = kStr(@"ShopCart_GiftGoodThree");
    [_contentView addSubview:titleLabel];
    
    _scrollView = [[JHScrollView alloc] initWithFrame:CGRectMake(0, titleLabel.maxY + kAppAdaptHeight(20), _contentView.width, kAppAdaptHeight(160))];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [_contentView addSubview:_scrollView];
    
    JHButton *okBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(70), _scrollView.maxY + kAppAdaptHeight(20), kAppAdaptWidth(160), kAppAdaptHeight(30)) difRadius:JHRadiusMake(kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15)) backgroundColor:WGAppBaseColor];
    [okBtn setTitle:kStr(@"ShopCart_GiftGoodOne") forState:UIControlStateNormal];
    okBtn.titleLabel.font = kAppAdaptFont(12);
    [okBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(touchOkBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:okBtn];
    
    CGRect frame = okBtn.frame;
    frame.origin.y = okBtn.maxY + kAppAdaptHeight(16);
    JHButton *noBtn = [[JHButton alloc] initWithFrame:frame difRadius:JHRadiusMake(kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15)) backgroundColor:WGAppFooterButtonColor];
    [noBtn setTitle:kStr(@"ShopCart_GiftGoodTwo") forState:UIControlStateNormal];
    noBtn.titleLabel.font = kAppAdaptFont(12);
    [noBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [noBtn addTarget:self action:@selector(touchNoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:noBtn];
}

- (void)setGoods:(NSArray *)goods {
    for (int num = 0; num < goods.count; ++num) {
        WGHomeFloorContentGoodItem *item = goods[num];
        JHImageView *imageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(30), num * kAppAdaptHeight(80), kAppAdaptHeight(60), kAppAdaptHeight(60))];
        [imageView setImageWithURL:[NSURL URLWithString:item.pictureURL] placeholderImage:kShopCartGiftPlaceholderImage options:JHWebImageOptionsRefreshCached];
        [_scrollView addSubview:imageView];
        
        JHLabel *titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(imageView.maxX + kAppAdaptWidth(10), imageView.y, _contentView.width - imageView.width - kAppAdaptWidth(70), kAppAdaptHeight(60))];
        titleLabel.font = kAppAdaptFont(12);
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = WGAppBaseColor;
        titleLabel.text = [NSString stringWithFormat:@"%@\n%@", item.name, item.briefDescription];
        [_scrollView addSubview:titleLabel];
    }
    CGSize size = _scrollView.contentSize;
    size.height = goods.count * kAppAdaptHeight(80);
    _scrollView.contentSize = size;
}

- (void)touchCloseBtn:(JHButton *)sender {
    [self close];
}

- (void)touchOkBtn:(id)sender {
    if (self.onApply) {
        self.onApply(1);
    }
    [self close];
}

- (void)touchNoBtn:(id)sender {
    if (self.onApply) {
        self.onApply(0);
    }
    [self close];
}

@end
