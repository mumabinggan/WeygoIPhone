//
//  AppDelegate+UI.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "AppDelegate+UI.h"
#import "WGMainViewController.h"
#import "WGNavigationController.h"

@implementation AppDelegate (UI)

- (void)launchUIApplicatioin:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    
    //set NavigationController
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _rootVC = [[WGNavigationController alloc] init];
    self.window.rootViewController = _rootVC;
    [self.window makeKeyAndVisible];
    
    [self initAppearance];
    
    [self loadRootViewController:application withOptions:launchOptions];
}

- (void)loadRootViewController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    //add MainViewController
    WGMainViewController *mainVC = [[WGMainViewController alloc] init];
    [_rootVC setViewControllers:@[mainVC] animated:NO];
}

- (void)initAppearance {
    [UINavigationBar appearance].barTintColor = WGAppBaseColor;
    //[[UINavigationBar appearance] setTintColor:kRedColor];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar-white"] forBarMetrics:UIBarMetricsDefault];
    //[[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"nav-shadowImage"]];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:kWhiteColor, NSFontAttributeName:kWGOswaldRegularFont(18)}];
}

@end
