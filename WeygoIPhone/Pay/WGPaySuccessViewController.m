//
//  WGPaySuccessViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/11.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGPaySuccessViewController.h"
#import "WGPaySuccessRequest.h"
#import "WGPaySuccessResponse.h"

@interface WGPaySuccessViewController ()
{
    JHTableView *_tableView;
    JHLabel *_orderTitleLabel;
    WGPaySuccessData *_paySuccessData;
}
@end

@interface WGPaySuccessViewController (TableViewDelegate) <UITableViewDelegate>

@end

@implementation WGPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"PaySuccess_Title");
    if ([NSString isNullOrEmpty:_orderId]) {
        [self loadPaySuccess];
    }
}

- (void)initSubView {
    [super initSubView];
    _tableView = [[JHTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0);
    _tableView.backgroundColor = kWhiteColor;
    _tableView.tableHeaderView = [self createHeaderView];
    _tableView.tableFooterView = [self createFooterView];
    [self.view addSubview:_tableView];
    if ([NSString isNullOrEmpty:_orderId]) {
        _tableView.layer.opacity = 0.0f;
    }
    //
}

- (UIView *)createHeaderView {
    JHView *headerView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(412))];
    
    JHImageView *imageView = [[JHImageView alloc] initWithFrame:CGRectMake((kDeviceWidth - kAppAdaptWidth(112))/2, kAppAdaptHeight(60), kAppAdaptWidth(112), kAppAdaptHeight(112))];
    imageView.image = [UIImage imageNamed:@"integration_image"];
    [headerView addSubview:imageView];
    
    JHLabel *titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, imageView.maxY + kAppAdaptHeight(24), kDeviceWidth, kAppAdaptHeight(48))];
    titleLabel.font = kAppAdaptFontBold(16);
    titleLabel.textColor = WGAppNameLabelColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = kStr(@"PaySuccess_SubTitle");
    [headerView addSubview:titleLabel];
    
    JHLabel *titleLabel1 = [[JHLabel alloc] initWithFrame:CGRectMake(0, titleLabel.maxY + kAppAdaptHeight(8), kDeviceWidth, kAppAdaptHeight(16))];
    titleLabel1.font = kAppAdaptFont(12);
    titleLabel1.textColor = WGAppLightNameLabelColor;
    titleLabel1.textAlignment = NSTextAlignmentCenter;
    titleLabel1.text = kStr(@"PaySuccess_SubTitle1");
    [headerView addSubview:titleLabel1];
    
    JHView *bgView = [[JHView alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), titleLabel1.maxY + kAppAdaptHeight(24), kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(100)) radius:kAppAdaptWidth(3)];
    bgView.backgroundColor = kHRGB(0xF8FAFA);
    [headerView addSubview:bgView];
    
    _orderTitleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, kAppAdaptHeight(16), bgView.width, kAppAdaptHeight(20))];
    _orderTitleLabel.font = kAppAdaptFont(14);
    _orderTitleLabel.textColor = WGAppNameLabelColor;
    _orderTitleLabel.textAlignment = NSTextAlignmentCenter;
    _orderTitleLabel.text = [NSString stringWithFormat:kStr(@"PaySuccess_SubTitle2"), _orderId];
    [bgView addSubview:_orderTitleLabel];
    
    JHLabel *titleLabel3 = [[JHLabel alloc] initWithFrame:CGRectMake(0, _orderTitleLabel.maxY + kAppAdaptHeight(8), bgView.width, kAppAdaptHeight(40))];
    titleLabel3.font = kAppAdaptFont(14);
    titleLabel3.textColor = WGAppLightNameLabelColor;
    titleLabel3.textAlignment = NSTextAlignmentCenter;
    titleLabel3.numberOfLines = 0;
    titleLabel3.text = kStr(@"PaySuccess_SubTitle3");
    [bgView addSubview:titleLabel3];
    
    return headerView;
}

- (void)refreshUI {
    [UIView animateWithDuration:0.5 animations:^() {
        _tableView.layer.opacity = 1.0f;
    }];
    _orderTitleLabel.text = [NSString stringWithFormat:kStr(@"PaySuccess_SubTitle2"), _paySuccessData.orderId];
}

- (JHView *)createFooterView {
    JHView *footerView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - kAppAdaptHeight(412))];
    JHButton *confirmBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(108), 0, kDeviceWidth - kAppAdaptWidth(216), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptHeight(20), kAppAdaptHeight(20), kAppAdaptHeight(20), kAppAdaptHeight(20)) backgroundColor:WGAppBlueButtonColor];
    [confirmBtn addTarget:self action:@selector(touchCommitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:kStr(@"PaySuccess_Button") forState:UIControlStateNormal];
    [confirmBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = kAppAdaptFont(14);
    [footerView addSubview:confirmBtn];
    
    return footerView;
}

- (void)touchCommitBtn:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[WGApplication sharedApplication] switchTab:WGTabIndexHome];
}

- (void)loadPaySuccess {
    WGPaySuccessRequest *request = [[WGPaySuccessRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGPaySuccessResponse class] success:^(JHResponse *response) {
        [weakSelf handlePaySuccessResponse:(WGPaySuccessResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handlePaySuccessResponse:(WGPaySuccessResponse *)response {
    if (response.success) {
        _paySuccessData = response.data;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGPaySuccessViewController (TableViewDelegate)

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

@end
