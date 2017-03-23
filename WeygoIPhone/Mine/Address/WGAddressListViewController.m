//
//  WGAddressListViewController.m
//  WeygoIPhone
//
//  Created by muma on 2017/1/17.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGAddressListViewController.h"
#import "WGAddress.h"
#import "WGAddressListCell.h"
#import "WGEditAddressViewController.h"

@interface WGAddressListViewController ()

@end

@implementation WGAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"Address_Title");
}

- (void)initData {
    WGAddress *address = [[WGAddress alloc] init];
    address.name = @"郑渊";
    address.phone = @"5ee023233";
    address.address = @"FSDFASD";
    
    WGAddress *address1 = [[WGAddress alloc] init];
    address1.name = @"郑渊";
    address1.phone = @"023233";
    address1.address = @"FSDFASD";
    
    WGAddress *address2 = [[WGAddress alloc] init];
    address2.name = @"郑渊谦";
    address2.phone = @"7889023233";
    address2.address = @"FSDFASD";
    
    _dataMArray = [NSMutableArray arrayWithArray:@[address, address1, address2]];
}

- (Class)cellClass {
    return [WGAddressListCell class];
}

- (void)touchAddBtn:(JHButton *)sender {
    WGEditAddressViewController *editAddressViewController = [[WGEditAddressViewController alloc] init];
    __weak id weakSelf = self;
    editAddressViewController.onApply = ^() {
        [weakSelf handleEditAddressCompletion];
    };
    [self.navigationController pushViewController:editAddressViewController animated:YES];
}

- (void)handleEditAddressCompletion {
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
    WGEditAddressViewController *editReceiptViewController = [[WGEditAddressViewController alloc] init];
    editReceiptViewController.address = (WGAddress *)object;
    __weak id weakSelf = self;
    editReceiptViewController.onApply = ^() {
        [weakSelf handleEditAddressCompletion];
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
