//
//  WGEditReceiptViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/4/9.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGEditReceiptViewController+Request.h"
#import "WGReceiptCountryListRequest.h"
#import "WGReceiptCountryListResponse.h"

@implementation WGEditReceiptViewController (Request)

- (void)loadReceiptCountry {
    WGReceiptCountryListRequest *request = [[WGReceiptCountryListRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGReceiptCountryListResponse class] success:^(JHResponse *response) {
        [weakSelf handleReceiptCountryListResponse:(WGReceiptCountryListResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleReceiptCountryListResponse:(WGReceiptCountryListResponse *)response {
    if (response.success) {
        _countryArray = response.data;
        for (WGReceiptCountryListItem *item in _countryArray) {
            if ([item.value isEqualToString:self.receipt.countryId]) {
                self.receipt.country = item.label;
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
