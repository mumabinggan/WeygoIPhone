//
//  WGIntegrationViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/10.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGIntegrationViewController.h"
#import "WGIntegrationDetailRequest.h"
#import "WGIntegrationDetailResponse.h"
#import "WGIntegrationHelpView.h"

@interface WGIntegrationViewController ()
{
    WGIntegrationDetail *_integrationDetail;
    TWRefreshTableView *_tableView;
    JHLabel *_titleLabel;
}
@end

@interface WGIntegrationViewController (TableViewDelegate)<UITableViewDelegate, UITableViewDataSource, TWTableViewRefreshingDelegate>

@end

@implementation WGIntegrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"Integration_Title");
    [self loadIntegrationDetailResponse:YES pulling:NO];
}

- (void)initData {
    [super initData];
    _integrationDetail = [[WGIntegrationDetail alloc] init];
//    WGIntegrationHistoryItem *item = [[WGIntegrationHistoryItem alloc] init];
//    item.integration = @"+4s3";
//    item.des = @"asdfasdfaswww";
//    item.time = @"asdfa";
//    
//    WGIntegrationHistoryItem *item1 = [[WGIntegrationHistoryItem alloc] init];
//    item1.integration = @"+f43";
//    item1.des = @"asdfasdfas";
//    item1.time = @"asdfa";
//    
//    WGIntegrationHistoryItem *item2 = [[WGIntegrationHistoryItem alloc] init];
//    item2.integration = @"+643";
//    item2.des = @"asdfasdfasfada";
//    item2.time = @"asdfa111";
//    
//    _integrationDetail.history = @[item, item1, item2];
}

- (void)initSubView {
    [super initSubView];
    
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped refreshType:TWRefreshTypeBottom];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.refreshDelegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = [self createHeaderView];
    [self.view addSubview:_tableView];
    _tableView.layer.opacity = 0.0f;
}

- (UIView *)createHeaderView {
    JHView *headerView = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppAdaptHeight(112 + 40 + 118))];
    headerView.backgroundColor = kWhiteColor;
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

- (void)touchHelp:(id)sender {
    WGIntegrationHelpView *view = [[WGIntegrationHelpView alloc] initWithFrame:self.view.bounds];
    view.tip = _integrationDetail.tip;
    [view showInView:self.view];
}

- (void)refreshUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"integration_help"] style:UIBarButtonItemStylePlain target:self action:@selector(touchHelp:)];
    [_tableView reloadData];
    [UIView animateWithDuration:0.5 animations:^() {
        _tableView.layer.opacity = 1.0f;
    }];
    _titleLabel.text = [NSString stringWithFormat:kStr(@"Integration_Reduce_Count"), _integrationDetail.totalCount];
    [_titleLabel setPartString:@(_integrationDetail.totalCount).stringValue attributes:@{NSForegroundColorAttributeName : WGAppBaseColor}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadIntegrationDetailResponse:(BOOL)refresh pulling:(BOOL)pulling {
    WGIntegrationDetailRequest *request = [[WGIntegrationDetailRequest alloc] init];
//    request.pageId = (refresh) ? 0 : _integrationDetail.history.count;
//    if (pulling) {
//        request.showsLoadingView = NO;
//    }
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGIntegrationDetailResponse class] success:^(JHResponse *response) {
        [weakSelf handleIntegrationDetailResponse:(WGIntegrationDetailResponse *)response refresh:refresh pulling:pulling];
    } failure:^(NSError *error) {
        [weakSelf handleIntegrationDetailResponse:nil refresh:refresh pulling:pulling];
    }];
}

- (void)handleIntegrationDetailResponse:(WGIntegrationDetailResponse *)response refresh:(BOOL)refresh pulling:(BOOL)pulling {
    [self stopRefreshing:_tableView refresh:refresh pulling:pulling];
    if (!response) {
        [self showWarningMessage:kStr(@"Request Failed")];
        return;
    }
    if (response.success) {
        if (response.data) {
            NSMutableArray *history = [NSMutableArray array];
            if (!refresh) {
                [history addObjectsFromArray:_integrationDetail.history];
            }
            [history arrayByAddingObjectsFromArray:response.data.history];
            _integrationDetail.history = history;
            _integrationDetail.totalCount = response.data.totalCount;
        }
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end

@implementation WGIntegrationViewController (TableViewDelegate)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_integrationDetail.hasHistory) {
        return _integrationDetail.history.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (_integrationDetail.hasHistory) ? kAppAdaptHeight(30) : 0.1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_integrationDetail && _integrationDetail.history && _integrationDetail.history.count > 0) {
        return kStr(@"Integration_Use_History");
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAppAdaptHeight(48);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.textLabel.textColor = WGAppTitleColor;
        cell.detailTextLabel.textColor = WGAppNameLabelColor;
        cell.textLabel.font = cell.detailTextLabel.font = kAppAdaptFont(12);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        JHView *line = [[JHView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kAppSepratorLineHeight)];
        line.backgroundColor = WGAppSeparateLineColor;
        [cell.contentView addSubview:line];
    }
    if (_integrationDetail && _integrationDetail.history && _integrationDetail.history.count > indexPath.row) {
        WGIntegrationHistoryItem *item = _integrationDetail.history[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@   %@", item.des, item.integration];
        [cell.textLabel setPartString:item.integration attributes:@{NSForegroundColorAttributeName : WGAppBaseColor}];
        cell.detailTextLabel.text = item.time;
        [cell showWithData:_integrationDetail.history[indexPath.row]];
    }
    return cell;
}

- (void)beginRefreshHeader:(TWRefreshTableView *)tableView {
    [self loadIntegrationDetailResponse:YES pulling:YES];
}

- (void)beginRefreshFooter:(TWRefreshTableView *)tableView {
    [self loadIntegrationDetailResponse:NO pulling:YES];
}

@end
