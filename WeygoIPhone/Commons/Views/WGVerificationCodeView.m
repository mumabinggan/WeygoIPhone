//
//  WGVerificationCodeView.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGVerificationCodeView.h"

const static int kVerficationMaxSec = 60;

@interface WGVerificationCodeView ()
{
    NSTimer *_timer;
    int _currentSec;
    
    JHButton *_button;
}
@end

@implementation WGVerificationCodeView

- (void)loadSubviews {
    float radius = self.height/2;
    _button = [[JHButton alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) difRadius:JHRadiusMake(radius, radius, radius, radius) borderWidth:kAppAdaptWidth(1) borderColor:WGAppBlueButtonColor backgroundColor:kWhiteColor];
    [_button setTitle:kStr(@"ForgetPW_Get_Code") forState:UIControlStateNormal];
    [_button setTitleColor:WGAppBlueButtonColor forState:UIControlStateNormal];
    _button.titleLabel.font = kAppAdaptFont(12);
    [_button addTarget:self action:@selector(touchVerificationCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
}

- (void)touchVerificationCodeBtn:(JHButton *)sender {
    [self closeTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setTimerLabel:) userInfo:nil repeats:YES];
    [_button setTitle:[NSString stringWithFormat:@"%ds", kVerficationMaxSec - _currentSec] forState:UIControlStateNormal];
    sender.enabled = NO;
    if (self.onApply) {
        self.onApply();
    }
}

- (void)setTimerLabel:(NSTimer *)timer {
    _currentSec++;
    if (_currentSec == kVerficationMaxSec) {
        [_button setTitle:kStr(@"ForgetPW_Get_Code") forState:UIControlStateNormal];
        [self closeTimer];
        _currentSec = 0;
        _button.enabled = YES;
    }
    else {
        [_button setTitle:[NSString stringWithFormat:@"%ds", kVerficationMaxSec - _currentSec] forState:UIControlStateNormal];
    }
}

- (void)closeTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)dealloc {
    [self closeTimer];
}

@end
