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
    JHImageView *_imageView;
    //JHButton *_radiusBtn;
}
@end

@implementation WGHomeFloorPictureHeadCell

- (void)loadSubviews {
    [super loadSubviews];
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    [self.contentView addSubview:_imageView];
    
    //_radiusLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
}

//- (JHButton *)radiusButton {
//    if (!_radiusBtn) {
//        _radiusBtn = [JHButton alloc] initWithFrame:<#(CGRect)#> difRadius:<#(JHRadius)#> borderWidth:<#(CGFloat)#> borderColor:<#(UIColor *)#>
//    }
//    return _radiusBtn;
//}

- (void)showWithData:(JHObject *)data {
    [super showWithData:data];
    WGHomeFloorItem *item = (WGHomeFloorItem *)data;
    CGRect frame = _imageView.frame;
    frame.size.height = item.homePictureHeight;
    _imageView.frame = frame;
    
    [_imageView setImageWithURL:[NSURL URLWithString:item.pictureURL] placeholderImage:kHomeFloorPictureHeaderPlaceholderImage options:JHWebImageOptionsRefreshCached];
}

@end
