//
//  WGTabViewController+Slider.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGTabViewController+Slider.h"
#import <objc/runtime.h>
#import "WGApplication+Controller.h"

static const NSString *WGSliderButtonKey = @"WGSliderButtonKey";

@implementation WGTabViewController (Slider)

- (UIBarButtonItem *)leftItem {
    return objc_getAssociatedObject(self, &WGSliderButtonKey);
}

- (void)setLeftItem:(UIBarButtonItem *)leftItem {
    objc_setAssociatedObject(self, &WGSliderButtonKey, leftItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIBarButtonItem *)createSliderItem {
    if (!self.leftItem) {
        JHButton *backButton = [JHButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"mine_slider_white"] forState:UIControlStateNormal];
        [backButton setTitle:nil forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(touchSliderButton:) forControlEvents:UIControlEventTouchUpInside];
        [backButton setTitleColor:[UINavigationBar appearance].tintColor forState:UIControlStateNormal];
        [backButton sizeToFit];
        CGRect r = backButton.frame;
        r.size.height = 44;
        r.size.width += 3;
        backButton.frame = r;
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        self.leftItem =  [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return self.leftItem;
}

- (void)touchSliderButton:(JHButton *)sender {
    [[WGApplication sharedApplication] openSideBarViewController];
    return;
    if ([WGApplication sharedApplication].isLogined) {
        [[WGApplication sharedApplication] openSideBarViewController];
    }
    else {
        _loginType = WGLoginTypeOpenSlider;
        [self openLoginViewController];
    }
}

- (void)handleLoginSuccess:(id)customData {
    [super handleLoginSuccess:customData];
    if (_loginType == WGLoginTypeOpenSlider) {
        _loginType = WGLoginTypeNormal;
        [[WGApplication sharedApplication] openSideBarViewController];
    }
}

@end
