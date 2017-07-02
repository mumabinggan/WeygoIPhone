//
//  WGHomeCarouselFiguresCell.h
//  WeygoIPhone
//
//  Created by muma on 2017/1/13.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "JHTableViewCell.h"
#import "WGScrollImageView.h"
#import "WGCountdownTimeView.h"

@interface WGHomeCarouselFiguresCell : JHTableViewCell
{
    WGScrollImageView *_scrollImageView;
    WGCountdownTimeView *_countDownTimeView;
}

@property (nonatomic, copy) void (^onApply)(NSInteger index);

@property (nonatomic, copy) void (^onRefresh)();

- (void)showWithArray:(NSArray *)array;

+ (CGFloat)heightWithData:(NSArray *)array;

- (void)setCountDownTime:(long long)time;

@end
