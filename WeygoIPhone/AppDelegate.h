//
//  AppDelegate.h
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WGWelcomeView.h"
#import "WGServiceLoadingView.h"

@class WGNavigationController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    WGNavigationController *_rootVC;
    WGWelcomeView *_welcomeView;
    WGServiceLoadingView * _serviceLoadingView;
}

@property (strong, nonatomic) UIWindow *window;

@end

