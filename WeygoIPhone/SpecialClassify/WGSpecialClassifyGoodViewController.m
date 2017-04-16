//
//  WGSpecialClassifyGoodViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/15.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGSpecialClassifyGoodViewController.h"
#import "WGClassifyDetailContentViewController.h"
#import "WGShopCartViewController.h"
#import "WGViewController+ShopCart.h"

@interface WGSpecialClassifyGoodViewController ()
{
    WGClassifyDetailContentViewController *_contentVC;
}
@end

@implementation WGSpecialClassifyGoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initSubView {
    [super initSubView];
    
    [self initNavigationItem];
    
    _contentVC = [[WGClassifyDetailContentViewController alloc] init];
    _contentVC.classifyId = _id;
    [self.view addSubview:_contentVC.view];
    [self addChildViewController:_contentVC];
}

- (void)initNavigationItem {
    self.navigationItem.rightBarButtonItem = [self createShopCartItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
