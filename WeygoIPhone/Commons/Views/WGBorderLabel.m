//
//  WGBorderLabel.m
//  WeygoIPhone
//
//  Created by muma on 2017/5/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGBorderLabel.h"

@implementation WGBorderLabel

- (void)loadSubviews {
    [super loadSubviews];
    
    self.backgroundColor = kClearColor;
    self.layer.masksToBounds = YES;
    //self.layer.borderColor = kRedColor.CGColor;
    CGRect frame = self.bounds;
    frame.size.height = self.bounds.size.height;
    frame.origin.y = 0;
    _label = [[JHLabel alloc] initWithFrame:frame];
    _label.backgroundColor = kClearColor;
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

- (void)sizeToFit {
    CGRect orgFrame = _label.frame;
    [_label sizeToFit];
    CGRect lr = _label.frame;
    lr.size.height = orgFrame.size.height;
    CGRect r = self.frame;
    r.size.width = lr.size.width + _distanceBetweenTitleAndBorder * 2;
    self.frame = r;
    CGRect frame = self.bounds;
    frame.size.height = self.bounds.size.height;
    frame.origin.y = 0;
    _label.frame = frame;
    return;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _label.textColor = titleColor;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    _label.font = font;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _label.text = title;
}

@end
