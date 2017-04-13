//
//  WGClassifyDetailViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/22.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClassifyDetailViewController.h"
#import "WGHomeFloorGoodListItemCell.h"
#import "WGHomeFloorGoodGridItemCell.h"
#import "WGHomeFloorContentGoodItem.h"
#import "WGScrollImageView.h"
#import "WGClassifySortView.h"
#import "WGHomeTitleView.h"
#import "WGSubClassifyView.h"
#import "WGClassifyDetailFilterViewController.h"
#import "WGShopCartViewController.h"
#import "WGClassifyDetailContentViewController.h"

//for test
#import "WGCarouselFigureItem.h"
#import "WGClassifyItem.h"

@interface WGClassifyDetailViewController ()
{
    WGSubClassifyView *_subClassifyView;
    NSArray *_subClassifyArray;
    
    WGClassifyDetailContentViewController *_contentVC;
}
@end

@implementation WGClassifyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initSubView {
    [super initSubView];
    
    [self initNavigationItem];
    
    WeakSelf;
    _contentVC = [[WGClassifyDetailContentViewController alloc] init];
    _contentVC.onResponse = ^(WGClassifyDetail *classifyDetail) {
        [weakSelf handleOnResponse:classifyDetail];
    };
    [self.view addSubview:_contentVC.view];
    [self addChildViewController:_contentVC];
}

- (void)initNavigationItem {
    WGHomeTitleView *titleView = [[WGHomeTitleView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth / 2, kAppNavigationBarHeight)];
    [titleView setTitle:self.title];
    __weak id weakSelf = self;
    titleView.onTouch = ^(WGHomeTitleView *titleView) {
        [weakSelf touchTitleView];
    };
    self.navigationItem.titleView = titleView;
    
    JHButton *cartBtn = [[JHButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [cartBtn setBackgroundImage:[UIImage imageNamed:@"right_cart"] forState:UIControlStateNormal];
    [cartBtn addTarget:self action:@selector(touchShopCartBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cartBtn];
}

- (void)touchTitleView {
    if (_subClassifyArray.count > 0) {
        _subClassifyView = [[WGSubClassifyView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
        _subClassifyView.classifyArray = _subClassifyArray;
        __weak id weakSelf = self;
        _subClassifyView.onApply = ^(WGClassifyItem *item) {
            [weakSelf handleApply:item];
        };
        [_subClassifyView show];
    }
}

- (void)handleOnResponse:(WGClassifyDetail *)classifyDetail {
    _subClassifyArray = classifyDetail.subClassifyArray;
}

- (void)handleApply:(WGClassifyItem *)item {
    WGClassifyDetailViewController *vc = [[WGClassifyDetailViewController alloc] init];
    vc.classifyId = item.id;
    vc.title = item.name;
    [self.navigationController pushViewController:vc animated:YES];
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
