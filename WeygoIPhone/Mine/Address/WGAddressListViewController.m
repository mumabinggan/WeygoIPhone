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
#import "WGAddressListViewController+Request.h"

@interface WGAddressListViewController ()

@end

@implementation WGAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = kStr(@"Address_Title");
    [self loadAddressList];
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
    [self.navigationController popToViewController:self animated:YES];
}

- (void)handleDefault:(WGObject *)object {
    WGAddress *address = (WGAddress *)object;
    [self loadSetDefaultAddress:address];
}

- (void)handleUse:(WGObject *)object {
    if (self.onUse) {
        self.onUse(object);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleDeleteIndexPath:(NSIndexPath *)indexPath {
    WGAddress *address = _dataMArray[indexPath.section];
    [self loadDeleteAddress:address];
}

- (void)handleModify:(WGObject *)object {
    WGEditAddressViewController *editReceiptViewController = [[WGEditAddressViewController alloc] init];
    editReceiptViewController.addressId = ((WGAddress *)object).addressId;
    __weak id weakSelf = self;
    editReceiptViewController.onApply = ^() {
        [weakSelf handleEditAddressCompletion];
    };
    [self.navigationController pushViewController:editReceiptViewController animated:YES];
}

- (void)didReceiveNotification:(NSInteger)notification {
    if (notification == WGRefreshNotificationTypeChangeAddress) {
        [self loadAddressList];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [WGAddressListCell heightWithData:_dataMArray[indexPath.section]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
