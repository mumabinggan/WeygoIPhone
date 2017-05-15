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
#import "WGClassifyDetailContentViewController+Request.h"
#import "WGViewController+ShopCart.h"

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
    _contentVC.classifyId = _classifyId;
    _contentVC.onResponse = ^(WGClassifyDetail *classifyDetail) {
        [weakSelf handleOnResponse:classifyDetail];
    };
    [_contentVC loadData:YES pulling:NO];
    [self.view addSubview:_contentVC.view];
    [self addChildViewController:_contentVC];
}

- (void)initNavigationItem {
    self.navigationItem.rightBarButtonItem = [self createShopCartItem];
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
    if (_subClassifyArray == nil || _subClassifyArray.count == 0) {
        self.title = classifyDetail.name;
    }
    else {
        WGHomeTitleView *titleView = [[WGHomeTitleView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth / 2, kAppNavigationBarHeight)];
        [titleView setTitle:classifyDetail.name];
        __weak id weakSelf = self;
        titleView.onTouch = ^(WGHomeTitleView *titleView) {
            [weakSelf touchTitleView];
        };
        self.navigationItem.titleView = titleView;
    }
}

- (void)handleApply:(WGClassifyItem *)item {
    WGClassifyDetailViewController *vc = [[WGClassifyDetailViewController alloc] init];
    vc.classifyId = item.id;
    vc.title = item.name;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
