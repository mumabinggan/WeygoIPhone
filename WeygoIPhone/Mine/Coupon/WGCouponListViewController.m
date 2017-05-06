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
#import "WGCouponListViewController+Request.h"

@interface WGCouponListViewController ()

@end

@interface WGCouponListViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource, TWTableViewRefreshingDelegate>

@end

@implementation WGCouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"CouponList_Selected_Title");
    [self loadListResponse:YES pulling:NO];
}

- (void)initData {
    _dataMArray = [NSMutableArray array];
//    WGCoupon *coupon = [[WGCoupon alloc] init];
//    coupon.id = 2323;
//    coupon.name = @"kdfasdfas";
//    coupon.briefDescription = @"南非世界杯夺";
//    coupon.totalCount = 5;
//    coupon.residueCount = 3;
//    coupon.time = @"21-12-2017";
//    coupon.couponCode = @"ZDQFADSFSSFASD";
//    
//    WGCoupon *coupon1 = [[WGCoupon alloc] init];
//    coupon1.id = 24323;
//    coupon1.name = @"kdfasdfas";
//    coupon1.briefDescription = @"南非世界杯夺";
//    coupon1.totalCount = 5;
//    coupon1.residueCount = 1;
//    coupon1.time = @"21-12-2017";
//    coupon1.couponCode = @"ZDQFSFSADSFASD";
//    
//    WGCoupon *coupon2 = [[WGCoupon alloc] init];
//    coupon2.id = 243263;
//    coupon2.name = @"kdfasdfas";
//    coupon2.briefDescription = @"南非世界杯夺";
//    coupon2.totalCount = 5;
//    coupon2.residueCount = 3;
//    coupon2.time = @"21-12-2017";
//    coupon2.couponCode = @"ZDQFFFADSFASD";
//    
//    _dataArray = @[coupon, coupon1, coupon2];
}

- (void)initSubView {
    [super initSubView];
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:contentView];
    
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped refreshType:TWRefreshTypeBottom];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.refreshDelegate = self;
    _tableView.backgroundColor = kRGB(234, 238, 240);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (_isSelect) {
        _tableView.tableHeaderView = [self tableViewHeaderView];
    }
    else {
        _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
        _tableView.layer.opacity = 0.0f;
    }
    [contentView addSubview:_tableView];
}

- (JHView *)tableViewHeaderView {
    JHView *headerView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(44))];
    headerView.backgroundColor = kWhiteColor;
    
    _inputTextField = [[JHTextField alloc] initWithFrame:CGRectMake(kAppAdaptWidth(8), kAppAdaptHeight(8), kAppAdaptWidth(263), kAppAdaptHeight(28))];
    _inputTextField.backgroundColor = kHRGB(0XF8FAFA);
    _inputTextField.font = kAppAdaptFont(12);
    _inputTextField.placeholder = kStr(@"Input Placeholder");
    [headerView addSubview:_inputTextField];
    
    _activateBtn = [[JHButton alloc] initWithFrame:CGRectMake(_inputTextField.maxX + kAppAdaptWidth(8), _inputTextField.y + kAppAdaptHeight(2), kAppAdaptWidth(88), kAppAdaptHeight(24)) difRadius:JHRadiusMake(kAppAdaptWidth(12), kAppAdaptWidth(12), kAppAdaptWidth(12), kAppAdaptWidth(12)) borderWidth:kAppAdaptWidth(1) borderColor:kHRGB(0x5677fc)];
    [_activateBtn setTitle:kStr(@"Activate") forState:UIControlStateNormal];
    [_activateBtn setTitle:kStr(@"Inactivate") forState:UIControlStateSelected];
    _activateBtn.titleLabel.font = kAppAdaptFont(12);
    [_activateBtn setTitleColor:kHRGB(0x5677fc) forState:UIControlStateNormal];
    [_activateBtn addTarget:self action:@selector(touchActivateBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:_activateBtn];
    return headerView;
}

- (void)refreshUI {
    [_tableView reloadData];
    [UIView animateWithDuration:0.5 animations:^() {
        _tableView.layer.opacity = 1.0f;
    }];
}

- (void)touchActivateBtn:(JHButton *)sender {
    [_inputTextField resignFirstResponder];
    WGCoupon *coupon = [[WGCoupon alloc] init];
    coupon.couponCode = _inputTextField.text;
    coupon.isSelected = sender.selected;
    [self loadUseCoupon:coupon remove:(sender.selected)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGCouponListViewController (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataMArray.count;
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
    WGCoupon *coupon = _dataMArray[indexPath.row];
    [cell showWithData:coupon];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WGCoupon *coupon = _dataMArray[indexPath.row];
    [self loadUseCoupon:coupon remove:coupon.isSelected];
}

- (void)beginRefreshFooter:(TWRefreshTableView *)tableView {
    [self loadListResponse:NO pulling:YES];
}

- (void)beginRefreshHeader:(TWRefreshTableView *)tableView {
    [self loadListResponse:YES pulling:YES];
}

@end
