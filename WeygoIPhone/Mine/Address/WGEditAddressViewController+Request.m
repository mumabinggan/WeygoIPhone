//
//  WGEditAddressViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGEditAddressViewController+Request.h"
#import "WGAddAddressRequest.h"
#import "WGAddAddressResponse.h"
#import "WGAddressDetailResponse.h"
#import "WGAddressDetailRequest.h"
#import "WGAddressCityListResponse.h"
#import "WGAddressCityListRequest.h"

@implementation WGEditAddressViewController (Request)

- (void)loadAddressDetail {
    WGAddressDetailRequest *request = [[WGAddressDetailRequest alloc] init];
    request.id = self.addressId;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGAddressDetailResponse class] success:^(JHResponse *response) {
        [weakSelf handleAddressDetailResponse:(WGAddressDetailResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleAddressDetailResponse:(WGAddressDetailResponse *)response {
    if (response.success) {
        _address = response.data;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadAddAddress {
    WGAddAddressRequest *request = [[WGAddAddressRequest alloc] init];
    request.id = self.addressId;
    request.firstname = _address.firstName;
    request.lastname = _address.lastName;
    request.address = _address.address;
    request.street = _address.streetNumber;
    request.city = _address.cityId;
    request.countryId = _address.countryId;
    request.cap = _address.cap;
    request.telephone = _address.phone;
    request.hasLift = _address.ascensore;
    request.floor = _address.piano;
    request.floorHole = _address.scala;
    request.doorbell = _address.citofono;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGAddAddressResponse class] success:^(JHResponse *response) {
        [weakSelf handleAddAddressResponse:(WGAddAddressResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleAddAddressResponse:(WGAddAddressResponse *)response {
    if (response.success) {
        [self sendNotification:WGRefreshNotificationTypeChangeAddress];
        WeakSelf;
        [self.navigationController popViewControllerAnimated:YES];
//        [self showWarningMessage:response.message onCompletion:^() {
//            [weakSelf.navigationController popViewControllerAnimated:YES];
//        }];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadAddressCitys {
    WGAddressCityListRequest *request = [[WGAddressCityListRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGAddressCityListResponse class] success:^(JHResponse *response) {
        [weakSelf handleAddressCityListResponse:(WGAddressCityListResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleAddressCityListResponse:(WGAddressCityListResponse *)response {
    if (response.success) {
        _cityArray = response.data;
        for (WGAddressCityListItem *item in _cityArray) {
            if ([item.value isEqualToString:_address.cityId]) {
                _address.city = item.name;
                break;
            }
        }
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
