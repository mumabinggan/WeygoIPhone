//
//  WGHomeTopicView.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/3.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeTopicItemView.h"
#import "WGTopicItem.h"

@interface WGHomeTopicItemView ()
{
    JHImageView *_imageView;
    JHLabel *_nameLabel;
    WGTopicItem *_item;
}
@end

@implementation WGHomeTopicItemView

- (void)loadSubviews {
    [super loadSubviews];
    
    self.backgroundColor = kRGB(247, 249, 250);
    float totalWidth = self.width;
    float width = kAppAdaptWidth(64);
    float height = kAppAdaptWidth(64);
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake((totalWidth - width) / 2, 0, width, height)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, _imageView.maxY, totalWidth, kAppAdaptHeight(32))];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = kAppAdaptFont(12);
    _nameLabel.numberOfLines = 2;
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
