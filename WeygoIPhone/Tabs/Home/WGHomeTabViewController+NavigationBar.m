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

@implementation WGHomeTabViewController (NavigationBar)

- (void)initNavigationItems {
    //set titleView
    WGHomeTitleView *titleView = [[WGHomeTitleView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth / 2, kAppNavigationBarHeight)];
    NSString *title = @"米兰米兰米兰米兰米兰米兰米兰米兰米兰米兰";
    [titleView setTitle:title];
    self.navigationItem.titleView = titleView;
    
    //set leftView
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"test"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 60, 40);
    [leftBtn addTarget:self action:@selector(touchLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

- (void)touchLeftButton:(id)sender {
    WGMainViewController *mainViewController = (WGMainViewController *)self.parentViewController;
    if ([mainViewController respondsToSelector:@selector(openSideBarViewController)]) {
        [mainViewController openSideBarViewController];
    }
}

@end
