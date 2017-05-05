//
//  LFBorderLabel.m
//  Mars
//
//  Created by Chris on 17/3/15.
//  Copyright (c) 2015 Mars. All rights reserved.
//

#import "WGBorderButton.h"

@implementation WGBorderButton

- (void)loadSubviews {
    [super loadSubviews];
    
    self.backgroundColor = kClearColor;
    self.layer.masksToBounds = YES;
    //self.layer.borderColor = kRedColor.CGColor;
    CGRect frame = self.bounds;
    frame.size.height = self.bounds.size.height;
    frame.origin.y = 0;
    _btn = [[JHButton alloc] initWithFrame:frame];
    _btn.backgroundColor = kClearColor;
    [_btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

- (void)sizeToFit {
    CGRect orgFrame = _btn.frame;
    [_btn sizeToFit];
    CGRect lr = _btn.frame;
    lr.size.height = orgFrame.size.height;
    CGRect r = self.frame;
    r.size.width = lr.size.width + _distanceBetweenTitleAndBorder * 2;
    self.frame = r;
    CGRect frame = self.bounds;
    frame.size.height = self.bounds.size.height;
    frame.origin.y = 0;
    _btn.frame = frame;
    return;
}

- (void)touchBtn:(UIButton*)sender {
    if (sender.selected) {
        self.layer.borderColor = _borderColor.CGColor;
    }
    else {
        self.layer.borderColor = _selectedBorderColor.CGColor;
    }
    sender.selected = !sender.selected;
    self.selected = !self.selected;
    if (self.onTouch) {
        self.onTouch();
    }
}

- (BOOL)isSelected {
    return self.btn.selected;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [_btn setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor = selectedTitleColor;
    [_btn setTitleColor:selectedTitleColor forState:UIControlStateSelected];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    if (!self.btn.selected) {
        self.layer.borderColor = borderColor.CGColor;
    }
}

- (void)setSelectedBorderColor:(UIColor *)selectedBorderColor {
    _selectedBorderColor = selectedBorderColor;
    if (self.btn.selected) {
        self.layer.borderColor = selectedBorderColor.CGColor;
    }
}

- (void)setFont:(UIFont *)font {
    _font = font;
    _btn.titleLabel.font = font;
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
    [_btn setTitle:title forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (selected) {
        _btn.selected = YES;
        self.layer.borderColor = _selectedBorderColor.CGColor;
        _btn.backgroundColor = _selectedBackgroudColor;
    }
    else {
        _btn.selected = NO;
        self.layer.borderColor = _borderColor.CGColor;
        _btn.backgroundColor = self.backgroundColor;
    }
}

@end
