//
//  WGSliderTopicItemView.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/8.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGSliderTopicItemView.h"
#import "WGTopicItem.h"

@interface WGSliderTopicItemView ()
{
    JHImageView *_imageView;
    JHLabel *_nameLabel;
    WGTopicItem *_item;
}
@end

@implementation WGSliderTopicItemView

- (void)loadSubviews {
    [super loadSubviews];
    
    self.backgroundColor = kRGB(247, 249, 250);
    self.backgroundColor = kHRGB(0xf8fafa);
    float width = kAppAdaptWidth(30);
    float height = kAppAdaptWidth(30);
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(13), kAppAdaptHeight(17), width, height)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_imageView.maxX + kAppAdaptWidth(10), 0, kAppAdaptWidth(72), self.height)];
    _nameLabel.font = kAppAdaptFont(12);
    _nameLabel.numberOfLines = 0;
    _nameLabel.textColor = kRGBA(0, 0, 0, 0.87);
    [self addSubview:_nameLabel];
    
    [self addSingleTapGestureRecognizerWithTarget:self action:@selector(touchSelf:)];
}

- (void)touchSelf:(UIGestureRecognizer *)recognizer {
    if (self.onApply && _item) {
        self.onApply(_item);
    }
}

- (void)showWithData:(JHObject *)data {
    _item = (WGTopicItem *)data;
    NSString *url = _item.pictureURL;
    NSString *name = _item.name;
    UIImage *placeholderImage = [UIImage imageNamed:@""];
    [_imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage options:JHWebImageOptionsRefreshCached];
    
    _nameLabel.text = name;
}

@end
