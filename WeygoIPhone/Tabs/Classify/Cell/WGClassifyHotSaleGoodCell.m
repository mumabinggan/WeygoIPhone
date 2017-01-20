//
//  WGClassifyHotSaleGoodCell.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyHotSaleGoodCell.h"
#import "WGClassifyHotGoodItem.h"

@interface WGClassifyHotSaleGoodCell ()
{
    JHImageView     *_imageView;
    JHImageView     *_hotNumberImageView;
    JHLabel         *_nameLabel;
    JHLabel         *_currentPriceLabel;
    JHLabel         *_reducePriceLabel;
}
@end

@implementation WGClassifyHotSaleGoodCell

- (void)loadSubviews {
    [super loadSubviews];
    
    JHView *contentView = [[JHView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8), 0, kAppAdaptWidth(199), kAppAdaptHeight(204)) radius:kAppAdaptWidth(6)];
    contentView.clipsToBounds = YES;
    [self.contentView addSubview:contentView];
    
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(199), kAppAdaptHeight(128))];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [contentView addSubview:_imageView];
    
    _hotNumberImageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(96), kAppAdaptWidth(96))];
    _hotNumberImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_imageView addSubview:_hotNumberImageView];
    
    _nameLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, _imageView.maxY + kAppAdaptHeight(12), _imageView.width, kAppAdaptHeight(32))];
    _nameLabel.font = kAppAdaptFontBold(14);
    _nameLabel.textColor = kRGBA(0, 0, 0, 0.87);
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.numberOfLines = 0;
    [contentView addSubview:_nameLabel];
    
    _reducePriceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _nameLabel.maxY + kAppAdaptHeight(10), _nameLabel.width, kAppAdaptHeight(20))];
    _reducePriceLabel.font = kAppAdaptFont(15);
    _reducePriceLabel.textColor = kRGBA(0, 0, 0, 0.87);
    _reducePriceLabel.textAlignment = NSTextAlignmentRight;
    [contentView addSubview:_reducePriceLabel];
    
    _currentPriceLabel = [[JHLabel alloc] initWithFrame:CGRectMake(_nameLabel.x, _nameLabel.maxY + kAppAdaptHeight(10), _nameLabel.width, kAppAdaptHeight(20))];
    _currentPriceLabel.font = kAppAdaptFont(16);
    _currentPriceLabel.textColor = WGAppBaseColor;
    _currentPriceLabel.textAlignment = NSTextAlignmentLeft;
    [contentView addSubview:_currentPriceLabel];
}

- (void)showWithData:(WGClassifyHotGoodItem *)object {
    [_imageView setImageWithURL:[NSURL URLWithString:object.pictureURL] placeholderImage:kHomeGoodColumnPlaceholderImage options:JHWebImageOptionsRefreshCached];
    _hotNumberImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hotsale_icon_%ld", object.number]];
    _nameLabel.text = object.name;
    _currentPriceLabel.text = [NSString stringWithFormat:kStr(@"Price With Unit"), object.currentPrice];
    _reducePriceLabel.attributedText = [[NSString stringWithFormat:kStr(@"Price With Unit"), object.reducePrice] addMidline];
}

@end