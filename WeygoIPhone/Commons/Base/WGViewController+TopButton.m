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
        [backButton setImage:[UIImage imageNamed:@"to_top_icon"] forState:UIControlStateNormal];
        [backButton setTitle:nil forState:UIControlStateNormal];
        backButton.frame = CGRectMake(kDeviceWidth - 33 - 28, self.view.height - 45-28, 33, 45);
        backButton.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
        backButton.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        backButton.layer.shadowOpacity = 0.8;//阴影透明度，默认0
        backButton.layer.shadowRadius = 4;//阴影半径，默认3
        [backButton addTarget:self action:@selector(touchTopButton:) forControlEvents:UIControlEventTouchUpInside];
        [backButton setTitleColor:[UINavigationBar appearance].tintColor forState:UIControlStateNormal];
        [self.view addSubview:backButton];
        self.topButton = backButton;
    }
    return self.topButton;
}

- (void)showTopButton:(BOOL)show {
    self.topButton = [self createTopButton];
    [self.topButton setHidden:!show];
}

- (void)touchTopButton:(JHButton *)sender {
    [self scrollToTop];
    [self showTopButton:NO];
}

- (void)scrollToTop {
    
}

@end
