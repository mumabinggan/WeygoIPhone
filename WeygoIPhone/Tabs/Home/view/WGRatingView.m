//
//  WGRatingView.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/4.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGRatingView.h"

@interface WGRatingView ()
{
    NSArray *_imageArray;
}
@end

@implementation WGRatingView

- (void)loadSubviews {
    [super loadSubviews];
    
    NSMutableArray *imageMArray = [[NSMutableArray alloc] init];
    for (int num = 0; num < 5; ++num) {
        JHImageView *imageView = [[JHImageView alloc] initWithFrame:CGRectMake(num * kAppAdaptWidth(21), 0, kAppAdaptWidth(14), kAppAdaptWidth(14))];
        [self addSubview:imageView];
        [imageMArray addObject:imageView];
    }
    _imageArray = imageMArray;
}

- (void)showWithData:(float)rating {
    int minInt = floor(rating);
    int maxInt = ceil(rating);
    for (int num = 0; num < _imageArray.count; ++num) {
        JHImageView *imageView = _imageArray[num];
        if (num < minInt) {
            //good
            imageView.image = [UIImage imageNamed:@""];
        }
        else if (num >= maxInt) {
            //bad
            imageView.image = [UIImage imageNamed:@""];
        }
        else {
            //both
            imageView.image = [UIImage imageNamed:@""];
        }
    }
}

@end
