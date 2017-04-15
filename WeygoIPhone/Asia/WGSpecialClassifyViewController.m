//
//  WGAsiaViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/26.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGSpecialClassifyViewController.h"
#import "WGCommonViewController.h"
#import "WGSpecialClassifyViewController+Request.h"

@interface WGSpecialClassifyViewController ()
{
    WGHomeTabContentViewController *_contentVC;
}
@end

@implementation WGSpecialClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadSpecailClassify];
}

- (void)refreshUI {
    if (!_contentVC) {
        _contentVC = [[WGHomeTabContentViewController alloc] init];
        __weak id weakSelf = self;
        _contentVC.view.frame = CGRectMake(0, kAppNavigationVCY, kDeviceWidth, kDeviceHeight - kAppNavigationVCY);
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
    [self loadSpecailClassify];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
