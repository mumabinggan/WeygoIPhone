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
    float width = kAppAdaptWidth(128);
    float height = kAppAdaptWidth(64);
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8), kAppAdaptHeight(12), width, height)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(4), 0, kAppAdaptWidth(72), _imageView.height)];
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
