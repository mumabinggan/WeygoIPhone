//
//  WGMainViewController+TabBarDelegate.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGMainViewController+TabBarDelegate.h"
#import "WGTabMineViewController.h"
#import "WGLoginViewController.h"

@implementation WGMainViewController (TabBarDelegate) 

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[WGTabMineViewController class]] && ![WGApplication sharedApplication].isLogined) {
        [self intoLoginViewController];
        return NO;
    }
    return YES;
}

- (void) tabBarController:(nonnull UITabBarController *)tabBarController didSelectViewController:(nonnull UIViewController *)viewController {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTabChanged object:viewController];
}

- (void)intoLoginViewController {
    WeakSelf;
    [WGLoginViewController pushInNavigationController:self.navigationController loginFrom:WGLoginFromDefault sucess:^(WGLoginViewController *vc) {
        [weakSelf handleLoginSuccess];
    } cancel:^(WGLoginViewController *vc) {
        [weakSelf handleCancelLogin];
    }];
}

- (void)handleLoginSuccess {
    self.selectedIndex = WGTabIndexMine;
    WGTabMineViewController *mineViewController = self.selectedViewController;
    if (mineViewController && [mineViewController respondsToSelector:@selector(refresh:)]) {
        [mineViewController refresh:[WGApplication sharedApplication].user];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleCancelLogin {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
