//
//  WGUseIntegrationViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGUseIntegrationViewController.h"
#import "WGIntegration.h"
#import "WGUseIntegrationRequest.h"
#import "WGUseIntegrationResponse.h"
#import "WGIntegrationHelpView.h"
#import "WGIntegrationRequest.h"
#import "WGIntegrationResponse.h"

@interface WGUseIntegrationViewController ()
{
    JHTableView *_tableView;
    JHLabel *_titleLabel;
    WGIntegration *_integration;
    JHButton *_confirmBtn;
}
@end

@interface WGUseIntegrationViewController (TableViewDelegate) <UITableViewDelegate>

@end

@implementation WGUseIntegrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"UseIntegration_Title");
    [self loadIntegration];
}

- (void)initSubView {
    [super initSubView];
    _tableView = [[JHTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.delegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    _tableView.backgroundColor = kWhiteColor;
    _tableView.tableHeaderView = [self createHeaderView];
    _tableView.tableFooterView = [self createFooterView];
    [self.view addSubview:_tableView];
    //_tableView.layer.opacity = 0.0f;
}

- (void)touchHelp:(id)sender {
    WGIntegrationHelpView *view = [[WGIntegrationHelpView alloc] initWithFrame:self.view.bounds];
    view.tip = _integration.tip;
    [view showInView:self.view];
}

- (UIView *)createHeaderView {
    JHView *headerView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(112 + 40 + 118))];
    
    JHImageView *imageView = [[JHImageView alloc] initWithFrame:CGRectMake((kDeviceWidth - kAppAdaptWidth(112))/2, kAppAdaptHeight(60), kAppAdaptWidth(112), kAppAdaptHeight(112))];
    imageView.image = [UIImage imageNamed:@"integration_image"];
    [headerView addSubview:imageView];
    
    _titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, imageView.maxY, kDeviceWidth, kAppAdaptHeight(118))];
    _titleLabel.font = kAppAdaptFont(16);
    _titleLabel.textColor = WGAppNameLabelColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    [headerView addSubview:_titleLabel];
    
    return headerView;
}

- (void)refreshUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"integration_help"] style:UIBarButtonItemStylePlain target:self action:@selector(touchHelp:)];
    [UIView animateWithDuration:0.5 animations:^() {
        _tableView.layer.opacity = 1.0f;
    }];
    _titleLabel.text = [NSString stringWithFormat:kStr(@"UseIntegration_Tip"), _integration.totalCount, _integration.currentCanUseCount, _integration.money];
    if (_integration.isSelected) {
        [_confirmBtn setTitle:kStr(@"UseIntegration_Cancel_Use") forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:WGAppBaseColor];
    }
    else {
        [_confirmBtn setTitle:kStr(@"UseIntegration_Use") forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:WGAppBlueButtonColor];
    }
}

- (JHView *)createFooterView {
    JHView *footerView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - kAppAdaptHeight(333))];
    _confirmBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(15), 0, kDeviceWidth - kAppAdaptWidth(30), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptHeight(20), kAppAdaptHeight(20), kAppAdaptHeight(20), kAppAdaptHeight(20)) backgroundColor:WGAppBlueButtonColor];
    [_confirmBtn addTarget:self action:@selector(touchCommitBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:kStr(@"UseIntegration_Use") forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = kAppAdaptFont(14);
    [footerView addSubview:_confirmBtn];
    
    return footerView;
}

- (void)touchCommitBtn:(id)sender {
    [self loadUseIntegration];
}

- (void)loadIntegration {
    WGIntegrationRequest *request = [[WGIntegrationRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGIntegrationResponse class] success:^(JHResponse *response) {
        [weakSelf handleIntegrationResponse:(WGIntegrationResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleIntegrationResponse:(WGIntegrationResponse *)response {
    if (response.success) {
        _integration = response.data;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadUseIntegration {
    WGUseIntegrationRequest *request = [[WGUseIntegrationRequest alloc] init];
    request.remove = _integration.isSelected;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGUseIntegrationResponse class] success:^(JHResponse *response) {
        [weakSelf handleUseIntegrationResponse:(WGUseIntegrationResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleUseIntegrationResponse:(WGUseIntegrationResponse *)response {
    if (response.success) {
        if (self.onApply) {
            self.onApply(response.data.price);
        }
        [self refreshUI];
        [self showWarningMessage:response.message onCompletion:^(void) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
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

@implementation WGUseIntegrationViewController (TableViewDelegate)

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

@end
