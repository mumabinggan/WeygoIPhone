//
//  WGApplication+View.h
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGApplication.h"

@class WGNavigationController;
@class WGMainViewController;

@interface WGApplication (Controller)

@property (nonatomic, strong, readonly) WGNavigationController *navigationController;

@property (nonatomic, strong, readonly) WGMainViewController *mainViewController;

- (void)closeSideBarViewController;

- (void)openSideBarViewController;

- (void)switchTab:(WGTabIndex)index;

@end
