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

@end

@interface WGReceiptListViewController (TableViewDelegate) <UITableViewDelegate, UITableViewDataSource, TWTableViewRefreshingDelegate>

@end

@implementation WGReceiptListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"ReceiptList_Title");
}

- (void)initData {
    WGReceipt *receipt = [[WGReceipt alloc] init];
    receipt.taxCode = @"123";
    receipt.companyName = @"TaiYuanLiGong";
    receipt.address = @"FSDFASD";
    
    WGReceipt *receipt2 = [[WGReceipt alloc] init];
    receipt2.taxCode = @"3FADDAS";
    receipt2.companyName = @"TaiYuanLiGong";
    receipt2.address = @"WKZFSFSDFASD";
    
    WGReceipt *receipt3 = [[WGReceipt alloc] init];
    receipt3.taxCode = @"943SKDFA";
    receipt3.companyName = @"DalIfasdf TaiYuanLiGong";
    receipt3.address = @"FASD WKZFSFSDFASD";
    
    _dataMArray = [NSMutableArray arrayWithArray:@[receipt, receipt2, receipt3]];
}

- (Class)cellClass {
    return [WGReceiptListCell class];
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

- (void)handleDefault:(WGObject *)object {
    
}

- (void)handleUse:(WGObject *)object {
    if (self.onUse) {
        self.onUse(object);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleModify:(WGObject *)object {
    WGEditReceiptViewController *editReceiptViewController = [[WGEditReceiptViewController alloc] init];
    editReceiptViewController.receipt = (WGReceipt *)object;
    __weak id weakSelf = self;
    editReceiptViewController.onApply = ^() {
        [weakSelf handleEditReceiptCompletion];
    };
    [self.navigationController pushViewController:editReceiptViewController animated:YES];
}

- (void)beginRefreshHeader {
    
}

- (void)beginRefreshFooter {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
