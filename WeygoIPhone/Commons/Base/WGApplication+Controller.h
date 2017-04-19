//
//  WGApplication+View.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGApplication.h"
#import "WGMainViewController.h"

@class WGNavigationController;
@class WGMainViewController;
@class WGHomeTabViewController;
@class WGTabBenefitViewController;
@class AppDelegate;

@interface WGApplication (Controller)

@property (nonatomic, strong, readonly) AppDelegate *appdelegate;

@property (nonatomic, strong, readonly) WGNavigationController *navigationController;

@property (nonatomic, strong, readonly) WGMainViewController *mainViewController;

@property (nonatomic, strong, readonly) WGHomeTabViewController *homeTabViewController;
@property (nonatomic, strong, readonly) WGTabBenefitViewController *benefitTabViewController;

- (void)closeSideBarViewController;

- (void)openSideBarViewController;

- (void)switchTab:(WGTabIndex)index;

@end
