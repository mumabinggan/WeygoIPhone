//
//  WGSliderHeaderView.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeSliderUserHeaderView.h"
#import "WGUser.h"

@interface WGHomeSliderUserHeaderView ()
{
    JHImageView *_bgImageView;
    JHImageView *_imageView;
    JHLabel *_nameLabel;
    JHImageView *_accessoryView;
    JHButton *_scanButton;
    JHButton *_messageCenterButton;
}
@end

@implementation WGHomeSliderUserHeaderView

- (void)loadSubviews {
    _bgImageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(280), [WGHomeSliderUserHeaderView height])];
    _bgImageView.image = [UIImage imageNamed:@"home_slider_header"];
    [self addSubview:_bgImageView];
    
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(8), kAppAdaptWidth(48), kAppAdaptWidth(48))];
    _imageView.layer.cornerRadius = kAppAdaptWidth(24);
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.borderColor = kWhiteColor.CGColor;
    _imageView.layer.borderWidth = kAppAdaptHeight(3);
    [self addSubview:_imageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_imageView.maxX + kAppAdaptWidth(10), _imageView.y, kAppAdaptWidth(170), _imageView.height)];
    _nameLabel.font = kAppAdaptFont(14);
    _nameLabel.textColor = kWhiteColor;
    [self addSubview:_nameLabel];
    [_nameLabel addSingleTapGestureRecognizerWithTarget:self action:@selector(handleLogin:)];
    
    _accessoryView = [[JHImageView alloc] initWithFrame:CGRectMake(_nameLabel.maxX + kAppAdaptWidth(10), _imageView.y + kAppAdaptHeight(18), kAppAdaptWidth(8), kAppAdaptHeight(14))];
    _accessoryView.image = [UIImage imageNamed:@"home_slider_arr"];
    [self addSubview:_accessoryView];
    float width = kAppAdaptWidth(140);
    NSArray *imageArray = @[@"home_slider_scan", @"home_slider_messageCenter"];
    NSArray *titleArray = @[kStr(@"Slider_Mine_Scan"), kStr(@"Slider_Mine_MessageCenter")];
    for (int num = 0; num < imageArray.count; ++num) {
        JHButton *item = [[JHButton alloc] initWithFrame:CGRectMake(num * width, _imageView.maxY + kAppAdaptHeight(3), width, kAppAdaptHeight(56))];
        [item setImage:[UIImage imageNamed:imageArray[num]] forState:UIControlStateNormal];
        [item setTitle:[NSString stringWithFormat:@"    %@", titleArray[num]] forState:UIControlStateNormal];
        [item setTitleColor:kWhiteColor forState:UIControlStateNormal];
        item.titleLabel.font = kAppAdaptFont(14);
        [item addTarget:self action:@selector(touchItemButton:) forControlEvents:UIControlEventTouchUpInside];
        item.tag = num;
        [self addSubview:item];
    }
}

- (void)handleLogin:(UIGestureRecognizer *)recognizer {
    if (self.onLogin) {
        self.onLogin();
    }
}

- (void)touchItemButton:(JHButton *)sender {
    if (sender.tag == 0) {
        if (self.onScan) {
            self.onScan();
        }
    }
    else {
        if (self.onMessageCenter) {
            self.onMessageCenter();
        }
    }
}

- (void)showWithData:(JHObject *)data {
    _imageView.image = [UIImage imageNamed:[WGApplication sharedApplication].userAvatar];
    if ([WGApplication sharedApplication].isLogined) {
        _nameLabel.text = [NSString stringWithFormat:kStr(@""), [WGApplication sharedApplication].userName];
    }
    else {
        _nameLabel.text = kStr(@"Slider_Mine_UnRegister");
    }
}

+ (CGFloat)height {
    return kAppAdaptHeight(112);
}

@end
