//
//  AppDelegate+Welcome.m
//  WeygoIPhone
//
//  Created by muma on 2017/5/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "AppDelegate+Welcome.h"

@implementation AppDelegate (Welcome)

- (void)showWelcomeView {
    BOOL firstLaunched = [@"yes" isEqualToString:[[JHLocalSettings sharedSettings] getSettingsForKey:[NSString stringWithFormat:@"FIRST_LAUNCHED_%@", kAppVersion]]];
    
    if(!firstLaunched){
        _welcomeView = [[WGWelcomeView alloc] initWithFrame:self.window.bounds];
        __weak id weakSelf = self;
        _welcomeView.onCompletion = ^(){
            [weakSelf handleWelcomeCompletion];
        };
        [self.window addSubview:_welcomeView];
    }
    else{
        //[[LFAdvertisementHandle instance] show];
    }
}

- (void) handleWelcomeCompletion {
    if(_welcomeView){
        [UIView animateWithDuration:0.35 animations:^{
            _welcomeView.layer.opacity = 0.1;
        } completion:^(BOOL finished) {
            [_welcomeView removeFromSuperview];
            _welcomeView = nil;
        }];
        [[JHLocalSettings sharedSettings] setSettings:@"yes" forKey:[NSString stringWithFormat:@"FIRST_LAUNCHED_%@", kAppVersion]];
        //[[LFAdvertisementHandle instance] cheakTabBar];
    }
}

- (void)startWelcomeViewAnimations {
    if (_welcomeView) {
        [_welcomeView startAnimation];
    }
}

- (void)stopWelcomeViewAnimations {
    if (_welcomeView) {
        [_welcomeView stopAnimation];
    }
}

- (void) showLaunchView {
    typeof(self) weakSelf = self;
    _serviceLoadingView = [[WGServiceLoadingView alloc] initWithFrame:self.window.bounds];
    [self.window addSubview:_serviceLoadingView];
    _serviceLoadingView.stopView = ^{
        [weakSelf stopServiceView];
    };
}

-(void)stopServiceView{
    _serviceLoadingView = nil;
    //[[LFAdvertisementHandle instance] delayDismissImageView];
}

- (void)startLaunchViewAnimatioins {
    if (_serviceLoadingView) {
        [_serviceLoadingView startAnimation];
    }
}

- (void)stopLaunchViewAnimations {
    if (_serviceLoadingView) {
        [_serviceLoadingView stopAnimation];
    }
}

- (void)welcomeApplicationDidBecomeActive:(UIApplication *)application {
    [self startWelcomeViewAnimations];
    [self startLaunchViewAnimatioins];
}

- (void)welcomeApplicationWillResignActive:(UIApplication *)application {
    [self stopWelcomeViewAnimations];
    [self stopLaunchViewAnimations];
}

@end
