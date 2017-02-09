//
//  WGViewController.m
//  WeygoIPhone
//
//  Created by muma on 2016/10/24.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGViewController.h"

@interface WGViewController ()

@end

@implementation WGViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self checkNavigationBarHidden];
}

- (void)checkNavigationBarHidden {
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:[self prefersNavigationBarHidden] animated:[self prefersNavigationBarHiddenAnimated]];
    }
}

- (BOOL)prefersNavigationBarHidden {
    return NO;
}

- (BOOL)prefersNavigationBarHiddenAnimated {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    
    [self initSubView];
    
    [self initNotification];
}

- (void)initData {
    
}

- (void)initSubView {
    
}

- (void)initNotification {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
