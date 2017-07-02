//
//  WGHomeFloorPictureHeadCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeFloorPictureHeadCell.h"
#import "WGHomeFloorItem.h"
#import "WGCountdownTimeView.h"

@interface WGHomeFloorPictureHeadCell ()
{
    WGHomeFloorItem *_item;
    
    JHImageView *_imageView;
    
    WGCountdownTimeView *_countDownTimeView;
    
    JHLabel *_nameLabel;
    JHLabel *_briefInfoLabel;
    UIButton *_moreBtn;
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
    
    _moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, kAppAdaptHeight(24))];
    _moreBtn.titleLabel.font = kAppAdaptFont(12);
    _moreBtn.layer.cornerRadius = kAppAdaptWidth(12);
    _moreBtn.layer.borderColor = kWhiteColor.CGColor;
    _moreBtn.layer.borderWidth = 2;
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
    
    [self setCountDownTime:item.snappedUpExpiredTime];
}

- (void)setCountDownTime:(long long)time {
    if (!_countDownTimeView || time != 0) {
        _countDownTimeView = [[WGCountdownTimeView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(10), kAppAdaptHeight(10), kAppAdaptWidth(200), kAppAdaptWidth(107))];
        WeakSelf;
        _countDownTimeView.onHidden = ^() {
            [weakSelf handleRefresh];
        };
        [self.contentView addSubview:_countDownTimeView];
    }
    _countDownTimeView.hidden = (time == 0);
    [_countDownTimeView setTime:time];
}

- (void)handleRefresh {
    if (self.onRefresh) {
        self.onRefresh();
    }
}

- (void)touchMoreBtn:(UIButton *)sender {
    if (self.onApply) {
        self.onApply(_item);
    }
}

@end
