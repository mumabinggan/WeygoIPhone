//
//  WGScrollAdView.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/12.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGScrollAdView.h"

@interface WGScrollAdView ()
{
    NSTimer *_timer;
    NSArray *_titleArray;
    
    JHView *_oneAdsView;
    JHView *_twoAdsView;
    
    float _space;
}
@end

@implementation WGScrollAdView

- (id)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray {
    self = [super initWithFrame:frame];
    if (self) {
        _space = kAppAdaptWidth(50);
        _titleArray = titleArray;
        self.clipsToBounds = YES;
        [self initSubView];
        //__weak typeof (self) weakSelf = self;
//        + (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
//        _timer = [NSTimer scheduledTimerWithTimeInterval:0.017 repeats:YES block:^(NSTimer *timer) {
//            [weakSelf handleTimer];
//        }];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.017 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)initSubView {
    float maskWidth = kAppAdaptWidth(80);
    JHImageView *maskImageView = [[JHImageView alloc] initWithFrame:CGRectMake(self.width - maskWidth, 0, maskWidth, self.height)];
    maskImageView.image = [UIImage imageNamed:@""];
    [self addSubview:maskImageView];
    CGRect frame = CGRectMake(self.width, 0, 100, self.height);
    _oneAdsView = [[JHView alloc] initWithFrame:frame];
    _twoAdsView = [[JHView alloc] initWithFrame:frame];
    UIFont *font = kAppAdaptFont(16);
    //UIFont *font = kWGSFUIDisplayMediumAdaptFont(14);
    float adsViewWidth = 0;
    for (int num = 0; num < _titleArray.count; ++num) {
        NSString *title = _titleArray[num];
        CGSize size = [title returnSize:font];
        JHLabel *label = [[JHLabel alloc] initWithFrame:CGRectMake(adsViewWidth, 0, size.width, _oneAdsView.height)];
        label.text = title;
        label.font = font;
        label.tag = num;
        label.userInteractionEnabled = YES;
        [label addSingleTapGestureRecognizerWithTarget:self action:@selector(touchItem:)];
        [_oneAdsView addSubview:label];
        
        JHLabel *copyLabel = [[JHLabel alloc] initWithFrame:label.frame];
        copyLabel.text = label.text;
        copyLabel.font = label.font;
        copyLabel.tag = num;
        copyLabel.userInteractionEnabled = YES;
        [copyLabel addSingleTapGestureRecognizerWithTarget:self action:@selector(touchItem:)];
        [_twoAdsView addSubview:copyLabel];
        
        adsViewWidth += (size.width + _space);
    }
    frame.size.width = adsViewWidth;
    _oneAdsView.frame = frame;
    [self addSubview:_oneAdsView];
    _twoAdsView.frame = frame;
    [self addSubview:_twoAdsView];
}

- (void)handleTimer {
    if (_oneAdsView.maxX <= 0) {
        CGRect frame = _oneAdsView.frame;
        frame.origin.x = self.width;
        _oneAdsView.frame = frame;
    }
    if (_twoAdsView.maxX <= 0) {
        CGRect frame = _twoAdsView.frame;
        frame.origin.x = self.width;
        _twoAdsView.frame = frame;
    }
    if ((NSInteger)_oneAdsView.x == (NSInteger)self.width &&
        (NSInteger)_twoAdsView.x == (NSInteger)self.width) {
        [self setViewFrame:_oneAdsView];
    }
    if (_oneAdsView.x < self.width || ((_twoAdsView.maxX < self.width) && (_oneAdsView.x == self.width))) {
        [self setViewFrame:_oneAdsView];
    }
    if (_twoAdsView.x < self.width || ((_oneAdsView.maxX < self.width) && (_twoAdsView.x == self.width))) {
        [self setViewFrame:_twoAdsView];
    }
}

- (void)setViewFrame:(JHView *)view {
    CGRect frame = view.frame;
    frame.origin.x -= 1.5;
    view.frame = frame;
}

- (void)touchItem:(UIGestureRecognizer *)sender {
    if (self.onTouch) {
        self.onTouch(sender.view.tag);
    }
}

- (void)removeFromSuperview {
    [_timer invalidate];
    _timer = nil;
    [super removeFromSuperview];
}

@end
