//
//  WGReceiptListViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/16.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGReceiptListViewController.h"
#import "WGReceiptListCell.h"
#import "WGReceipt.h"
#import "WGEditReceiptViewController.h"

@interface WGReceiptListViewController ()
{
    TWRefreshTableView  *_tableView;
}
@end

@interface WGReceiptListViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource, TWTableViewRefreshingDelegate>

@end

@implementation WGReceiptListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData {
    WGReceipt *receipt = [[WGReceipt alloc] init];
    receipt.taxCode = @"123";
    receipt.companyName = @"TaiYuanLiGong";
    receipt.cap = @"FSDFASD";
    
    WGReceipt *receipt2 = [[WGReceipt alloc] init];
    receipt2.taxCode = @"3FADDAS";
    receipt2.companyName = @"TaiYuanLiGong";
    receipt2.cap = @"WKZFSFSDFASD";
    
    WGReceipt *receipt3 = [[WGReceipt alloc] init];
    receipt3.taxCode = @"943SKDFA";
    receipt3.companyName = @"DalIfasdf TaiYuanLiGong";
    receipt3.cap = @"FASD WKZFSFSDFASD";
    
    _dataArray = @[receipt, receipt2, receipt3];
}

- (void)initSubView {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:kStr(@"") style:UIBarButtonItemStylePlain target:self action:@selector(touchClearBtn:)];
    
    _tableView = [[TWRefreshTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.refreshDelegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    JHButton *addBtn = [[JHButton alloc] initWithFrame:CGRectMake(kDeviceWidth - kAppAdaptWidth(56 + 16), kDeviceHeight - kAppAdaptHeight(56 + 16), kAppAdaptWidth(56), kAppAdaptHeight(56))];
    [addBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(touchAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
}

- (void)touchAddBtn:(JHButton *)sender {
    WGEditReceiptViewController *editReceiptViewController = [[WGEditReceiptViewController alloc] init];
    editReceiptViewController.onApply = ^() {
        [self handleEditReceiptCompletion];
    };
    [self.navigationController pushViewController:editReceiptViewController animated:YES];
}

- (void)handleEditReceiptCompletion {
    //request list
}

- (void)touchClearBtn:(id)sender {
    //after request complete
    if (self.onClear) {
        self.onClear();
    }
}

- (void)refreshTableView {
    [_tableView reloadData];
}

- (void)handleDefault:(WGReceipt *)receipt {
    
}

- (void)handleUse:(WGReceipt *)receipt {
    if (self.onUse) {
        self.onUse(receipt);
    }
}

- (void)handleModify:(WGReceipt *)receipt {
    WGEditReceiptViewController *editReceiptViewController = [[WGEditReceiptViewController alloc] init];
    editReceiptViewController.receipt = receipt;
    editReceiptViewController.onApply = ^() {
        [self handleEditReceiptCompletion];
    };
    [self.navigationController pushViewController:editReceiptViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation WGReceiptListViewController (TableViewDelegate)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (section == 0) ? 0 : kAppAdaptHeight(8);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAppAdaptHeight(136);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        WGReceiptListCell *receiptCell = [[WGReceiptListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        __weak id weakSelf = self;
        receiptCell.onDefault = ^(WGReceipt *receipt) {
            [weakSelf handleDefault:receipt];
        };
        receiptCell.onUse = ^(WGReceipt *receipt) {
            [weakSelf handleUse:receipt];
        };
        receiptCell.onModify = ^(WGReceipt *receipt) {
            [weakSelf handleModify:receipt];
        };
        cell = receiptCell;
    }
    [cell showWithData:_dataArray[indexPath.section]];
    return cell;
}

- (void)beginRefreshHeader:(TWRefreshTableView *)tableView {
    
}

- (void)beginRefreshFooter:(TWRefreshTableView *)tableView {

}

@end
