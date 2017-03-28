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

@implementation WGHomeTabViewController (NavigationBar)

- (void)initNavigationItems {
    //set titleView
    WGHomeTitleView *titleView = [[WGHomeTitleView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth / 2, kAppNavigationBarHeight)];
    NSString *title = kStr(@"Home_Title");
    [titleView setTitle:title];
    self.navigationItem.titleView = titleView;
    
    //set leftView
    self.navigationItem.leftBarButtonItem = [self createSliderItem];
}

@end
