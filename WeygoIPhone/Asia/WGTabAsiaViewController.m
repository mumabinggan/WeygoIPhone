//
//  WGAsiaViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/5/8.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGTabAsiaViewController.h"
#import "WGHomeTabContentViewController.h"
#import "WGTabAsiaViewController+Request.h"
#import "WGViewController+Search.h"
#import "WGViewController+ShopCart.h"
#import "WGTabViewController+Slider.h"

@interface WGTabAsiaViewController ()

@end

@implementation WGTabAsiaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarIndex = WGTabIndexMine;
        self.tabBarItem.title = kStr(@"TabAsia");
        self.tabBarItem.image = [UIImage imageNamed:@"tab_asia_icon"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kStr(@"TabAsia");
    
    [self loadAsiaClassify];
}

- (void)initNavigationItems {
    //set leftView
    self.navigationItem.leftBarButtonItem = [self createSliderItem];
    
    //set rightView
    self.navigationItem.rightBarButtonItems = @[[self createShopCartItem], [self createSearchItem]];
}

- (void)refreshUI {
    if (!_contentVC) {
        _contentVC = [[WGHomeTabContentViewController alloc] init];
        __weak id weakSelf = self;
        _contentVC.view.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - kAppNavigationVCY - kAppTabBarHeight);
        _contentVC.onTopRefresh = ^(void) {
            [weakSelf handleRefresh];
        };
        _contentVC.refreshType = 0;
        [self.view addSubview:_contentVC.view];
        [self addChildViewController:_contentVC];
    }
    _contentVC.homeData = _data;
}

- (void)handleRefresh {
    [self loadAsiaClassify];
}

- (BOOL)prefersNavigationBarHiddenAnimated {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
