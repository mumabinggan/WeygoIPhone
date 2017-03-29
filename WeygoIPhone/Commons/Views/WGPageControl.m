//
//  WGPageControl.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/28.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGPageControl.h"

@implementation WGPageControl

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutDots];
}

- (void)layoutDots {
    for (int i = 0; i < [self.subviews count]; i++) {
        UIView *dot = [self.subviews objectAtIndex:i];
        dot.size = CGSizeMake(kAppAdaptWidth(6), kAppAdaptHeight(6));
        if (i != self.currentPage) {
            dot.layer.borderColor = kWhiteColor.CGColor;
            dot.layer.borderWidth = 1;
        }
        else {
            dot.layer.borderColor = kClearColor.CGColor;
            dot.layer.borderWidth = 0;
        }
    }
}

@end
