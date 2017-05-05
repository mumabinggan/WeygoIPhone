//
//  WGMineTabViewController.m
//  WeygoIPhone
//
//  Created by muma on 2016/12/8.
//  Copyright © 2016年 weygo.com. All rights reserved.
//

#import "WGTabMineViewController.h"
#import "WGMineHeaderView.h"
#import "WGPersonInfoViewController.h"
#import "WGCouponListViewController.h"
#import "WGFootPrintViewController.h"
#import "WGCollectionViewController.h"
#import "WGAddressListViewController.h"
#import "WGPersonInfoViewController.h"
#import "WGSettingViewController.h"
#import "WGIntegrationViewController.h"
#import "WGClientServiceCenterViewController.h"
#import "WGOrderListViewController.h"

@interface WGTabMineViewController ()
{
    JHTableView *_tableView;
    WGMineHeaderView *_headerView;
    
    NSMutableArray *_gridMArray;
    
    JHButton *_messageBtn;
    JHLabel *_orderLabel;
    JHLabel *_deliveryLabel;
}
@end

@implementation WGTabMineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarIndex = WGTabIndexMine;
        self.tabBarItem.title = kStr(@"TabMine");
        self.tabBarItem.image = [UIImage imageNamed:@"tab_mine_icon"];
    }
    return self;
}

- (BOOL)prefersNavigationBarHidden {
    return YES;
}

- (BOOL)prefersNavigationBarHiddenAnimated {
    return _viewType != 1;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    WeakSelf;
    [[WGApplication sharedApplication] loadUserInfoOnCompletion:^(WGUserInfoResponse *userResponse) {
        [weakSelf refresh:userResponse.data];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData {
    _data = [WGApplication sharedApplication].user;
}

- (void)initSubView {
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:contentView];
    _tableView = [[JHTableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, self.view.height) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.contentInset = UIEdgeInsetsMake(-kAppStateHeight, 0, kAppTabBarHeight, 0);
    _tableView.tableHeaderView = [self createHeaderView];
    _tableView.tableFooterView = [self createFooterView];
    _tableView.showsVerticalScrollIndicator = NO;
    [contentView addSubview:_tableView];
    
    JHButton *sliderBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(16), kAppAdaptHeight(30), kAppAdaptWidth(24), kAppAdaptHeight(24))];
    [sliderBtn setBackgroundImage:[UIImage imageNamed:@"mine_slider"] forState:UIControlStateNormal];
    [sliderBtn addTarget:self action:@selector(touchSliderButton:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:sliderBtn];
    
    JHLabel *titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(30), kDeviceWidth, kAppAdaptHeight(24))];
    titleLabel.text = self.tabBarItem.title;
    titleLabel.font = kAppAdaptFont(17);
    titleLabel.textColor = kWhiteColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:titleLabel];
    
    _messageBtn = [[JHButton alloc] initWithFrame:CGRectMake(kDeviceWidth - kAppAdaptWidth(40), kAppAdaptHeight(30), kAppAdaptWidth(24), kAppAdaptHeight(24))];
    [_messageBtn setBackgroundImage:[UIImage imageNamed:@"mine_message"] forState:UIControlStateNormal];
    [_messageBtn addTarget:self action:@selector(touchMessageBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_messageBtn addBadge];
    
    [self refresh:_data];
    //[contentView addSubview:_messageBtn];
}

- (JHView *)createHeaderView {
    _headerView = [[WGMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(244))];
    return _headerView;
}

- (JHView *)createFooterView {
    JHView *footerView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(80 + 3*104))];
    JHView *headerView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(80))];
    headerView.backgroundColor = kHRGB(0xF8FAFA);
    [footerView addSubview:headerView];
    NSArray *titleArray = @[kStr(@"Mine_Order"), kStr(@"Mine_Delivery")];
    for (int num = 0; num < titleArray.count; ++num) {
        JHButton *itemBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(53) + num*kAppAdaptWidth(125) + kAppAdaptWidth(20), 0, kAppAdaptWidth(125), kAppAdaptHeight(80))];
        itemBtn.tag = num;
        [itemBtn addTarget:self action:@selector(touchOrderBtn:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:itemBtn];
        
        JHLabel *titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(18), itemBtn.width, kAppAdaptHeight(16))];
        titleLabel.text = titleArray[num];
        titleLabel.font = kAppAdaptFont(12);
        titleLabel.textColor = WGAppLightNameLabelColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [itemBtn addSubview:titleLabel];
        
        JHLabel *countLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, titleLabel.maxY + kAppAdaptHeight(4), itemBtn.width, kAppAdaptHeight(24))];
        countLabel.font = kWGOswaldRegularAdaptFont(16);
        countLabel.textColor = WGAppNameLabelColor;
        countLabel.text = @"0";
        countLabel.textAlignment = NSTextAlignmentCenter;
        [itemBtn addSubview:countLabel];
        if (num == 0) {
            _orderLabel = countLabel;
        }
        else {
            _deliveryLabel = countLabel;
        }
    }
    
    titleArray = @[kStr(@"Mine_Points"), kStr(@"Mine_Coupon"), kStr(@"Mine_FootPrint"), kStr(@"Mine_Collection"), kStr(@"Mine_Address"), kStr(@"Mine_Customer"), kStr(@"Mine_Info"), kStr(@"Mine_Setting"), kStr(@"Mine_Logout")];
    NSArray *imageArray = @[@"mine_points", @"mine_coupon", @"mine_footprint", @"mine_collection", @"mine_address", @"mine_invoice", @"mine_info", @"mine_setting", @"mine_logout"];
    float width = kDeviceWidth/3;
    float height = kAppAdaptHeight(104);
    for (int num = 0; num < titleArray.count; ++num) {
        JHButton *itemBtn = [[JHButton alloc] initWithFrame:CGRectMake(num%3*width, num/3*height + headerView.maxY, width, height)];
        itemBtn.tag = num;
        [itemBtn addTarget:self action:@selector(touchFeatureBtn:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:itemBtn];
        
        JHImageView *imageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 0, kAppAdaptWidth(30), kAppAdaptHeight(30))];
        imageView.center = CGPointMake(itemBtn.width/2, kAppAdaptHeight(40));
        imageView.image = [UIImage imageNamed:imageArray[num]];
        [itemBtn addSubview:imageView];
        
        JHLabel *titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(68), itemBtn.width, kAppAdaptHeight(16))];
        titleLabel.text = titleArray[num];
        titleLabel.font = kAppAdaptFont(12);
        titleLabel.textColor = WGAppNameLabelColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [itemBtn addSubview:titleLabel];
    }
    return footerView;
}

- (void)refresh:(WGUser *)user {
    _data = user;
    if (_data) {
        [_headerView showWithData:_data];
        _orderLabel.text = [NSString stringWithFormat:@"%d", _data.orderCount];
        _deliveryLabel.text = [NSString stringWithFormat:@"%d", _data.deliveringCount];
    }
}

- (void)touchMessageBtn:(id)sender {

}

- (void)touchOrderBtn:(JHButton *)sender {
    WGOrderListViewController *vc = [[WGOrderListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchFeatureBtn:(JHButton *)sender {
//    @[kStr(@"Mine_Points"), kStr(@"Mine_Coupon"), kStr(@"Mine_FootPrint"), kStr(@"Mine_Collection"), kStr(@"Mine_Address"), kStr(@"Mine_Customer"), kStr(@"Mine_Info"), kStr(@"Mine_Setting"), kStr(@"Mine_Logout")];
    if (sender.tag == 0) {
        //积分页面
        WGIntegrationViewController *vc = [[WGIntegrationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender.tag == 1) {
        //优惠卷页面
        WGCouponListViewController *vc = [[WGCouponListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender.tag == 2) {
        //足迹页面
        WGFootPrintViewController *vc = [[WGFootPrintViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender.tag == 3) {
        //收藏页面
        WGCollectionViewController *vc = [[WGCollectionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender.tag == 4) {
        //地址页面
        WGAddressListViewController *vc = [[WGAddressListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender.tag == 5) {
        //客服页面
        WGClientServiceCenterViewController *vc = [[WGClientServiceCenterViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender.tag == 6) {
        //信息页面
        WGPersonInfoViewController *vc = [[WGPersonInfoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender.tag == 7) {
        //设置页面
        WGSettingViewController *vc = [[WGSettingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender.tag == 8) {
        //退出页面
        WeakSelf;
        [self showConfirmMessage:kStr(@"Mine_Logout_Tip") withTitle:nil cancelButtonTitle:kStr(@"Mine_Logout_No") okButtonTitle:kStr(@"Mine_Logout_Si") onCompletion:^(NSInteger index, UIAlertController *alertViewController) {
            if (index == 1) {
                [weakSelf handleLogout];
            }
        }];
    }
}

- (void)handleLogout {
    [[WGApplication sharedApplication] loadLogoutOnCompletion:^(WGLogoutResponse *response) {
        [self handleLogoutCompletion];
    }];
}

- (void)handleLogoutCompletion {
    [self sendNotification:WGRefreshNotificationTypeLogout];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogOut object:nil];
    [[WGApplication sharedApplication] switchTab:WGTabIndexHome];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
