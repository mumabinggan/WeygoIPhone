//
//  WGCountdownTimeView.m
//  WeygoIPhone
//
//  Created by muma on 2017/6/19.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCountdownTimeView.h"

@interface WGCountdownTimeView ()
{
    JHImageView *_imageView;
    JHLabel *_dayLabel;
    JHLabel *_hourLabel;
    JHLabel *_minuteLabel;
    JHLabel *_secondLabel;
    
    long long _time;
    NSTimer *_timer;
}

@end

@implementation WGCountdownTimeView

- (void)loadSubviews {
    [super loadSubviews];
    
    _imageView = [[JHImageView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(5), kAppAdaptWidth(8), kAppAdaptWidth(220), kAppAdaptHeight(106))];
    //_imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    _imageView.image = [UIImage imageNamed:([JHLocalizableManager sharedManager].type == JHLocalizableTypeChina) ? @"image_time_cn_bg" : @"image_time_it_bg"];
    [self addSubview:_imageView];
    //_imageView.hidden = YES;
    
    UIFont *font = kAppAdaptFont(30);
    float y = kAppAdaptHeight(24);
    _dayLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(0), y, kAppAdaptWidth(47), kAppAdaptHeight(58))];
    _dayLabel.font = font;
    _dayLabel.textAlignment = NSTextAlignmentCenter;
    _dayLabel.textColor = kWhiteColor;
    [_imageView addSubview:_dayLabel];
    
    _hourLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(58), y, kAppAdaptWidth(47), kAppAdaptHeight(58))];
    _hourLabel.font = font;
    _hourLabel.textColor = kWhiteColor;
    _hourLabel.textAlignment = NSTextAlignmentCenter;
    [_imageView addSubview:_hourLabel];
    
    _minuteLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(116), y, kAppAdaptWidth(47), kAppAdaptHeight(58))];
    _minuteLabel.font = font;
    _minuteLabel.textColor = kWhiteColor;
    _minuteLabel.textAlignment = NSTextAlignmentCenter;
    [_imageView addSubview:_minuteLabel];
    
    _secondLabel = [[JHLabel alloc] initWithFrame:CGRectMake(kAppAdaptWidth(174), y, kAppAdaptWidth(47), kAppAdaptHeight(58))];
    _secondLabel.font = font;
    _secondLabel.textColor = kWhiteColor;
    _secondLabel.textAlignment = NSTextAlignmentCenter;
    [_imageView addSubview:_secondLabel];
    self.hidden = YES;
}

- (void)setTime:(long long)time {
    if (_time == 0) {
        if (time != 0) {
            _time = time;
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTimer:) userInfo:nil repeats:YES];
            long long expireTime = _time - [[NSDate new] timeIntervalSince1970];
            [self setSubview:expireTime];
        }
    }
    else {
        _time = time;
    }
}

- (void)reduceTimer:(NSTimer *)timer {
    long long expireTime = _time - [[NSDate new] timeIntervalSince1970];
    if (expireTime > 0) {
        [self setSubview:expireTime];
        //self.hidden = NO;
        //_imageView.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^() {
            self.layer.opacity = 1.0f;
        }];
    }
    else {
        [UIView animateWithDuration:0.2 animations:^() {
            self.layer.opacity = 0.0f;
        }];
        //self.hidden = YES;
        //_imageView.hidden = YES;
        [_timer invalidate];
        _timer = nil;
        if (self.onHidden) {
            self.onHidden();
        }
    }
}

- (void)setSubview:(long long)expireTime {
    _dayLabel.text = [NSString stringWithFormat:@"%02lld", expireTime / (60 * 60 * 24)];
    _hourLabel.text = [NSString stringWithFormat:@"%02lld", (expireTime / (60 * 60)) % 24];
    _minuteLabel.text = [NSString stringWithFormat:@"%02lld", (expireTime / (60)) % 60];
    _secondLabel.text = [NSString stringWithFormat:@"%02lld", (expireTime) % 60];
}

@end
