//
//  WGHomeFloorCountryItemView.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorCountryItemView.h"
#import "WGHomeFloorContentCountryItem.h"

@interface WGHomeFloorCountryItemView ()
{
    JHImageView *_imageView;
    JHLabel     *_nameLabel;
}
@end

@implementation WGHomeFloorCountryItemView

- (void)loadSubviews {
    [super loadSubviews];
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), 0, kAppAdaptWidth(50), kAppAdaptHeight(50))];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self addSubview:_imageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, _imageView.maxY + kAppAdaptHeight(10), self.width, kAppAdaptHeight(32))];
    _nameLabel.font = kAppAdaptFont(12);
    _nameLabel.textColor = kRGBA(0, 0, 0, 0.87);
    _nameLabel.numberOfLines = 2;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLabel];
}

- (void)showWithData:(JHObject *)data {
    WGHomeFloorContentCountryItem *item = (WGHomeFloorContentCountryItem *)data;
    [_imageView setImageWithURL:[NSURL URLWithString:item.pictureURL] placeholderImage:kHomeCountryPlaceholderImage options:JHWebImageOptionsRefreshCached];
    _nameLabel.text = item.name;
}

@end
