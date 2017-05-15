//
//  WGImageClassifyCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGImageClassifyCell.h"
#import "WGClassifyItem.h"

@interface WGImageClassifyCell ()
{
    JHImageView *_imageView;
    JHLabel *_nameLabel;
}
@end

@implementation WGImageClassifyCell

- (void)loadSubviews {
    [super loadSubviews];
    self.contentView.backgroundColor = kWhiteColor;
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(2), kAppAdaptWidth(160), kAppAdaptHeight(96))];
    _imageView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:_imageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:_imageView.bounds];
    _nameLabel.font = kAppAdaptFont(14);
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = kWhiteColor;
    [_imageView addSubview:_nameLabel];
}

- (void)showWithData:(JHObject *)data {
    [super showWithData:data];
    WGClassifyItem *item = (WGClassifyItem *)data;
    [_imageView setImageWithURL:[NSURL URLWithString:item.pictureURL] placeholderImage:kHomeCarouselPictureHeaderPlaceholderImage options:JHWebImageOptionsRefreshCached];
    _nameLabel.text = item.name;
}

@end
