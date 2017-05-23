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
#import "AppDelegate+Welcome.h"

@implementation AppDelegate (UI)

- (void)launchUIApplicatioin:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    
    //[[JHNetworkManager sharedManager] networkingGetMethod:nil urlName:nil];
    //[[JHNetworkManager sharedManager] testPost];
    
    //set NavigationController
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _rootVC = [[WGNavigationController alloc] init];
    self.window.rootViewController = _rootVC;
    [self.window makeKeyAndVisible];
    
    [WGApplication sharedApplication];
    /// Show welcome view
    [self showWelcomeView];
    
    /// Show launch view, waiting for base info response
    [self showLaunchView];
    //[self initAppearance];
    
    //[self loadRootViewController:application withOptions:launchOptions];
}

- (void)loadRootViewController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    //add MainViewController
    WGMainViewController *mainVC = [[WGMainViewController alloc] init];
    [_rootVC setViewControllers:@[mainVC] animated:NO];
}

@end
