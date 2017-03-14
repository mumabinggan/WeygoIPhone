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

@interface WGClientServiceCenterViewController ()
{
    JHTableView *_tableView;
    NSArray *_titleArray;
}
@end

@interface WGClientServiceCenterViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGClientServiceCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData {
    _titleArray = @[kStr(@"Chi siamo"), kStr(@"Come funziona"),
                    kStr(@"Contatti"), kStr(@"FAQ"),
                    kStr(@"Aiutaci a migliorare"),
                    kStr(@"Condizioni generali di vendita"),
                    kStr(@"Garanzia legale di"),
                    kStr(@"Privacy e cookies"),
                    kStr(@"Suggerimenti")];
}

- (void)initSubView {
    self.title = kStr(@"Servizio clienti");
    JHView *contentView = [[JHView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:contentView];
    
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //_tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    _tableView.backgroundColor = kWhiteColor;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    _tableView.tableFooterView = [self createFooterView];
    [contentView addSubview:_tableView];
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
    //to chat web
    WGBaseWebViewController *vc = [[WGBaseWebViewController alloc] initWithURLAddress:@"http://www.baidu.com"];
    vc.title = kStr(@"Live Chat");
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGClientServiceCenterViewController (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
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
    cell.textLabel.text = _titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        //FAQ
        WGBaseWebViewController *vc = [[WGBaseWebViewController alloc] initWithURLAddress:@"http://www.baidu.com"];
        vc.title = _titleArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        //Other
        WGCSCStyle1ViewController *vc = [[WGCSCStyle1ViewController alloc] init];
        vc.type = indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
