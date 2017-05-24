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
    [super loadSubviews];
    _bgImageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, kWGSideBarWidth, [WGHomeSliderUserHeaderView height])];
    _bgImageView.image = [UIImage imageNamed:@"home_slider_header"];
    [self addSubview:_bgImageView];
    
    float width = kAppAdaptWidth(140);
    NSArray *imageArray = @[@"home_slider_scan", @"home_slider_messageCenter"];
    NSArray *titleArray = @[kStr(@"Slider_Mine_Scan"), kStr(@"Slider_Mine_MessageCenter")];
    for (int num = 0; num < titleArray.count; ++num) {
        JHButton *item = [[JHButton alloc] initWithFrame:CGRectMake(num * width, 0, width, kAppAdaptHeight(48))];
        [item setImage:[UIImage imageNamed:imageArray[num]] forState:UIControlStateNormal];
        [item setTitle:[NSString stringWithFormat:@"    %@", titleArray[num]] forState:UIControlStateNormal];
        [item setTitleColor:kWhiteColor forState:UIControlStateNormal];
        item.titleLabel.font = kAppAdaptFont(14);
        [item addTarget:self action:@selector(touchItemButton:) forControlEvents:UIControlEventTouchUpInside];
        item.tag = num;
        [self addSubview:item];
    }
    
    float y = kAppAdaptHeight(48 + 18);
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake((kWGSideBarWidth - kAppAdaptWidth(80)) / 2, y, kAppAdaptWidth(80), kAppAdaptWidth(80))];
//    _imageView.layer.cornerRadius = kAppAdaptWidth(24);
//    _imageView.layer.masksToBounds = YES;
//    _imageView.layer.borderColor = kWhiteColor.CGColor;
//    _imageView.layer.borderWidth = kAppAdaptHeight(3);
    _imageView.userInteractionEnabled = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_imageView];
    [_imageView addSingleTapGestureRecognizerWithTarget:self action:@selector(handleLogin:)];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, _imageView.maxY + kAppAdaptHeight(5), kWGSideBarWidth, kAppAdaptHeight(20))];
    _nameLabel.font = kAppAdaptFont(14);
    _nameLabel.textColor = kWhiteColor;
    _nameLabel.userInteractionEnabled = YES;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLabel];
    [_nameLabel addSingleTapGestureRecognizerWithTarget:self action:@selector(handleLogin:)];
    
    _accessoryView = [[JHImageView alloc] initWithFrame:CGRectMake(_nameLabel.maxX + kAppAdaptWidth(10), _imageView.y + kAppAdaptHeight(18), kAppAdaptWidth(8), kAppAdaptHeight(14))];
    _accessoryView.image = [UIImage imageNamed:@"home_slider_arr"];
    [self addSubview:_accessoryView];
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
        _nameLabel.text = [WGApplication sharedApplication].userName;
        _accessoryView.hidden = NO;
        float y = kAppAdaptHeight(48);
        _imageView.frame = CGRectMake(kAppAdaptWidth(16), y, kAppAdaptWidth(48), kAppAdaptWidth(48));
        _nameLabel.frame = CGRectMake(_imageView.maxX + kAppAdaptWidth(10), _imageView.y, kAppAdaptWidth(170), _imageView.height);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _accessoryView.frame = CGRectMake(_nameLabel.maxX + kAppAdaptWidth(10), _imageView.y + kAppAdaptHeight(18), kAppAdaptWidth(8), kAppAdaptHeight(14));
    }
    else {
        _accessoryView.hidden = YES;
        _nameLabel.text = kStr(@"Slider_Mine_UnRegister");
        float y = kAppAdaptHeight(48 + 18);
        _imageView.frame = CGRectMake((kWGSideBarWidth - kAppAdaptWidth(80)) / 2, y, kAppAdaptWidth(80), kAppAdaptWidth(80));
        _nameLabel.frame = CGRectMake(0, _imageView.maxY + kAppAdaptHeight(5), kWGSideBarWidth, kAppAdaptHeight(20));
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    _bgImageView.height = [WGHomeSliderUserHeaderView height];
}

+ (CGFloat)height {
    if ([WGApplication sharedApplication].isLogined) {
        return kAppAdaptHeight(112);
    }
    else {
        return kAppAdaptHeight(200);
    }
}

@end
