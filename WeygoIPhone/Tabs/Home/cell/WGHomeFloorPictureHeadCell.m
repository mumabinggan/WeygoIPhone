//
//  WGHomeFloorPictureHeadCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorPictureHeadCell.h"
#import "WGHomeFloorItem.h"

@interface WGHomeFloorPictureHeadCell ()
{
    WGHomeFloorItem *_item;
    
    JHImageView *_imageView;
    
    JHLabel *_nameLabel;
    JHLabel *_briefInfoLabel;
    JHButton *_moreBtn;
}
@end

@implementation WGHomeFloorPictureHeadCell

- (void)loadSubviews {
    [super loadSubviews];
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self.contentView addSubview:_imageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(26), kDeviceWidth, kAppAdaptHeight(28))];
    _nameLabel.font = kWGOswaldRegularAdaptFont(22);
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = kWhiteColor;
    [self.contentView addSubview:_nameLabel];
    
    _briefInfoLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, _nameLabel.maxY, kDeviceWidth, kAppAdaptHeight(20))];
    _briefInfoLabel.font = kWGOswaldRegularAdaptFont(14);
    _briefInfoLabel.textAlignment = NSTextAlignmentCenter;
    _briefInfoLabel.textColor = kWhiteColor;
    [self.contentView addSubview:_briefInfoLabel];
    
    _moreBtn = [[JHButton alloc] initWithFrame:CGRectMake(0, 0, 100, kAppAdaptHeight(24)) difRadius:JHRadiusMake(kAppAdaptWidth(10), kAppAdaptWidth(10), kAppAdaptWidth(10), kAppAdaptWidth(10)) borderWidth:2.0f borderColor:kWhiteColor];
    _moreBtn.titleLabel.font = kAppAdaptFont(12);
    [_moreBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(touchMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moreBtn];
}

- (void)showWithData:(JHObject *)data {
    [super showWithData:data];
    WGHomeFloorItem *item = (WGHomeFloorItem *)data;
    _item = item;
    
    CGRect frame = _imageView.frame;
    frame.size.height = item.homePictureHeight;
    _imageView.frame = frame;
    
    [_imageView setImageWithURL:[NSURL URLWithString:item.pictureURL] placeholderImage:kHomeFloorPictureHeaderPlaceholderImage options:JHWebImageOptionsRefreshCached];
    
    _nameLabel.text = item.pictureName;
    _briefInfoLabel.text = item.pictureBriefDescription;
    [_moreBtn setTitle:item.pictureBtnName forState:UIControlStateNormal];
    float width = [item.pictureBtnName returnSize:kAppAdaptFontBold(12)].width + 30;
    _moreBtn.width = width;
    _moreBtn.center = CGPointMake(kDeviceWidth/2, _briefInfoLabel.maxY + kAppAdaptHeight(24));
    
    _nameLabel.hidden = [NSString isNullOrEmpty:item.pictureName] ? YES : NO;
    _briefInfoLabel.hidden = [NSString isNullOrEmpty:item.pictureBriefDescription] ? YES : NO;
    _moreBtn.hidden = [NSString isNullOrEmpty:item.pictureBtnName] ? YES : NO;
}

- (void)touchMoreBtn:(UIButton *)sender {
    if (self.onApply) {
        self.onApply(_item);
    }
}

@end
