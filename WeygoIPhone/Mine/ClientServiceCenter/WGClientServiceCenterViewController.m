//
//  WGClientServiceCenterViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/5.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGClientServiceCenterViewController.h"
#import "WGCSCStyle1ViewController.h"
#import "WGBaseWebViewController.h"
#import "WGBaseWebViewController.h"
#import "WGClientServiceCenterRequest.h"
#import "WGClientServiceCenterResponse.h"
#import <ZDCChat/ZDCChat.h>

@interface WGClientServiceCenterViewController ()
{
    JHTableView *_tableView;
    NSArray *_dataArray;
}
@end

@interface WGClientServiceCenterViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@interface WGClientServiceCenterViewController (Request)

- (void)loadClientServiceCenter;

@end

@implementation WGClientServiceCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadClientServiceCenter];
}

- (void)initSubView {
    [super initSubView];
    self.title = kStr(@"Servizio clienti");
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:contentView];
    
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = kWhiteColor;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    _tableView.tableFooterView = [self createFooterView];
    [contentView addSubview:_tableView];
    _tableView.layer.opacity = 0.0f;
}

- (JHView *)createFooterView {
    JHView *footerView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(151))];
    JHButton *chatBtn = [[JHButton alloc] initWithFrame:CGRectMake(kAppAdaptWidth(32), footerView.height - kAppAdaptHeight(60), kAppAdaptWidth(311), kAppAdaptHeight(40)) difRadius:JHRadiusMake(kAppAdaptHeight(20), kAppAdaptHeight(20), kAppAdaptHeight(20), kAppAdaptHeight(20)) backgroundColor:WGAppBlueButtonColor];
    [chatBtn setImage:[UIImage imageNamed:@"live_chat"] forState:UIControlStateNormal];
    [chatBtn setTitle:[NSString stringWithFormat:@"  %@", kStr(@"Live Chat")] forState:UIControlStateNormal];
    chatBtn.titleLabel.font = kAppAdaptFont(14);
    [chatBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [chatBtn addTarget:self action:@selector(touchChatBtn:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:chatBtn];
    return footerView;
}

- (void)touchChatBtn:(UIButton *)sender {
    // start a chat in a new modal
    [ZDCChat startChatIn:self.navigationController withConfig:^(ZDCConfig *config) {
        config.preChatDataRequirements.name = ZDCPreChatDataOptionalEditable;
        config.preChatDataRequirements.email = ZDCPreChatDataOptionalEditable;
        config.preChatDataRequirements.phone = ZDCPreChatDataOptionalEditable;
        config.preChatDataRequirements.department = ZDCPreChatDataOptionalEditable;
        config.preChatDataRequirements.message = ZDCPreChatDataOptionalEditable;
    }];
}

- (void)refreshUI {
    [_tableView reloadData];
    [UIView animateWithDuration:0.05 animations:^() {
        _tableView.layer.opacity = 1.0f;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGClientServiceCenterViewController (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAppAdaptHeight(48);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = WGAppLightNameLabelColor;
        cell.textLabel.font = kAppAdaptFont(14);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    WGClientServiceCenterItem *item = _dataArray[indexPath.row];
    cell.textLabel.text = item.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WGClientServiceCenterItem *item = _dataArray[indexPath.row];
    WGBaseWebViewController *vc = [[WGBaseWebViewController alloc] initWithURLAddress:item.url];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

@implementation WGClientServiceCenterViewController (Request)

- (void)loadClientServiceCenter {
    WGClientServiceCenterRequest *request = [[WGClientServiceCenterRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self get:request forResponseClass:[WGClientServiceCenterResponse class] success:^(JHResponse *response) {
        [weakSelf handleClientServiceCenterResponse:(WGClientServiceCenterResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleClientServiceCenterResponse:(WGClientServiceCenterResponse *)response {
    if (response.success) {
        _dataArray = response.data;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
