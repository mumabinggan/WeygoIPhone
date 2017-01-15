//
//  WGHomeFloorClassifyListItemCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/14.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorClassifyListItemCell.h"
#import "WGHomeFloorContentItem.h"

@interface WGHomeFloorClassifyListItemCell ()
{
    JHImageView *_imageView;
    JHLabel     *_nameLabel;
}
@end

@implementation WGHomeFloorClassifyListItemCell

- (void)loadSubviews {
    float marginLeft = kAppAdaptWidth(8);
    float marginTop = kAppAdaptWidth(8);
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(marginLeft, marginTop, kDeviceWidth - kAppAdaptWidth(16), kAppAdaptHeight(176))];
    //_imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.clipsToBounds = YES;
    _imageView.layer.cornerRadius = kAppAdaptWidth(6);
    [self addSubview:_imageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:_imageView.bounds];
    _nameLabel.font = kWGOswaldRegularFont(22);
    _nameLabel.textColor = kWhiteColor;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLabel];
}

- (void)showWithData:(JHObject *)data {
    WGHomeFloorContentItem *item = (WGHomeFloorContentItem *)data;
    [_imageView setImageWithURL:[NSURL URLWithString:item.pictureURL] placeholderImage:kHomeClassifyListPlaceholderImage options:JHWebImageOptionsRefreshCached];
    _nameLabel.text = item.name;
}

@end
