//
//  WGHomeFloorClassifyColumnView.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorClassifyColumnView.h"
#import "WGHomeFloorContentItem.h"

@interface WGHomeFloorClassifyColumnView ()
{
    JHImageView *_imageView;
    JHLabel     *_nameLabel;
}
@end

@implementation WGHomeFloorClassifyColumnView

- (void)loadSubviews {
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(114), kAppAdaptHeight(114))];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    _imageView.layer.cornerRadius = kAppAdaptWidth(6);
    [self addSubview:_imageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(80), kAppAdaptHeight(24))];
    _nameLabel.center = CGPointMake(_imageView.width/2, _imageView.height/2);
    _nameLabel.font = kWGOswaldRegularFont(12);
    _nameLabel.textColor = kWhiteColor;
    _nameLabel.backgroundColor = WGAppBaseColor;
    _nameLabel.layer.cornerRadius = kAppAdaptHeight(12);
    _nameLabel.layer.masksToBounds = YES;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLabel];
}

- (void)showWithData:(JHObject *)data {
    WGHomeFloorContentItem *item = (WGHomeFloorContentItem *)data;
    [_imageView setImageWithURL:[NSURL URLWithString:item.pictureURL] placeholderImage:kHomeClassifyColumnPlaceholderImage options:JHWebImageOptionsRefreshCached];
    _nameLabel.text = item.name;
}

@end
