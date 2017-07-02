//
//  WGOverHeightGoodCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/6/25.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGOverHeightGoodCell.h"
#import "WGGoodAddView.h"
#import "WGOverHeightGoodItem.h"

@interface WGOverHeightGoodCell ()
{
    JHImageView     *_imageView;
    JHLabel         *_nameLabel;
    JHLabel         *_briefDescribeLabel;
    
    WGGoodAddView *_addView;
    
    WGOverHeightGoodItem *_data;
}
@end

@implementation WGOverHeightGoodCell

- (void)loadSubviews {
    float marginLeft = kAppAdaptWidth(8);
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(marginLeft, 0, kAppAdaptWidth(110), kAppAdaptHeight(110))];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self.contentView addSubview:_imageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_imageView.maxX, kAppAdaptHeight(28), kAppAdaptWidth(183), kAppAdaptHeight(30))];
    _nameLabel.font = kAppAdaptFontBold(12);
    _nameLabel.textColor = kRGBA(0, 0, 0, 0.87);
    [self.contentView addSubview:_nameLabel];
    
    _briefDescribeLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _nameLabel.maxY, _nameLabel.width, kAppAdaptHeight(17+14*2))];
    _briefDescribeLabel.font = kAppAdaptFont(12);
    _briefDescribeLabel.textColor = kRGBA(0, 0, 0, 0.54);
    [self.contentView addSubview:_briefDescribeLabel];
    
    _addView = [[WGGoodAddView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(96) + _nameLabel.x, kAppAdaptHeight(65), kAppAdaptWidth(80), kAppAdaptHeight(24))];
    _addView.fromType = WGGoodAddViewFromCart;
    WeakSelf;
    _addView.onAdd = ^(NSInteger count) {
        [weakSelf handleAdd];
    };
    _addView.onSub = ^(NSInteger count) {
        [weakSelf handleSub];
    };
    [self.contentView addSubview:_addView];
}

- (void)showWithData:(JHObject *)data {
    _data = (WGOverHeightGoodItem *)data;
    [_imageView setImageWithURL:[NSURL URLWithString:_data.pictureURL] placeholderImage:kHomeGoodListPlaceholderImage options:JHWebImageOptionsRefreshCached];
    _nameLabel.text = _data.name;
    _briefDescribeLabel.text = _data.briefDescription;
    _addView.count = _data.goodCount;
}

- (void)handleAdd {
    _data.goodCount++;
    if (self.onAdd) {
        self.onAdd(_data);
    }
}

- (void)handleSub {
    _data.goodCount--;
    if (self.onSub) {
        self.onSub(_data);
    }
}

+ (CGFloat)heightWithData:(JHObject *)data {
    return kAppAdaptHeight(120);
}

@end
