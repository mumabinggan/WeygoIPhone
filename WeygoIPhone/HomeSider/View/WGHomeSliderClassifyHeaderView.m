//
//  WGHomeSliderClassifyHeaderView.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/8.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeSliderClassifyHeaderView.h"
#import "WGClassifyItem.h"

@interface WGHomeSliderClassifyHeaderView ()
{
    JHLabel *_titleLabel;
    WGClassifyItem *_data;
}
@end

@implementation WGHomeSliderClassifyHeaderView

- (void)loadSubviews {
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, kAppAdaptWidth(12), kAppAdaptWidth(24), kAppAdaptWidth(24))];
    _imageView.image = [UIImage imageNamed:@""];
    [self.contentView addSubview:_imageView];
    
    _titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(240), kAppAdaptHeight(24))];
    _titleLabel.font = kAppAdaptFont(12);
    _titleLabel.textColor = WGAppNameLabelColor;
    [_imageView addSubview:_titleLabel];
    
    [self addSingleTapGestureRecognizerWithTarget:self action:@selector(touchSelf:)];
}

- (void)touchSelf:(UIGestureRecognizer *)recognizer {
    if (_onApply) {
        self.onApply(_data);
    }
}

- (void)showWithData:(JHObject *)data {
    _data = (WGClassifyItem *)data;
    _titleLabel.text = _data.name;
}

@end
