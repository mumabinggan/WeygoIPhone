//
//  WGTabViewController.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGTabViewController.h"
#import "WGShopCartViewController.h"

@interface WGTabViewController ()

@end

@implementation WGTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.automaticallyAdjustsScrollViewInsets = YES;
    // Do any additional setup after loading the view.
    _viewType = 1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTabChanged:) name:kNotificationTabChanged object:nil];
}

- (void) handleTabChanged:(NSNotification *)notification {
    if (notification.object != self) {
        _viewType = 1;
    }
    [self tabDidChanged:notification];
}

- (void)tabDidChanged:(NSNotification *)notification {
    
}

- (void)initData {

}

- (void)initSubView {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _viewType = 2;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationItem.title = self.title;
    
    // Clear all navigation item properties
    self.navigationItem.backBarButtonItem = nil;
    self.navigationItem.titleView = nil;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItems = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItems = nil;
    
    // init navigation items
    [self initNavigationItems];
}

- (void)initNavigationItems {
    // Realization by sub classes
}

- (UINavigationController *)navigationController {
    return self.tabBarController.navigationController;
}

- (UINavigationItem *)navigationItem {
    return self.tabBarController.navigationItem;
}

- (void)touchShopCartButton:(JHButton *)sender {
    WGShopCartViewController *vc = [[WGShopCartViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
