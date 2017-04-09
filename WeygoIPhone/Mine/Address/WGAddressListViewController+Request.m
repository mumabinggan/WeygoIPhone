//
//  WGAddressListViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGAddressListViewController+Request.h"
#import "WGAddressListRequest.h"
#import "WGAddressListResponse.h"
#import "WGDeleteAddressRequest.h"
#import "WGDeleteAddressResponse.h"
#import "WGSetDefaultAddressRequest.h"
#import "WGSetDefaultAddressResponse.h"
#import "WGAddress.h"

@implementation WGAddressListViewController (Request)

- (void)loadAddressList {
    WGAddressListRequest *request = [[WGAddressListRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGAddressListResponse class] success:^(JHResponse *response) {
        [weakSelf handleAddressListResponse:(WGAddressListResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleAddressListResponse:(WGAddressListResponse *)response {
    if (response.success) {
        [_dataMArray setArray:response.data];
        [self refreshTableView];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadDeleteAddress:(WGAddress *)address {
    WGDeleteAddressRequest *request = [[WGDeleteAddressRequest alloc] init];
    request.id = address.addressId;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGDeleteAddressResponse class] success:^(JHResponse *response) {
        [weakSelf handleDeleteAddressResponse:(WGDeleteAddressResponse *)response addressId:address.addressId];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleDeleteAddressResponse:(WGDeleteAddressResponse *)response addressId:(long long)addressId {
    if (response.success) {
        for (WGAddress *address in _dataMArray) {
            if (address.addressId == addressId) {
                [_dataMArray removeObject:address];
                break;
            }
        }
        [self refreshTableView];
        [self loadAddressList];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadSetDefaultAddress:(WGAddress *)address {
    WGSetDefaultAddressRequest *request = [[WGSetDefaultAddressRequest alloc] init];
    request.id = address.addressId;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGSetDefaultAddressResponse class] success:^(JHResponse *response) {
        [weakSelf handleSetDefaultAddressResponse:(WGSetDefaultAddressResponse *)response address:address];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleSetDefaultAddressResponse:(WGSetDefaultAddressResponse *)response address:(WGAddress *)address {
    if (response.success) {
        for (WGAddress *address in _dataMArray) {
            address.isDefault = NO;
        }
        address.isDefault = YES;
        [self refreshTableView];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
