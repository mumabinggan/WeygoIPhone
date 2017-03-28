//
//  WGTabViewController.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGTabViewController.h"

@interface WGTabViewController ()

@end

@implementation WGTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData {

}

- (void)initSubView {
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
