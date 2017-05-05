//
//  WGHomeTabViewController+NavigationBar.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/10.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGHomeTabViewController+NavigationBar.h"
#import "WGHomeTitleView.h"
#import "WGHomeSliderViewController.h"
#import "WGMainViewController.h"
#import "WGTabViewController+Slider.h"
#import "WGViewController+ShopCart.h"
#import "WGPostCodePopoverView.h"
#import "WGViewController+Search.h"

@implementation WGHomeTabViewController (NavigationBar)

- (void)initNavigationItems {
    //set titleView
    WeakSelf;
    WGHomeTitleView *titleView = [[WGHomeTitleView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth / 2, kAppNavigationBarHeight)];
    NSString *title = kStr(@"Home_Title");
    titleView.onTouch = ^(WGHomeTitleView *view) {
        [weakSelf handleTitleView];
    };
    [titleView setTitle:title];
    self.navigationItem.titleView = titleView;
    
    //set leftView
    self.navigationItem.leftBarButtonItem = [self createSliderItem];
    
    //set rightView
    self.navigationItem.rightBarButtonItem = [self createSearchItem];
}

- (void)handleTitleView {
    WGPostCodePopoverView *view = [[WGPostCodePopoverView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    view.cap = [WGApplication sharedApplication].currentPostCode;
    [view show];
}

//- (void)

@end
