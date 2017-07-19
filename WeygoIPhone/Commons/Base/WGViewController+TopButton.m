//
//  WGViewController+TopButton.m
//  WeygoIPhone
//
//  Created by muma on 2017/5/24.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGViewController+TopButton.h"
#import <objc/runtime.h>

static const NSString *WGTopButtonKey = @"WGTopButtonKey";

@implementation WGViewController (TopButton)

- (JHButton *)topButton {
    return objc_getAssociatedObject(self, &WGTopButtonKey);
}

- (void)setTopButton:(JHButton *)topButton {
    objc_setAssociatedObject(self, &WGTopButtonKey, topButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JHButton *)createTopButton {
    if (!self.topButton) {
        JHButton *backButton = [JHButton buttonWithType:UIButtonTypeCustom];
        [backButton setBackgroundImage:[UIImage imageNamed:@"to_top_icon"] forState:UIControlStateNormal];
        backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [backButton setTitle:nil forState:UIControlStateNormal];
        backButton.frame = CGRectMake(kDeviceWidth - 36, self.view.height - 80, 36, 40);
        backButton.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
        backButton.layer.shadowOffset = CGSizeMake(2,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        backButton.layer.shadowOpacity = 0.5;//阴影透明度，默认0
        backButton.layer.shadowRadius = 2;//阴影半径，默认3
        [backButton addTarget:self action:@selector(touchTopButton:) forControlEvents:UIControlEventTouchUpInside];
        [backButton setTitleColor:[UINavigationBar appearance].tintColor forState:UIControlStateNormal];
        [self.view addSubview:backButton];
        self.topButton = backButton;
    }
    return self.topButton;
}

- (void)showTopButton:(BOOL)show {
    if (show == !self.topButton.hidden) {
        return;
    }
    self.topButton = [self createTopButton];
    if (!show) {
        [self.topButton setBackgroundImage:[UIImage imageNamed:@"to_top_icon"] forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.25 animations:^() {
        if (show) {
            self.topButton.layer.opacity = 1.0f;
            self.topButton.hidden = NO;
        }
        else {
            self.topButton.layer.opacity = 0.0f;
            self.topButton.hidden = YES;
        }
    }];
    
}

- (void)touchTopButton:(JHButton *)sender {
    [self scrollToTop];
    //[self showTopButton:NO];
}

- (void)scrollToTop {
    //[self.topButton setImage:[UIImage imageNamed:@"to_top_fly_icon"] forState:UIControlStateNormal];
}

@end
