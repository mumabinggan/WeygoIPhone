//
//  WGDealFailGoodView.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGDealFailGoodView.h"

@implementation WGDealFailGoodView
{
    UIView *_contentView;
    JHLabel *_desLabel;
}

- (void)loadSubviews {
    [super loadSubviews];
    self.maskColor = kHRGBA(0x000000, 0.4);
    
    JHButton *closeBtn = [[JHButton alloc] initWithFrame:self.bounds];
    [closeBtn addTarget:self action:@selector(touchCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    _contentView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(300), kAppAdaptHeight(370)) radius:kAppAdaptWidth(24)];
    _contentView.backgroundColor = kHRGBA(0xF8FAFA, 0.88);
    _contentView.center = CGPointMake(kDeviceWidth/2, kDeviceHeight/2);
    [self addSubview:_contentView];
    
    JHImageView *bgImageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(120), kAppAdaptHeight(26), kAppAdaptWidth(60), kAppAdaptWidth(60))];
    bgImageView.image = [UIImage imageNamed:@"shopcart_error"];
    [_contentView addSubview:bgImageView];
    
    _desLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(33), kAppAdaptHeight(24) + bgImageView.maxY, kAppAdaptWidth(235), kAppAdaptHeight(120))];
    _desLabel.font = kAppAdaptFont(12);
    _desLabel.numberOfLines = 0;
    _desLabel.textAlignment = NSTextAlignmentCenter;
    _desLabel.textColor = WGAppLightNameLabelColor;
    [_contentView addSubview:_desLabel];
    
    JHButton *editBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(70), kAppAdaptHeight(22) + _desLabel.maxY, kAppAdaptWidth(160), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20), kAppAdaptWidth(20)) backgroundColor:WGAppFooterButtonColor];
    [editBtn setTitle:kStr(@"ShopCart_DeleteFailGood") forState:UIControlStateNormal];
    editBtn.titleLabel.font = kAppAdaptFont(12);
    [editBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(touchEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:editBtn];
    
    CGRect frame = editBtn.frame;
    frame.origin.y += kAppAdaptHeight(55);
    JHLabel *deleteLabel = [[JHLabel alloc] initWithFrame:frame];
    deleteLabel.font = kAppAdaptFont(12);
    deleteLabel.backgroundColor = WGAppFooterButtonColor;
    deleteLabel.layer.cornerRadius = kAppAdaptHeight(20);
    deleteLabel.layer.masksToBounds = YES;
    deleteLabel.text = kStr(@"ShopCart_ChangeFailGood");
    deleteLabel.numberOfLines = 0;
    deleteLabel.textAlignment = NSTextAlignmentCenter;
    deleteLabel.textColor = kWhiteColor;
    deleteLabel.userInteractionEnabled = YES;
    [_contentView addSubview:deleteLabel];
    [deleteLabel addSingleTapGestureRecognizerWithTarget:self action:@selector(touchDelete:)];
}

- (void)setTip:(NSString *)tip {
    _desLabel.text = tip;
}

- (void)touchCloseBtn:(JHButton *)sender {
    [self close];
}

- (void)touchEditBtn:(id)sender {
    if (self.onApply) {
        self.onApply(1);
    }
    [self close];
}

- (void)touchDelete:(UIGestureRecognizer *)recognizer {
    if (self.onApply) {
        self.onApply(2);
    }
    [self close];
}

@end
