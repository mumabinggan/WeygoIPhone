//
//  WGHomeNewsCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGHomeNewsCell.h"
#import "WGScrollAdView.h"
#import "WGNewsItem.h"
#import "WGNews.h"

@interface WGHomeNewsCell ()
{
    JHLabel *_titleLabel;
    WGScrollAdView *_adView;
    WGNews *_data;
}
@end

@implementation WGHomeNewsCell

- (JHLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), 0, 1, kAppAdaptHeight(48))];
        _titleLabel.font = kWGSFUIDisplaySemiBoldAdaptFont(14);
        _titleLabel.textColor = WGAppBaseColor;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)showWithData:(JHObject *)data {
    [super showWithData:data];
    if ([data.toJSONString isEqualToString:_data.toJSONString]) {
        return;
    }
    
    _data = (WGNews *)data;
    
    [_adView removeFromSuperview];
    
    CGRect frame = [self titleLabel].frame;
    frame.size.width = [_data.name returnSize:_titleLabel.font].width;
    [self titleLabel].frame = frame;
    [self titleLabel].text = _data.name;
    
    NSMutableArray *contentMArray = [NSMutableArray array];
    for (WGNewsItem *item in _data.contents) {
        [contentMArray addObject:item.name];
    }
    _adView = [[WGScrollAdView alloc] initWithFrame:CGRectMake(_titleLabel.maxX + kAppAdaptWidth(10), 0, kDeviceWidth - kAppAdaptWidth(10 + 16) - _titleLabel.maxX, kAppAdaptHeight(48)) titleArray:contentMArray];
    __weak id weakSelf = self;
    _adView.onTouch = ^(NSInteger index) {
        [weakSelf handleClick:index];
    };
    [self.contentView addSubview:_adView];
}

- (void)handleClick:(NSInteger)index {
    if (self.onApply) {
        self.onApply(index);
    }
}

@end
