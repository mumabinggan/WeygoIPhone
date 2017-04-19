//
//  WGApplication+View.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGApplication+Controller.h"
#import "AppDelegate.h"
#import "WGMainViewController.h"
#import "WGNavigationController.h"

@implementation WGApplication (Controller)

- (AppDelegate *)appdelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (WGNavigationController *)navigationController {
    return (WGNavigationController *)([UIApplication sharedApplication].keyWindow.rootViewController);
}

- (WGMainViewController *)mainViewController {
    WGNavigationController *navc = self.navigationController;
    return (WGMainViewController*)[[navc viewControllers] firstObject];
}

- (WGHomeTabViewController *)homeTabViewController {
    WGMainViewController *mainViewController = self.mainViewController;
    return (WGHomeTabViewController *)[mainViewController.viewControllers objectAtIndex:WGTabIndexHome];
}

- (WGTabBenefitViewController *)benefitTabViewController {
    WGMainViewController *mainViewController = self.mainViewController;
    return (WGTabBenefitViewController *)[mainViewController.viewControllers objectAtIndex:WGTabIndexBenefit];
}

- (void)closeSideBarViewController {
    WGMainViewController *mainViewController = self.mainViewController;
    [mainViewController closeSideBarViewController];
}

- (void)openSideBarViewController {
    WGMainViewController *mainViewController = self.mainViewController;
    [mainViewController openSideBarViewController];
}

- (void)switchTab:(WGTabIndex)index {
    [self.navigationController popToRootViewControllerAnimated:NO];
    self.mainViewController.selectedIndex = index;
}

@end
