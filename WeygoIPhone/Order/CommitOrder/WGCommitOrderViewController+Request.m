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
#import "WGUpdateOrderCouponRequest.h"
#import "WGUpdateOrderCouponResponse.h"
#import "WGCommitOrderDetail.h"
#import "WGPaySuccessViewController.h"
#import "WGPayWebViewController.h"

@implementation WGCommitOrderViewController (Request)

- (void)loadSettlementResultDetail {
    WGSettlementResultRequest *request = [[WGSettlementResultRequest alloc] init];
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGSettlementResultResponse class] success:^(JHResponse *response) {
        [weakSelf handleSettlementResultResponse:(WGSettlementResultResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleSettlementResultResponse:(WGSettlementResultResponse *)response {
    if (response.success) {
        _commitOrderDetail = [[WGCommitOrderDetail alloc] initWithSettlementResult:response.data];
        [self refreshUI];
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
                
                __weak WGCommitOrderViewController *weakSelf = self;
                [self showWarningMessage:response.message onCompletion:^(void) {
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }];
            }
            else {
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
    else {
        [self showWarningMessage:response.message];
    }
}

- (void)loadUpdateOrderCoupon {
    WGUpdateOrderCouponRequest *request = [[WGUpdateOrderCouponRequest alloc] init];
    request.settlementId = self.settlementId;
    request.couponId = _commitOrderDetail.coupon.id;
    __weak typeof(self) weakSelf = self;
    [self post:request forResponseClass:[WGUpdateOrderCouponResponse class] success:^(JHResponse *response) {
        [weakSelf handleUpdateOrderCouponResponse:(WGUpdateOrderCouponResponse *)response];
    } failure:^(NSError *error) {
        [weakSelf showWarningMessage:kStr(@"Request Failed")];
    }];
}

- (void)handleUpdateOrderCouponResponse:(WGUpdateOrderCouponResponse *)response {
    if (response.success) {
        _commitOrderDetail.consumePrice = response.data;
        [self refreshUI];
    }
    else {
        [self showWarningMessage:response.message];
    }
}

@end
