//
//  AppDelegate+Welcome.h
//  WeygoIPhone
//
//  Created by muma on 2017/5/6.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Welcome)

- (void)showWelcomeView;

/// Lacunch view is a default loading view, waiting base info response
- (void)showLaunchView;

- (void)welcomeApplicationDidBecomeActive:(UIApplication *)application;

- (void)welcomeApplicationWillResignActive:(UIApplication *)application;

@end
