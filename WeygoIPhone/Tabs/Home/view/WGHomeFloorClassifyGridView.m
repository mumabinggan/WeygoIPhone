//
//  WGHomeFloorClassifyGridView.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorClassifyGridView.h"
#import "WGHomeFloorContentClassifyItem.h"

@interface WGHomeFloorClassifyGridView ()
{
    JHImageView *_imageView;
    JHLabel     *_nameLabel;
}
@end

@implementation WGHomeFloorClassifyGridView

- (void)loadSubviews {
    [super loadSubviews];
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, kAppAdaptHeight(83))];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, _imageView.maxY, self.width, kAppAdaptHeight(32))];
    _nameLabel.font = kAppAdaptFont(12);
    _nameLabel.textColor = kRGBA(0, 0, 0, 0.87);
    _nameLabel.numberOfLines = 2;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLabel];
}

- (void)showWithData:(JHObject *)data {
    WGHomeFloorContentClassifyItem *item = (WGHomeFloorContentClassifyItem *)data;
    [_imageView setImageWithURL:[NSURL URLWithString:item.pictureURL] placeholderImage:kHomeCountryPlaceholderImage options:JHWebImageOptionsRefreshCached];
    _nameLabel.text = item.name;
}

@end
