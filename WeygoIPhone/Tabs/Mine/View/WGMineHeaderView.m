//
//  WGMineHeaderView.m
//  WeygoIPhone
//
//  Created by muma on 2017/2/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGMineHeaderView.h"

@interface WGMineHeaderView ()
{
    JHImageView *_imageView;
    
    JHImageView *_headImageView;
    JHLabel     *_nameLabel;
    
    JHImageView *_localImageView;
    JHLabel     *_postCodeLabel;
}
@end

@implementation WGMineHeaderView

- (void)loadSubviews {
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake((kDeviceWidth - kAppAdaptWidth(80))/2, kAppAdaptHeight(62), kAppAdaptWidth(80), kAppAdaptHeight(80))];
    _imageView.frame = CGRectMake(0, 0, self.width, self.height);
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
//    _imageView.clipsToBounds = YES;
//    _imageView.layer.cornerRadius = kAppAdaptWidth(40);
//    _imageView.layer.borderWidth = kAppAdaptWidth(3);
//    _imageView.layer.borderColor = kWhiteColor.CGColor;
    _imageView.image = [UIImage imageNamed:@"personCenter_bg"];
    [self addSubview:_imageView];
    
    _headImageView = [[JHImageView alloc] initWithFrame:CGRectMake((kDeviceWidth - kAppAdaptWidth(70))/2, kAppAdaptHeight(70), kAppAdaptWidth(70), kAppAdaptHeight(70))];
    [self addSubview:_headImageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, _imageView.maxY - kAppAdaptHeight(96), kDeviceWidth, kAppAdaptHeight(24))];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = kAppAdaptFont(16);
    _nameLabel.textColor = kWhiteColor;
    [self addSubview:_nameLabel];
    
    _localImageView = [[JHImageView alloc] initWithFrame:CGRectMake((kDeviceWidth - kAppAdaptWidth(24))/2, _nameLabel.maxY + kAppAdaptHeight(13), kAppAdaptWidth(24), kAppAdaptHeight(24))];
    _localImageView.image = [UIImage imageNamed:@"mine_local"];
    [self addSubview:_localImageView];

    _postCodeLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, _localImageView.maxY, kDeviceWidth, kAppAdaptHeight(24))];
    _postCodeLabel.textAlignment = NSTextAlignmentCenter;
    _postCodeLabel.font = kAppAdaptFont(16);
    _postCodeLabel.textColor = kWhiteColor;
    [self addSubview:_postCodeLabel];
}

- (void)showWithData:(WGUser *)user {
    //[_imageView setImageWithURL:[NSURL URLWithString:user.headerUrl] placeholderImage:kMineHeaderPlaceholderImage options:JHWebImageOptionsRefreshCached];
    _headImageView.image = [UIImage imageNamed:user.userAvatar];
    _nameLabel.text = user.name;
    _postCodeLabel.text = user.cap;
}

@end
