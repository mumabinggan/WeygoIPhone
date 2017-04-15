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
    [self.view addSubview:_contentVC.view];
    [self addChildViewController:_contentVC];
}

- (void)initNavigationItem {
    JHButton *cartBtn = [[JHButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [cartBtn setBackgroundImage:[UIImage imageNamed:@"right_cart"] forState:UIControlStateNormal];
    [cartBtn addTarget:self action:@selector(touchShopCartBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cartBtn];
}

- (void)touchShopCartBtn:(id)sender {
    WGShopCartViewController *vc = [[WGShopCartViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
