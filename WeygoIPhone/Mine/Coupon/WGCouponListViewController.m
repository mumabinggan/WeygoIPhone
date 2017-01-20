//
//  WGCouponListViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/18.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCouponListViewController.h"
#import "WGCouponCell.h"
#import "WGCouponCode.h"
#import "WGCoupon.h"

@interface WGCouponListViewController ()
{
    JHTableView *_tableView;
}
@end

@interface WGCouponListViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGCouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData {
    WGCoupon *coupon = [[WGCoupon alloc] init];
    coupon.name = @"kdfasdfas";
    coupon.briefDescription = @"南非世界杯夺";
    coupon.totalCount = 5;
    coupon.residueCount = 3;
    coupon.time = @"21-12-2017";
    coupon.couponCode = @"ZDQFADSFASD";
    
    WGCoupon *coupon1 = [[WGCoupon alloc] init];
    coupon1.name = @"kdfasdfas";
    coupon1.briefDescription = @"南非世界杯夺";
    coupon1.totalCount = 5;
    coupon1.residueCount = 1;
    coupon1.time = @"21-12-2017";
    coupon1.couponCode = @"ZDQFADSFASD";
    
    WGCoupon *coupon2 = [[WGCoupon alloc] init];
    coupon2.name = @"kdfasdfas";
    coupon2.briefDescription = @"南非世界杯夺";
    coupon2.totalCount = 5;
    coupon2.residueCount = 3;
    coupon2.time = @"21-12-2017";
    coupon2.couponCode = @"ZDQFADSFASD";
    
    _dataArray = @[coupon, coupon1, coupon2];
}

- (void)initSubView {
    
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:contentView];
    
    _tableView = [[JHTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = kRGB(234, 238, 240);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (_isSelect) {
        _tableView.tableHeaderView = [self tableViewHeaderView];
    }
    else {
        _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    }
    [contentView addSubview:_tableView];
    
    JHButton *useBtn = [[JHButton alloc] initWithFrame:CGRectMake(kDeviceWidth - kAppAdaptWidth(80), kDeviceHeight - kAppAdaptHeight(80), kAppAdaptWidth(56), kAppAdaptWidth(56))];
    [useBtn setBackgroundImage:[UIImage imageNamed:@"use_coupon"] forState:UIControlStateNormal];
    [useBtn addTarget:self action:@selector(touchUseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:useBtn];
}

- (void)touchUseBtn:(JHButton *)sender {
    NSIndexPath *indexPath = _tableView.indexPathForSelectedRow;
    if (indexPath) {
        if (self.onUse) {
            self.onUse(_dataArray[indexPath.row]);
        }
    }
}

- (JHView *)tableViewHeaderView {
    JHView *headerView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(44))];
    headerView.backgroundColor = kWhiteColor;
    
    JHTextField *inputTextField = [[JHTextField alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8), kAppAdaptHeight(8), kAppAdaptWidth(263), kAppAdaptHeight(28))];
    inputTextField.backgroundColor = kHRGB(0XF8FAFA);
    inputTextField.font = kAppAdaptFont(12);
    inputTextField.placeholder = kStr(@"Input Placeholder");
    [headerView addSubview:inputTextField];
    
    JHButton *activateBtn = [[JHButton alloc] initWithFrame:CGRectMake(inputTextField.maxX + kAppAdaptWidth(8), inputTextField.y + kAppAdaptHeight(2), kAppAdaptWidth(88), kAppAdaptHeight(24)) difRadius:JHRadiusMake(kAppAdaptWidth(12), kAppAdaptWidth(12), kAppAdaptWidth(12), kAppAdaptWidth(12)) borderWidth:kAppAdaptWidth(1) borderColor:kHRGB(0x5677fc)];
    [activateBtn setTitle:kStr(@"Activate") forState:UIControlStateNormal];
    [activateBtn setTitle:kStr(@"Inactivate") forState:UIControlStateSelected];
    activateBtn.titleLabel.font = kAppAdaptFont(12);
    [activateBtn setTitleColor:kHRGB(0x5677fc) forState:UIControlStateNormal];
    [activateBtn addTarget:self action:@selector(touchActivateBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:activateBtn];
    
    return headerView;
}

- (void)touchActivateBtn:(JHButton *)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGCouponListViewController (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAppAdaptHeight(118 + 8);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    WGCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[WGCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell showWithData:_dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (int num = 0; num < _dataArray.count; ++num) {
        WGCoupon *coupon = _dataArray[num];
        coupon.isSelected = (num == indexPath.row);
    }
    [_tableView reloadData];
}

@end
