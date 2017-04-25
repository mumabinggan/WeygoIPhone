//
//  WGClassifyFitlerClassifyView.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/23.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyFitlerClassifyView.h"
#import "WGClassifyItem.h"

@interface WGClassifyFitlerClassifyView ()
{
    JHImageView *_imageView;
    JHLabel *_nameLabel;
    WGClassifyItem *_data;
}
@end

@implementation WGClassifyFitlerClassifyView

- (void)loadSubviews {
    [super loadSubviews];
    
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(114), kAppAdaptHeight(114))];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    _imageView.layer.cornerRadius = kAppAdaptWidth(6);
    [self addSubview:_imageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(80), kAppAdaptHeight(24))];
    _nameLabel.center = CGPointMake(_imageView.width/2, _imageView.height/2);
    _nameLabel.font = kAppAdaptFont(12);
    _nameLabel.textColor = kWhiteColor;
    _nameLabel.backgroundColor = WGAppBaseColor;
    _nameLabel.layer.cornerRadius = kAppAdaptHeight(12);
    _nameLabel.layer.masksToBounds = YES;
    _nameLabel.layer.borderColor = kWhiteColor.CGColor;
    _nameLabel.layer.borderWidth = kAppAdaptHeight(2);
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [_imageView addSubview:_nameLabel];
    
    [self addSingleTapGestureRecognizerWithTarget:self action:@selector(handleSingleTap:)];
}

- (void)handleSingleTap:(UIGestureRecognizer *)recognizer {
    DLog(@"---handleSingleTap---");
    [self setSelected:!_selected];
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    _data.isSelected = _selected;
    if (selected) {
        _nameLabel.textColor = kWhiteColor;
        _nameLabel.backgroundColor = WGAppBaseColor;
    }
    else {
        _nameLabel.textColor = WGAppBaseColor;
        _nameLabel.backgroundColor = kWhiteColor;
    }
}

- (void)showWithData:(JHObject *)object {
    _data = (WGClassifyItem *)object;
    _nameLabel.text = _data.name;
    [_imageView setImageWithURL:[NSURL URLWithString:_data.pictureURL] placeholderImage:kHomeClassifyColumnPlaceholderImage options:JHWebImageOptionsRefreshCached];
    [self setSelected:_data.isSelected];
}

@end
