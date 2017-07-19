//
//  WGOrderExpireGoodView.m
//  WeygoIPhone
//
//  Created by muma on 2017/7/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOrderExpireGoodView.h"
#import "WGHomeFloorContentGoodItem.h"

@implementation WGOrderExpireGoodView
{
    UIView *_contentView;
    JHScrollView *_scrollView;
    WGOrderExpireGood *_expireGood;
}

- (id)initWithFrame:(CGRect)frame expireGood:(WGOrderExpireGood *)expireGood {
    _expireGood = expireGood;
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)loadSubviews {
    [super loadSubviews];
    self.maskColor = kHRGBA(0x000000, 0.4);
    
    JHButton *closeBtn = [[JHButton alloc] initWithFrame:self.bounds];
    [closeBtn addTarget:self action:@selector(touchCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    CGRect frame = CGRectMake(0, 0, kAppAdaptWidth(300), _expireGood.goods.count > 1 ? kAppAdaptHeight(310) : kAppAdaptHeight(220));
    _contentView = [[JHView alloc] initWithFrame:frame radius:kAppAdaptWidth(24)];
    _contentView.backgroundColor = kHRGBA(0xF8FAFA, 0.88);
    _contentView.center = CGPointMake(kDeviceWidth/2, kDeviceHeight/2);
    [self addSubview:_contentView];
    
    JHLabel *titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(10), 0, _contentView.width - kAppAdaptWidth(20), kAppAdaptHeight(72))];
    titleLabel.font = kAppAdaptFontBold(14);
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = WGAppNameLabelColor;
    titleLabel.text = _expireGood.tips;
    [_contentView addSubview:titleLabel];
    
    _scrollView = [[JHScrollView alloc] initWithFrame:CGRectMake(0, titleLabel.maxY + kAppAdaptWidth(4), _contentView.width, _expireGood.goods.count > 1 ? kAppAdaptHeight(160) : kAppAdaptHeight(80))];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [_contentView addSubview:_scrollView];
    [self setGoods:_expireGood.goods];
    
    JHButton *okBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(70), _scrollView.maxY + kAppAdaptHeight(20), kAppAdaptWidth(160), kAppAdaptHeight(30)) difRadius:JHRadiusMake(kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15)) backgroundColor:WGAppBaseColor];
    [okBtn setTitle:kStr(@"Order Delete Good") forState:UIControlStateNormal];
    okBtn.titleLabel.font = kAppAdaptFont(12);
    [okBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(touchDeleteExpireGoodsBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:okBtn];

    if (_expireGood.canChangeTime) {
        CGRect frame = okBtn.frame;
        frame.origin.y = okBtn.maxY + kAppAdaptHeight(16);
        JHButton *noBtn = [[JHButton alloc] initWithFrame:frame difRadius:JHRadiusMake(kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15), kAppAdaptWidth(15)) backgroundColor:WGAppFooterButtonColor];
        [noBtn setTitle:kStr(@"Order Change Deliver Time") forState:UIControlStateNormal];
        noBtn.titleLabel.font = kAppAdaptFont(12);
        [noBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [noBtn addTarget:self action:@selector(touchChangeDeliverTimeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:noBtn];
        _contentView.height = _expireGood.goods.count > 1 ? kAppAdaptHeight(360) : kAppAdaptHeight(270);
    }
}

- (void)setGoods:(NSArray *)goods {
    for (int num = 0; num < goods.count; ++num) {
        WGHomeFloorContentGoodItem *item = goods[num];
        JHImageView *imageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(40), num * kAppAdaptHeight(80), kAppAdaptHeight(60), kAppAdaptHeight(60))];
        [imageView setImageWithURL:[NSURL URLWithString:item.pictureURL] placeholderImage:kShopCartGiftPlaceholderImage options:JHWebImageOptionsRefreshCached];
        [_scrollView addSubview:imageView];
        
//        JHLabel *expiredTimeLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, num * kAppAdaptHeight(80) + kAppAdaptWidth(20), kAppAdaptWidth(110), kAppAdaptHeight(20))];
//        expiredTimeLabel.font = kAppAdaptFontBold(10);
//        expiredTimeLabel.textColor = kWhiteColor;
//        expiredTimeLabel.backgroundColor = kRGB(255, 167, 0);
//        expiredTimeLabel.textAlignment = NSTextAlignmentCenter;
//        expiredTimeLabel.text = item.expiredTime;
//        [_scrollView addSubview:expiredTimeLabel];
        
        JHLabel *titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(imageView.maxX + kAppAdaptWidth(15), imageView.y, _contentView.width - imageView.width - kAppAdaptWidth(80), kAppAdaptHeight(35))];
        titleLabel.font = kAppAdaptFont(13);
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = WGAppTitleColor;
        titleLabel.text = [NSString stringWithFormat:@"%@", item.name];
        [_scrollView addSubview:titleLabel];
        float height = [item.name returnSize:titleLabel.font maxWidth:titleLabel.width].height;
        titleLabel.height = height > kAppAdaptHeight(35) ? kAppAdaptHeight(35) : height;
        
        JHLabel *expireTimeLabel = [[JHLabel alloc] initWithFrame:CGRectMake(imageView.maxX + kAppAdaptWidth(15), imageView.y + kAppAdaptWidth(35), titleLabel.width, kAppAdaptHeight(20))];
        expireTimeLabel.font = kAppAdaptFont(12);
        expireTimeLabel.textColor = kRedColor;
        expireTimeLabel.text = [NSString stringWithFormat:@"%@", item.expiredTime];
        [_scrollView addSubview:expireTimeLabel];
    }
    CGSize size = _scrollView.contentSize;
    size.height = goods.count * kAppAdaptHeight(80);
    _scrollView.contentSize = size;
}

- (void)touchCloseBtn:(JHButton *)sender {
    //[self close];
}

- (void)touchDeleteExpireGoodsBtn:(id)sender {
    if (self.onDeleteExpireGood) {
        self.onDeleteExpireGood();
    }
    //[self close];
}

- (void)touchChangeDeliverTimeBtn:(id)sender {
    if (self.onChangeTime) {
        self.onChangeTime();
    }
    [self close];
}

@end
