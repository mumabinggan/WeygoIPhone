//
//  WGCommitOrderViewController+Request.m
//  WeygoIPhone
//
//  Created by muma on 2017/3/20.
//  Copyright © 2017年 weygo.com. All rights reserved.
//

#import "WGCommitOrderViewController+Request.h"
#import "WGCommitOrderRequest.h"
#import "WGCommitOrderResponse.h"
#import "WGSettlementResultRequest.h"
#import "WGSettlementResultResponse.h"
#import "WGCommitOrderDetail.h"
#import "WGPaySuccessViewController.h"
#import "WGPayWebViewController.h"
#import "WGApplication.h"
#import "WGOverHeightRequest.h"
#import "WGOverHeightResponse.h"
#import "WGOverHeightDeleteRequest.h"
#import "WGOverHeightDeleteResponse.h"
#import "WGOverHeightResetRequest.h"
#import "WGOverHeightResetResponse.h"
#import "WGOverweightView.h"
#import "WGOverHeightGoodItem.h"

@implementation WGCommitOrderViewController (Request)

- (void)loadSettlementResultDetail {
    WGSettlementResultRequest *request = [[WGSettlementResultRequest alloc] init];
    request.addressId = _commitOrderDetail.address.addressId;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGSettlementResultResponse class] success:^(JHResponse *response) {
        [weakSelf handleSettlementResultResponse:(WGSettlementResultResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleSettlementResultResponse:(WGSettlementResultResponse *)response {
    if (response.success) {
        [[WGEvent shareInstance] checkOutStart:@([WGApplication sharedApplication].user.userId).stringValue sum:@(response.data.goodsCount).stringValue];
        _commitOrderDetail = [[WGCommitOrderDetail alloc] initWithSettlementResult:response.data];
        [self refreshUI];
        if (response.data.overHeightDetail && response.data.overHeightDetail.count > 0) {
            _overWeightArray = response.data.overHeightDetail;
            [self showOverWeightView];
        }
    }
    else if (response.emptyShopCart) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadCommitOrder {
    WGCommitOrderRequest *request = [[WGCommitOrderRequest alloc] init];
    request.addressId = _commitOrderDetail.address.addressId;
    
    WGReceipt *receipt = _commitOrderDetail.receipt;
    request.useBilling = receipt ? 1 : 0;
    request.billingCompanyName = receipt.companyName;
    request.billingCountry = receipt.countryId;
    request.billingPhone = receipt.phone;
    request.billingAddress = receipt.address;
    request.billingCivico = receipt.civico;
    request.billingCity = receipt.city;
    request.billingCap = receipt.cap;
    request.billingProvince = receipt.province;
    request.billingTaxCode = receipt.taxCode;
    
    WGCommitOrderDeliverTime *time = _commitOrderDetail.deliverTime;
    request.deliverDate = time.currentDateId;
    request.deliverTime = time.currentTimeId;
    
    WGCommitOrderPay *pay = _commitOrderDetail.payMothod;
    request.payMethod = pay.currentPayId;
    
    request.comments = _commitOrderDetail.remark;
    
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGCommitOrderResponse class] success:^(JHResponse *response) {
        [weakSelf handleCommitOrderResponse:(WGCommitOrderResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleCommitOrderResponse:(WGCommitOrderResponse *)response {
    if (response.success) {
        if ([NSString isNullOrEmpty:response.data.action]) {
            if ([NSString isNullOrEmpty:response.data.orderId]) {
                //[[WGEvent shareInstance] purchase:@([WGApplication sharedApplication].user.userId).stringValue sum:@(response.data.goodsCount).stringValue];
                __weak WGCommitOrderViewController *weakSelf = self;
                [self showWarningMessage:response.message onCompletion:^(void) {
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }];
            }
            else {
                [[WGEvent shareInstance] purchase:_commitOrderDetail.consumePrice.currentTotalPriceUnUnit orderId:response.data.orderId];
                WGPaySuccessViewController *vc = [[WGPaySuccessViewController alloc] init];
                vc.orderId = response.data.orderId;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        else {
            WGPayWebViewController *vc = [[WGPayWebViewController alloc] initWithOrderData:response.data];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (response.overWeight) {
        [self loadOverHeightDetail];
    }
    else if (response.belowMinPrice) {
        [self showWarningMessage:response.message];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadOverHeightDetail {
    WGOverHeightRequest *request = [[WGOverHeightRequest alloc] init];
    request.addressId = @(_commitOrderDetail.address.addressId).stringValue;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGOverHeightResponse class] success:^(JHResponse *response) {
        [weakSelf handleOverHeightDetailResponse:(WGOverHeightResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleOverHeightDetailResponse:(WGOverHeightResponse *)response {
    if (response.success) {
        if (response.data) {
            _overWeightArray = response.data.overWeight;
            [_commitOrderDetail.deliverTime resetWithTimes:response.data.deliverTimes];
            _commitOrderDetail.minPriceTips = response.data.minPriceTips;
            _commitOrderDetail.consumePrice = response.data.price;
            [_tableView reloadData];
            if (_overWeightArray) {
                [self showOverWeightView];
            }
        }
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadDeleteOverHeight {
    WGOverHeightDeleteRequest *request = [[WGOverHeightDeleteRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGOverHeightDeleteResponse class] success:^(JHResponse *response) {
        [weakSelf handleDeleteOverHeightResponse:(WGOverHeightDeleteResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleDeleteOverHeightResponse:(WGOverHeightDeleteResponse *)response {
    if (response.success) {
        [self loadSettlementResultDetail];
        [_overWeightView close];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadOverHeightReset:(NSArray *)array {
    WGOverHeightResetRequest *request = [[WGOverHeightResetRequest alloc] init];
    NSMutableArray *ids = [[NSMutableArray alloc] init];
    NSMutableArray *counts = [[NSMutableArray alloc] init];
    WGOverHeightDetail *detail = array[0];
    for (WGOverHeightGoodItem *item in detail.goods) {
        [ids addObject:@(item.shopCartId).stringValue];
        [counts addObject:@(item.goodCount).stringValue];
    }
    request.goodIds = [ids join:@","];
    request.goodCounts = [counts join:@","];
    WeakSelf;
    [self post:request forResponseClass:[WGOverHeightResetResponse class] success:^(JHResponse *response) {
        [weakSelf handleOverHeightResetResponse:(WGOverHeightResetResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleOverHeightResetResponse:(WGOverHeightResetResponse *)response {
    if (response.success) {
        [self loadSettlementResultDetail];
        [_overWeightView close];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
