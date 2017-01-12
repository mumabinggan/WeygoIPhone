//
//  WGHomeTitleView.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/12.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGHomeTitleView.h"

@interface WGHomeTitleView ()
{
    JHLabel *_titleLabel;
    JHImageView *_imageView;
    
    float space;
}
@end

@implementation WGHomeTitleView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
        space = 6;
        [self addSingleTapGestureRecognizerWithTarget:self action:@selector(touchItem:)];
    }
    return self;
}

- (void)initSubView {
    if (!_titleLabel) {
        _titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _titleLabel.font = kWGSFUIDisplaySemiBoldFont(16);
        _titleLabel.textColor = kWhiteColor;
        [self addSubview:_titleLabel];
    }
    if (!_imageView) {
        _imageView = [[JHImageView alloc] initWithImage:[UIImage imageNamed:@"test"]];
        _imageView.frame = CGRectMake(0, (kAppNavigationBarHeight - _imageView.height) / 2, _imageView.width, _imageView.height);
        [self addSubview:_imageView];
    }
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
    CGSize labelSize = [title returnSize:_titleLabel.font];
    float width;
    float labelX;
    if (labelSize.width + space + _imageView.width >= self.width) {
        width = self.width - _imageView.width - space;
        labelX = 0;
    }
    else {
        width = labelSize.width;
        labelX = (self.width - _imageView.width - space - labelSize.width) / 2;
    }
    _titleLabel.frame = CGRectMake(labelX, 0, width, _titleLabel.height);
    _imageView.frame = CGRectMake(_titleLabel.maxX + space, _imageView.y, _imageView.width, _imageView.height);
}

- (void)touchItem:(id)sender {
    if (self.onTouch) {
        self.onTouch(self);
    }
}

@end
